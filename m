From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/7] assorted pack-objects cleanups and improvements
Date: Fri, 02 May 2008 15:11:44 -0400
Message-ID: <1209755511-7840-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:13:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js0gY-0004c8-U0
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 21:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936499AbYEBTL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 15:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936130AbYEBTL4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 15:11:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28091 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936082AbYEBTLy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 15:11:54 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K090074V9BRMJ70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 May 2008 15:11:53 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.226.g6f6e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81021>

This is a series of patches with small fixes, minor cleanups and some
improvements especially for threaded repacks.

The diffstat is rather simple:

 builtin-pack-objects.c |  197 +++++++++++++++++++++++++++++-------------------
 1 files changed, 118 insertions(+), 79 deletions(-)


Nicolas
