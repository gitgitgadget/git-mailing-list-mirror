From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2b 00/16, 2 updates] Make the msvc-build scripts work again
Date: Mon, 20 Jul 2015 23:54:04 +0100
Message-ID: <1437432846-5796-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 00:53:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHJwB-00086Q-Lz
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 00:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757318AbbGTWxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 18:53:17 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:62450 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757248AbbGTWxQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 18:53:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DTHgA7e61VPHMBFlxcgkFRAYRfgy6BWbNNgWaGCgQCgTE7EgEBAQEBAQEGAQEBAUABP4RNDwEjIxgdAiYCOwoaiEWzCZZcgSKPMIJvgUMFlFKlKIEJZoI0PYJ8AQEB
X-IPAS-Result: A2DTHgA7e61VPHMBFlxcgkFRAYRfgy6BWbNNgWaGCgQCgTE7EgEBAQEBAQEGAQEBAUABP4RNDwEjIxgdAiYCOwoaiEWzCZZcgSKPMIJvgUMFlFKlKIEJZoI0PYJ8AQEB
X-IronPort-AV: E=Sophos;i="5.15,510,1432594800"; 
   d="scan'208";a="39174025"
Received: from host-92-22-1-115.as13285.net (HELO localhost) ([92.22.1.115])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 20 Jul 2015 23:53:15 +0100
X-Mailer: git-send-email 2.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274357>

This updates two patches in the series based on Eric Sunshine's comments.

Patch 8b updates the commit message to make clear what was going wrong.

Patch 10b improves the perl code.

Junio: would a full re-roll be appropriate at a suitable point?

Philip Oakley (2):

  engine.pl: ignore invalidcontinue.obj which is known to MSVC
  engine.pl: delete the captured stderr file if empty


-- 
2.4.2.windows.1.5.gd32afb6
