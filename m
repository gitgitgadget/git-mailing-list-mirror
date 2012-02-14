From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] test: check that "git blame -e" uses mailmap
 correctly
Date: Tue, 14 Feb 2012 15:59:30 -0600
Message-ID: <20120214215930.GD9651@burratino>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <20120214203431.GB13210@burratino>
 <20120214203603.GD13210@burratino>
 <CAMP44s2M8Ava6xyKX32h9+pbxG+zq1wH1RkdWwfNsZMzcVQEmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:59:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQPd-0005DT-8S
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471Ab2BNV7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 16:59:43 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33822 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282Ab2BNV7m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:59:42 -0500
Received: by ggnh1 with SMTP id h1so344221ggn.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 13:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TxiZhH5Y9CUhx63+B4n4Uu9IFfbw4TiVL5Lzo7Nyk1E=;
        b=Q5ztY0CC42ss3Lz6HKpQLQZqLl/JYgdz46IEHEmDvEPJXdhtnOuQQ3mVAsj9mUTogX
         w43+KFWtKxXK+Z+R+M9j1VFtH7yyvvltRjHuVxBER+CbEYNoZPM/HYgIKZt/VkT6kaSA
         5dWcbxNp0UmTYdWoD7WMOjIVFcNblueoyg2e0=
Received: by 10.50.236.73 with SMTP id us9mr7574523igc.16.1329256781827;
        Tue, 14 Feb 2012 13:59:41 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z22sm1275326ibg.5.2012.02.14.13.59.40
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 13:59:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s2M8Ava6xyKX32h9+pbxG+zq1wH1RkdWwfNsZMzcVQEmw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190770>

Felipe Contreras wrote:
> On Tue, Feb 14, 2012 at 10:36 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> I did not sign this.

Do you mean you do not agree with the following?

	Developer's Certificate of Origin 1.1

	By making a contribution to this project, I certify that:

	(a) The contribution was created in whole or in part by me and I
	    have the right to submit it under the open source license
	    indicated in the file; or

	(b) The contribution is based upon previous work that, to the best
	    of my knowledge, is covered under an appropriate open source
	    license and I have the right under that license to submit that
	    work with modifications, whether created in whole or in part
	    by me, under the same open source license (unless I am
	    permitted to submit under a different license), as indicated
	    in the file; or

	(c) The contribution was provided directly to me by some other
	    person who certified (a), (b) or (c) and I have not modified
	    it.

	(d) I understand and agree that this project and the contribution
	    are public and that a record of the contribution (including all
	    personal information I submit with it, including my sign-off) is
	    maintained indefinitely and may be redistributed consistent with
	    this project or the open source license(s) involved.

Anyway, Junio, please feel free to remove Felipe's sign-off from these
patches, or add an "Against-the-protest-of:" or whatever if that's
what he wants.

I've reached the point of diminishing returns.  I'll be happy to help
in any way I can, given a polite explanation of how I can help.
