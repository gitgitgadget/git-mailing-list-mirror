From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 0/2] commit-slab cleanups
Date: Mon, 25 Nov 2013 20:01:59 +0100
Message-ID: <cover.1385405977.git.tr@thomasrast.ch>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 20:02:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl1QM-0004SY-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 20:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341Ab3KYTCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 14:02:18 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:56210 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756866Ab3KYTCR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 14:02:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 2A0A64D65A0;
	Mon, 25 Nov 2013 20:02:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XPuyTWab3xFV; Mon, 25 Nov 2013 20:02:05 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 98CA64D64DE;
	Mon, 25 Nov 2013 20:02:04 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc3.397.g2a3acd5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238329>

I gathered these while writing an "all merge bases simultaneously"
algorithm.  Turns out this fancy algorithm loses vs. simply calling
get_merge_bases() a lot, so I dropped that.  But the cleanups seem
valid anyway.


Thomas Rast (2):
  commit-slab: document clear_$slabname()
  commit-slab: declare functions "static inline"

 commit-slab.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

-- 
1.8.5.rc3.397.g2a3acd5
