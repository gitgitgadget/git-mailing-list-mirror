From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Added test case for stg refresh
Date: Thu, 22 Nov 2007 08:15:57 +0000
Message-ID: <b0943d9e0711220015r64d1a5c2y25dfa44610864c99@mail.gmail.com>
References: <87tznfvqb4.fsf@lysator.liu.se> <87oddnvpzf.fsf@virtutech.se>
	 <20071121231553.GA19422@diana.vm.bytemark.co.uk>
	 <b0943d9e0711211531v2f7b9c0bl99033c0bd58971c7@mail.gmail.com>
	 <871waivhgq.fsf@virtutech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Nov 22 09:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv7ER-0002Zv-1a
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 09:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbXKVIP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 03:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbXKVIP7
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 03:15:59 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:7806 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbXKVIP6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 03:15:58 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2312399rvb
        for <git@vger.kernel.org>; Thu, 22 Nov 2007 00:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+oxj0r12LIC9ec8qJFPk2RZ7aBwWPROJgyIq1s/r5/w=;
        b=CQ+quBj8TEnWekPxNzmUnB25cN+1BEmkbK79nFv0qrnJ/MhPs35yBrfWV8kQzQiWa6yGEJ6sujvDwZMne9AB5x2obPa8eFEBgw9VbKNiXVolGTYfvn5wv0gxEg+hQBN3/Lw/mmFeVAKB8BpxGUJvOpHe5HQbnhJiZ9HbiZbYnts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nb0X/ppWm1cbdGr3tw7UJDsl9/eoMMcp3lYVuxAApQIpXD+4CsbwosQXe+ThmVzpOxgYvNnmVk6E30FA8FS+SwB9hw3Lqc51l1X88u+TqT3WQSbqAtVzQCoTcJ4RNKAL6iO01rsAA0yVSsNnI7+Gm9cqRGcrJIp49lVOuvAQuj8=
Received: by 10.140.251.1 with SMTP id y1mr3798999rvh.1195719357888;
        Thu, 22 Nov 2007 00:15:57 -0800 (PST)
Received: by 10.141.170.11 with HTTP; Thu, 22 Nov 2007 00:15:57 -0800 (PST)
In-Reply-To: <871waivhgq.fsf@virtutech.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65749>

On 22/11/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
> > I noticed the weirdness few days ago and fixed it in
> > e8813959aa3a7c41ffef61d06068b10519bd4830 (though no test caught it)=
=2E
> > Do you still see problems after this commit?
>
> The problem I see is that there still is no test case. That is bad an=
d
> means that it could break again tomorrow without anyone noticing.
>
> Luckily, I just wrote one for you :-)

Thanks :-). We are still far from testing all the possible
combinations. Is there a way to do code coverage in Python?

--=20
Catalin
