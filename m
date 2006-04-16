From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: path limiting broken
Date: Sun, 16 Apr 2006 19:05:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604161905010.18184@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 19:05:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVAgc-0004m0-AF
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 19:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWDPRFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 13:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWDPRFO
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 13:05:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:3819 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750757AbWDPRFN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 13:05:13 -0400
Received: (qmail invoked by alias); 16 Apr 2006 17:05:11 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp035) with SMTP; 16 Apr 2006 19:05:11 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18792>

Hi,

just to make it clearer what I want:

	git-whatchanged -p next | grep parse_whatchanged

as well as

	git log -p next | grep parse_whatchanged

do not find that any line like

	int parse_whatchanged_opt(int ac, [...]

was removed, but they find that this line was added. However, in the 
working tree (which has a fresh checkout of next), there is no such line 
in log-tree.c. So I really would like to know where it vanished!

Ciao,
Dscho
