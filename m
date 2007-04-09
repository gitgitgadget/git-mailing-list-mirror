From: Nicolas Pitre <nico@cam.org>
Subject: support for large packs and 64-bit offsets
Date: Mon, 09 Apr 2007 01:06:27 -0400
Message-ID: <11760951973172-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ham5a-00033i-33
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbXDIFGj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbXDIFGj
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:06:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64588 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbXDIFGi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:06:38 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG700EK9SV173A3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 01:06:37 -0400 (EDT)
X-Mailer: git-send-email 1.5.1.31.ge421f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44028>

This patch series adds support for large packs to GIT.  It creates a new
index format to accommodate both larger offsets and to store a checksum
for each raw object in a pack.  More details is provided in each patch
commit message.

This is not a replacement for the pack size limiting feature.  I think that
GIT should support both: large packs and split packs.

Nicolas
