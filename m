From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Fri, 22 Feb 2008 01:03:35 -0800 (PST)
Message-ID: <m3myptcqji.fsf@localhost.localdomain>
References: <87odaa4tcl.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Julliard <julliard@winehq.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-15?q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 22 10:04:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSTpP-0004vi-Cs
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 10:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758419AbYBVJDo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 04:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760211AbYBVJDm
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 04:03:42 -0500
Received: from gv-out-0910.google.com ([216.239.58.190]:3916 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758419AbYBVJDi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 04:03:38 -0500
Received: by gv-out-0910.google.com with SMTP id s4so182960gve.37
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 01:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        bh=A/Kcrt+HGdj1CYixwOCsdQPPR2f2sHaNnAu3nOg6i1g=;
        b=gX5yPJV6rlgQ80ZgeZa3YvPtHjv49TkL9TEyjdSP7kMIMtAyjKEaXAyLz9eeloJOR3e7EtnbuPCJPXSqIXeBI0dtwB++xciVpeJpcTkkdRKBVxycuUfL8+1sf8zpRSvuiu/IKzYh+TAZ192006TORKK+zFhuo1WctIZ1w7wLB3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        b=uz7ive52hrfKpkFPaN60BaE2IFURlhUiDveUwmz54ZkcQS5SnlC1DFgl7p0Y5gLX51DFhqLWwqzNBo0d/imGo48jl6aO61qGPE0IfCXIizihwRabpx7HDOGZdiYTqVm5HU0GTceR38n5gFUduwTZ/F8meA90mkZo7rWQxGiMiG4=
Received: by 10.78.14.13 with SMTP id 13mr17433415hun.48.1203671016664;
        Fri, 22 Feb 2008 01:03:36 -0800 (PST)
Received: from localhost.localdomain ( [83.8.242.208])
        by mx.google.com with ESMTPS id 7sm1862075nfv.35.2008.02.22.01.03.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Feb 2008 01:03:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1M92n4Y031164;
	Fri, 22 Feb 2008 10:03:00 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1M92QkA031155;
	Fri, 22 Feb 2008 10:02:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87odaa4tcl.fsf@lysator.liu.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74705>

David K=E5gedal <davidk@lysator.liu.se> writes:

> This works for me, but before including it someone else should try
> it. It might only work in Emacs 22, for instance.

1077:[emacs@git/contrib/emacs]# LC_ALL=3Den_EN make
emacs -batch -f batch-byte-compile git.el
Loading /usr/share/emacs/site-lisp/site-start.d/php-mode-init.el (sourc=
e)...
[...]
While compiling toplevel forms in file /home/jnareb/git/contrib/emacs/g=
it.el:
  !! File error (("Cannot open load file" "grep"))
Done
make: *** [git.elc] Error 1

1078:[emacs@git/contrib/emacs]# emacs --version
GNU Emacs 21.4.1

--=20
Jakub Narebski
Poland
ShadeHawk on #git
