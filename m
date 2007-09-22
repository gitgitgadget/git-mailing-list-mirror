From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvsimport bug on branches [was: conversion to git]
Date: Sat, 22 Sep 2007 12:05:38 +1200
Message-ID: <46a038f90709211705y351dbe6cp50c249dc0fcfd5a0@mail.gmail.com>
References: <loom.20070920T010842-272@post.gmane.org>
	 <46F31BBB.1040901@byu.net>
	 <8D5EA3F4-9642-4604-963E-838D03650FBC@zib.de>
	 <alpine.LFD.0.999.0709210840190.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>, "Eric Blake" <ebb9@byu.net>,
	m4-patches@gnu.org, "Jim Meyering" <jim@meyering.net>,
	git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 02:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYsVG-00039R-An
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 02:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbXIVAFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 20:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbXIVAFk
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 20:05:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:42505 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbXIVAFj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 20:05:39 -0400
Received: by ug-out-1314.google.com with SMTP id z38so601193ugc
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mMmmoZzpdCQyE1FcR2e/sApyhsUV7gtvfNHRcjUwqq4=;
        b=BU+KiDYukq7CbAWpzT8OEbjTTBsO7V1Gxj/IxsROxI1w8x5Iw8ig7GN0bLvJym9g9zjxxglKVwFcIUx0v6zKHGUzLB4LIoWLvni94FC2BbNenVEGS2KaHhXFp/nvvws1nsrR/wjzjoCmPdSLSKP5pQYmwEUqyWP0Q/e1/DoZu+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tkZ6n3EGxtaF8VyFtFhoC/HjaBjBrKPWqdlYeRJ4CQ05zVWZ0OYO7NoLGWugrpk+DqgTh430SONp93GlSDwdgipvSApqldncQPeP/887nQiG7eXElWzc/E9erUG/G6IyJs9PPFTIUaYaAw5OZ38aV4UcII9k6Oyg5Mo9WhoDvjM=
Received: by 10.67.26.7 with SMTP id d7mr996263ugj.1190419538064;
        Fri, 21 Sep 2007 17:05:38 -0700 (PDT)
Received: by 10.67.23.15 with HTTP; Fri, 21 Sep 2007 17:05:38 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0709210840190.16478@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58897>

On 9/22/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> The big advantage of git-cvsimport is that it can do incremental imports,

Indeed. And it can take over incrementals on a GIT repo initially
imported by parsecvs or cvs2git. That's the recommended practice for
tracking non-trivial CVS repos -- IOWs "that's what I do" ;-)

cheers,


m
