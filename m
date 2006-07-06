From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: Thu, 6 Jul 2006 16:25:33 +0200
Message-ID: <20060706142532.G37e44125@leonov.stosberg.net>
References: <20060706124025.G325584e9@leonov.stosberg.net> <20060706161011.ccc2ea1c.tihirvon@gmail.com> <E1FyUNT-0007Ko-JR@moooo.ath.cx> <20060706141725.28115.qmail@775c2aaf180a85.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 06 16:27:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyUnT-0004JE-TY
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 16:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWGFOZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 10:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWGFOZh
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 10:25:37 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:38274 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1030277AbWGFOZh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 10:25:37 -0400
Received: from leonov.stosberg.net (p213.54.86.66.tisdip.tiscali.de [213.54.86.66])
	by ncs.stosberg.net (Postfix) with ESMTP id 695AAAEBA004;
	Thu,  6 Jul 2006 16:25:28 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 6376E103C94; Thu,  6 Jul 2006 16:25:33 +0200 (CEST)
To: git@vger.kernel.org, Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060706141725.28115.qmail@775c2aaf180a85.315fe32.mid.smarden.org>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23391>

Gerrit Pape wrote:

> This should work with shell/builtins only, no sed/cut:
>
>  path=${PATH}:
>  while test -n "$path"; do
>    p=${path%%:*}/$1
>    test ! -x "$p" || { echo "$p"; return 0; }
>    path=${path#*:}

$ exec /bin/sh
$ uname -a
SunOS hostname 5.9 Generic_118558-25 sun4u sparc SUNW,Ultra-5_10 Solaris
$ echo ${PATH%%:*}
bad substitution
$ echo ${PATH#*:}
bad substitution

Regards,
Dennis
