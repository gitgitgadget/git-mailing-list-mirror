From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/3] yet more progress display stuff
Date: Thu, 01 Nov 2007 16:59:54 -0400
Message-ID: <1193950797-29631-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:00:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inh9B-0000qy-Gs
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbXKAU77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 16:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753752AbXKAU77
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 16:59:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31466 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbXKAU76 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 16:59:58 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQU002D3IBX07M0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Nov 2007 16:59:57 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.279.gb2d9d-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62997>

Here's 3 additional patches.  The first one revert one change already
burried deep in the topic branch based on Shawn's concern about
prune-packed progress display handling.

The second is a generic improvement to the throughput display.

The last is my reimplementation of total transfer byte count, replacing
Shawn's proposed patch which suffered from a few issues.


Nicolas
