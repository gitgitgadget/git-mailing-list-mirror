From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Fri, 9 Nov 2007 12:20:29 -0500
Message-ID: <9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <Pine.LNX.4.64.0711072242230.4362@racer.site>
	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
	 <Pine.LNX.4.64.0711072255420.4362@racer.site>
	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
	 <Pine.LNX.4.64.0711072309380.4362@racer.site>
	 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
	 <Pine.LNX.4.64.0711080003080.4362@racer.site>
	 <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com>
	 <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 18:22:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqXXx-0004Ja-Ri
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbXKIRUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 12:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754379AbXKIRUc
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:20:32 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:6440 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbXKIRUa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 12:20:30 -0500
Received: by wa-out-1112.google.com with SMTP id v27so678002wah
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 09:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FSKRUZ+E/MczGH/UOHtpegFGY8CXTZDfvy4T3hnCEGg=;
        b=H5Gi9YYFjXR1vvia+2d6Uy5vv8oRQfW7gtLX2xthGR/yvq+4QoSrcjanKDpRHRMRWFfCYRi+5DtARyoGX7n4Yh2IHtw5YMK7laNoTwh5rR4Y3TG/Kx49rNBcjloQluRl54Vx/CnZMZNvBJlgBXSXzk+V1UgC75SKKkwW/K3kBjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qbMis5FRlmgU8+Y6NTyddK70YorU+GKr2CDRbsCLzOLdi5C9jO2b7/HZutjSgcCojhGAmAjuGy1hzFbzNtCg+fsxn1S0VPqLaGhfZpyPh17TZHnRSOLGjocKUZuCYPtlzTGgzyv97OT166rT6zfNuAo8jIKrFL2VDYA/dm/BMt4=
Received: by 10.114.127.1 with SMTP id z1mr187294wac.1194628829834;
        Fri, 09 Nov 2007 09:20:29 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 09:20:29 -0800 (PST)
In-Reply-To: <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64224>

On 11/9/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Wed, 7 Nov 2007, Jon Smirl wrote:
> >
> > Then why doesn't this work?
>
> Jon, lookie here:
>
> > jonsmirl@terra:~/mpc5200b$ git log Documentation
> > all the log for Documentation....
> > jonsmirl@terra:~/mpc5200b$ cd Documentation
> > jonsmirl@terra:~/mpc5200b/Documentation$ git log Documentation
>
> Instead of the above sequence, do:
>
>         jonsmirl@terra:~/mpc5200b$ ls Documentation
>         .. all the files in Documentation ..
>         jonsmirl@terra:~/mpc5200b$ cd Documentation
>         jonsmirl@terra:~/mpc5200b/Documentation$ ls Documentation
>
> and now tell me, why doesn't that work? And can't you see how *stupid*
> your complaint is?

I never expected that to work it was just a response to the earlier
misstatement that the paths were relative to the project root. It
demonstrated that they were not.

The summary of this is that new users do not expect "git log" to give
them the whole log when the command is executed in a subdirectory.
This causes a training burden because of the unexpected behavior. They
try 'git log' and then I have to tell them to use "git log ."

>
> The rule is:
>  - git log without arguments gives the whole, unabridged, and full
>    history.
>  - git log with arguments gives the *simplified* history for those
>    arguments.
>
> But the arguments - if they exist - are always relative. You want things
> like filename completion to work. Making the pathname arguments absolute
> would be horrible. Think about it: it's just much more logical to always
> be able to say "I want the log for file xyz", and you don't want that to
> be absolute, since you shouldn't care where in the tree you are.
>
> And the fact that git log gives the whole history when you don't give any
> arguments at all IN NO WAY makes it any more sensible to give "absolute"
> pathnames. The history being "whole" has nothing to do with the pathnames
> being "absolute". The two are totally independent issues.
>
>                         Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
