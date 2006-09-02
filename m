From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Slightly offtopic: Windows Explorer extension
Date: Sat, 2 Sep 2006 17:38:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609021724110.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-100695412-1157211496=:28360"
X-From: git-owner@vger.kernel.org Sat Sep 02 17:38:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJXZh-0007hW-4E
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 17:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWIBPiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 11:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWIBPiT
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 11:38:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:25730 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750879AbWIBPiS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Sep 2006 11:38:18 -0400
Received: (qmail invoked by alias); 02 Sep 2006 15:38:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 02 Sep 2006 17:38:16 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26340>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-100695412-1157211496=:28360
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

a couple of weeks ago, I started to port git to MinGW, with the ultimate 
goal of writing a Windows Explorer extension a la TortoiseCVS.

The two biggest obstacles are fork() and the network stuff (I do not plan 
on supporting Git.pm there). To overcome the absence of fork() I wanted to 
use the subprocess stuff in MinGW's port of GNU make.

Unfortunately, this effort was stalled a bit: I got side-tracked by the 
Windows Explorer extension mechanism. I found it really exciting (in the 
sense of an Arcade game end-of-level monster) to find a way to _easily_ 
write a Windows Explorer extension. Without cashware.

Since the extensions are a very substantial part of Windows Explorer, one 
might guess that it is relatively simple to write one. Ha! COM!

Attached is my (unfortunately stalled) WIP of such an extension. You need 
MinGW to compile it. It adds a menu entry "Hallo Dan de Man" to the 
Explorer context menu. If you select it, it just shows an alert box with 
the current file/directory name.

I'll be gone for one week, so if anyone wants to pick up the ball, go 
wild.

Ciao,
Dscho

---1148973799-100695412-1157211496=:28360
Content-Type: APPLICATION/x-gunzip; name=git-shell-ext.tar.gz
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0609021738160.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Description: 
Content-Disposition: attachment; filename=git-shell-ext.tar.gz

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

---1148973799-100695412-1157211496=:28360--

-- 
VGER BF report: U 0.509799
