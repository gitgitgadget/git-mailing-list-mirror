From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] GIT_TRACE: show which built-in/external commands are
 executed
Date: Sun, 25 Jun 2006 16:11:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606251607090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1FuSIf-0004jK-Tp@moooo.ath.cx> <7v3bdtv4h3.fsf@assigned-by-dhcp.cox.net>
 <E1FuV62-0004Jd-Ve@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 16:12:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuVLE-0007sz-AM
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 16:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWFYOLv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 10:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWFYOLv
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 10:11:51 -0400
Received: from mail.gmx.de ([213.165.64.21]:43698 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750938AbWFYOLu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 10:11:50 -0400
Received: (qmail invoked by alias); 25 Jun 2006 14:11:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 25 Jun 2006 16:11:49 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FuV62-0004Jd-Ve@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22628>

Hi,

On Sun, 25 Jun 2006, Matthias Lederhofer wrote:

> With the environment variable GIT_TRACE set git will show
>  - alias expansion
>  - built-in command execution
>  - external command execution
> on stderr.

Nice.

Ciao,
Dscho

P.S.: Now we only have to convert all "git-" invocations in the scripts to
"git " invocations so we can benefit from it. But that would mean two 
forks instead of one for the non-builtins. Hmm.
