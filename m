From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Re: [PATCH 1/8] git-apply: work from subdirectory.
Date: Sun, 27 Nov 2005 15:39:53 +0100
Message-ID: <m364qef93a.fsf@quimbies.gnus.org>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
	<7voe477n4i.fsf_-_@assigned-by-dhcp.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 15:47:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgNnu-0000UX-UB
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 15:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVK0Oq4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 09:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVK0Oq4
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 09:46:56 -0500
Received: from quimbies.gnus.org ([80.91.231.2]:18073 "EHLO quimbies.gnus.org")
	by vger.kernel.org with ESMTP id S1751086AbVK0Oqz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 09:46:55 -0500
Received: from larsi by quimbies.gnus.org with local (Exim 3.36 #1 (Debian))
	id 1EgNkR-0000rI-00; Sun, 27 Nov 2005 15:43:23 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q5yohta.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 26 Nov 2005 20:06:41 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.3.50 (gnu/linux)
X-Now-Playing: Koushik's _In the Middle of the Night_: "(untitled)"
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAMFBMVEUoKSw6PUI+QklGSlFU
 W2VcZHBla3ZueIh6hZaLmKyUormbnqOstsa7xNL6+/zP1d8dj2xHAAAACXBIWXMAAABIAAAASABG
 yWs+AAABV0lEQVQ4y2NgYGQQEGQUFDQ0BgNhI2UlJUEgYGBgYGQUAEtBgBATkC0gABRPMDFSdjMU
 MxMUdhYUBKoRAIozMAowCGzJ3rJjx+Zt2Zt33xZkAMoA1TKACSgAGmfIyIgkhCyJKsaIRwVpgHIT
 aGHUKBhmwAWLGEu5e8UETQEGhory8nYjuLD7zK5Vs1atnFUClFg5a+VKsCCjSsWsVVAwEagVyJkJ
 EnbvXDnrzN2z9+/e/X///iIlAabeu3fOMDBGzFr7/x0cvDcpYgq0AzIYsu6/QwbPGd3DDa1AEu9Q
 wVQFjXbB0HuoEv/evXtVXlTRLJTWC5b4//7/+3//3oMlfgY5dS1XDUv/h27UScfCmYvL3crnQSTe
 w4j3M4IKZywJNLbMh0iADPv/F2jSm+mCxbMmFQib10CNeg8yHwheNjGXzmxqVFTr/Idqx8uOZI+Z
 RQ1CmbPeAQDABublbhCgWgAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12809>

Junio C Hamano <junkio@cox.net> writes:

> I read git list via new.gmane.org NNTP server (running fetchnews
> locally to slurp from there) and noticed droppage on my end ---
> whose cause turns out to be that gmane NNTP server chops References:
> entries in the middle and fetchnews rejects such messages, and I am
> sure I am _not_ going to see this message on my local machine.

No, news.gmane.org doesn't chop any references.  But if you happen to
use a news reader that takes rfc1036bis and rfc2822 seriously (like,
ahem, Gnus), it'll chop the References header to get the size under
1024 octets.

If this gives fetchnews problems, then, er, fetchnews has problems.
Serious problems.  

-- 
(domestic pets only, the antidote for overdose, milk.)
  larsi@gnus.org * Lars Magne Ingebrigtsen
