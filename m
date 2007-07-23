From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [QGIT4 PATCH 0/6] Some UI Improvements
Date: Mon, 23 Jul 2007 20:32:39 +0000
Message-ID: <200707232232.39546.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 22:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4kW-0008HW-Qm
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933266AbXGWUnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765029AbXGWUnT
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:43:19 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:51764 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762848AbXGWUnS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 16:43:18 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 018851E52BE;
	Mon, 23 Jul 2007 22:43:17 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id DE9CE23D303;
	Mon, 23 Jul 2007 22:43:16 +0200 (CEST)
Received: from fnoheim223.netpark.at (fnoheim223.netpark.at [83.68.151.223])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id A77C328ABA1;
	Mon, 23 Jul 2007 22:43:16 +0200 (CEST)
X-Mailbox-Line: From 48b7bd0585330bf78ec47f7c70a6ccc2a6194d12 Mon Sep 17 00:00:00 2001
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.1/3744/Mon Jul 23 21:05:34 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53474>

Hi,
the initial reason for this patches is that here on my system qgit4 looks like this
http://img77.imageshack.us/my.php?image=qgit4strangewindowgi0.png
which is a bit suboptimal for viewing patches :-)
this is on a standard qt 4.3 from gentoo

While i was there i removed the same problem in the custom action editor
and removed some unneed empty space

Actually locally i removed even more empty space, like around the main tab view
and inside the main tab view.
If anyone wants me to remove that too, i would be happy to send more patches

[QGIT4 PATCH 1/6] update patchview.ui with new qt designer
	When i edit the .ui files with the QT designer it updates some unrelated parts.
	Because of this i split the update into a separate patch so the real changes are obvious.
	Feel free to collapse them if you want

[QGIT4 PATCH 2/6] change size policy of the patch viewer to expanding
	this fixes the problem from the screenshot above

[QGIT4 PATCH 3/6] update patchview.ui with new qt designer
	same reason as patch 1

[QGIT4 PATCH 4/6] change size policy of splitter which contains the list and the textbox
	fix same problem in custom action editor

[QGIT4 PATCH 5/6] remove empty space below "diff to" header in patch view
[QGIT4 PATCH 6/6] remove empty space below button bar in file view
	these remove some more empty space which i personally find useless
	Apply if you like them

If you want i can provide more screenshots of how patches change appearance.

Greetings Peter
