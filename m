From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: git has modified files after clean checkout
Date: Fri, 2 Jan 2009 00:49:40 -0500
Message-ID: <81bfc67a0901012149u23c8c9avb6f47817a56750c7@mail.gmail.com>
References: <81bfc67a0812311223g2b6e8476y84b23c19977dfd10@mail.gmail.com>
	 <402731c90812311541v28ac9617ge52e0e5c0f1298d2@mail.gmail.com>
	 <81bfc67a0901010048l7a4a8fa1h42f7cd448dfc704@mail.gmail.com>
	 <200901012048.13630.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Aguilar" <davvid@gmail.com>, git@vger.kernel.org
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 02 06:51:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIcw6-0004yX-Bp
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 06:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbZABFtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 00:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbZABFto
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 00:49:44 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:17624 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbZABFtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 00:49:43 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3127409fkq.5
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 21:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BcXpjdv3+JHh2AKTC8joG9m0mikX5mcqDRvR9IYeu94=;
        b=xJfy2tcJqmnnwmM4Hxbq9OiRDB//9I9vCvvOH/7jPgxpVZiNFooBqKKs/Nx0OGbPpo
         Ib7jGrWTEBYdDw9KVaYADh1SVTVbWXRA7tj1DbjuEfrm0vtHO8zv4wna/MFU34y8kc4k
         3/yOiyIhcww8M18AIinWGRTru9TEaF7OzKGjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=f4NRP0p/Q4LpYFw4TPm6Ga41p5DTPOXgQAIelemm7jtwDnQkfyplZSR3KD9KSeYjZT
         O0ocl1QOH+VdnaPlFBhm0Y9Wx8pqf5k8O/lPIDaO2sG6Uei22VvkvUCBwTzy+sV0Pz8E
         ezJQLV/h+wE3coYYZlKZ6WsUPxW1lVdEGhQeA=
Received: by 10.223.113.194 with SMTP id b2mr12573179faq.80.1230875380999;
        Thu, 01 Jan 2009 21:49:40 -0800 (PST)
Received: by 10.223.107.205 with HTTP; Thu, 1 Jan 2009 21:49:40 -0800 (PST)
In-Reply-To: <200901012048.13630.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104359>

> Do you have any .gitattributes?  A few days ago, ludde on IRC bumped
>  into the problem that git-checkout applies the .gitattributes that are
>  present in the tree *before* the checkout.  Naturally this means that
>  the .gitattributes do not apply at all during the first checkout at
>  the end of cloning.  In ludde's case, this caused git-blame to think
>  the file had all line endings changed compared to the index version.
>
no, no .gitattributes to my knowledge (file doesn't exist). but it's
not just during the first checkout.

# On branch regen2
# Your branch is ahead of 'funtoo/funtoo.org' by 1 commit.
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   app-admin/petrovich/files/petrovich-1.0.0-gentoo.diff
#       modified:   app-cdr/mode2cdmaker/files/mode2cdmaker-1.5.1-gentoo.patch
#       modified:   app-crypt/mhash/files/mhash-0.9.9-mutils-align.patch
#       modified:   app-crypt/rainbowcrack/files/rainbowcrack-1.2+gcc-4.3.patch
#       modified:   app-crypt/rainbowcrack/files/rainbowcrack-1.2-share.patch
#       modified:   app-crypt/rainbowcrack/files/rainbowcrack-1.2-types.patch
#       modified:   app-editors/leo/files/leoConfig.py.patch
#       modified:
app-emacs/aspectj4emacs/files/aspectj4emacs-1.1_beta2-browse-url-new-window-gentoo.patch
#       modified:
app-emacs/aspectj4emacs/files/aspectj4emacs-1.1_beta2-compile-log-gentoo.patch
...
that continues on for a while, all that was done was a git pull funtoo
funtoo.org

I haven't had time to test 1.6.1 yet


-- 
Caleb Cushing

http://xenoterracide.blogspot.com
