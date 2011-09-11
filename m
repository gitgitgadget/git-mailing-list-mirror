From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/3] misc patches on next branch
Date: Sun, 11 Sep 2011 20:37:49 +0100
Message-ID: <4E6D0E0D.2000400@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 21:44:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2px0-00052e-J6
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 21:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab1IKToS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 15:44:18 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:36383 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752525Ab1IKToR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 15:44:17 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1R2pwu-00043e-cp; Sun, 11 Sep 2011 19:44:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181186>

Hi Junio,

These patches are built on the next branch (from repo.or.cz)
@ 12850bec0c24b529c9a9df6a95ad4bdeea39373e

    [PATCH 1/3] sparse: Fix some "symbol not declared" warnings
    [PATCH 2/3] Fix some "variable might be used uninitialized" warnings
    [PATCH 3/3] Makefile: Make dependency directory creation less noisy

Note that the next branch does not build on MinGW at the moment due
to the credentials-cache[--daemon] additions; rather the use of unix
sockets to be more precise. I had intended to fix this up by now (one
option being to emulate unix sockets with win32 named pipes) but I
haven't had time - sorry!

ATB,
Ramsay Jones
