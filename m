From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/5] pack header rewriting improvements
Date: Fri, 29 Aug 2008 16:07:57 -0400
Message-ID: <1220040482-10108-1-git-send-email-nico@cam.org>
References: <20080829143023.GA7403@spearce.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZAHS-0006Or-TA
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 22:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbYH2UIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 16:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbYH2UII
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 16:08:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15047 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbYH2UIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 16:08:07 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6D007OOP8J18A0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Aug 2008 16:07:31 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.212.g35f9f
In-reply-to: <20080829143023.GA7403@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94321>

This replaces my earlier 3-patch series called "don't let disk
corruptions escape pack SHA1 checksum" with this set.  Same purpose
but better!

Once again I'm leaving fast-import out.  I'm sure Shawn will figure
it out much faster than I could.


Nicolas
