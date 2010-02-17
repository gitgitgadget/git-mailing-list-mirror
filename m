From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 0/6] fast-import updates
Date: Wed, 17 Feb 2010 14:05:50 -0500
Message-ID: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:06:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhpDu-0004rj-H1
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab0BQTGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:06:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11748 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab0BQTGB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:06:01 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY000GRF2DZ9K50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Feb 2010 14:05:59 -0500 (EST)
X-Mailer: git-send-email 1.7.0.23.gf5ef4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140246>

Will follow a couple fast-import updates, with the most significant
change being the ability for fast-import to produce pack index v2 by
default.  Overall this should make fast-import produced data more imune
to silent corruptions, and also lift the limit on the maximum pack size
it could produce.

[PATCH 1/6] fast-import: start using struct pack_idx_entry
[PATCH 2/6] fast-import: use sha1write() for pack data
[PATCH 3/6] fast-import: use write_idx_file() instead of custom code
[PATCH 4/6] fast-import: make default pack size unlimited
[PATCH 5/6] fast-import: honor pack.indexversion and pack.packsizelimit config vars
[PATCH 6/6] fast-import: use the diff_delta() max_delta_size argument


Nicolas
