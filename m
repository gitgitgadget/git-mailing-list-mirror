From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2/2] Add 'stg uncommit' command
Date: Mon, 20 Feb 2006 17:20:47 +0000
Message-ID: <b0943d9e0602200920v10ef8788o@mail.gmail.com>
References: <20060217042728.14175.39928.stgit@backpacker.hemma.treskal.com>
	 <20060217043128.14175.60168.stgit@backpacker.hemma.treskal.com>
	 <43F84D9A.2010905@gmail.com>
	 <20060219134558.GA4784@diana.vm.bytemark.co.uk>
	 <20060219144752.GA5541@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 18:21:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBEiT-0004Bc-7Z
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 18:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWBTRUu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 20 Feb 2006 12:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbWBTRUt
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 12:20:49 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:15591 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161067AbWBTRUt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 12:20:49 -0500
Received: by xproxy.gmail.com with SMTP id r21so683428wxc
        for <git@vger.kernel.org>; Mon, 20 Feb 2006 09:20:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OrLRHfMlhnwBb/g/MnJzRW/Dut0gMmrhaTDpakJPT8qMdZ6KUH8UkNH+TGLQTkaoVpcjWOZYBMP2HFkHyu0QLkTN3q16hAKwZGgd1izb1nrg6FIfk9ZQCuRMmsdzZQZyYoL5wVcqC14V4Pjz78U0dPkWi1EVEap/BNbM+axdFjo=
Received: by 10.70.61.11 with SMTP id j11mr4027119wxa;
        Mon, 20 Feb 2006 09:20:47 -0800 (PST)
Received: by 10.70.31.16 with HTTP; Mon, 20 Feb 2006 09:20:47 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <20060219144752.GA5541@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16485>

On 19/02/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> By the way, it seems like my name got munged when you edited the
> commit.

I fixed the escaping in the name_email* functions (I'll push it
tonight). It was adding a \ for every character it didn't know. It now
only escapes the quotes and back-slashes. This is needed when passing
the strings via the GIT_AUTHOR_* variables.

--
Catalin
