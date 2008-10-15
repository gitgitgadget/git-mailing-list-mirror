From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 2/2] git-check-attr(1): use 'verse' for multi-line synopsis
	sections
Date: Wed, 15 Oct 2008 09:11:52 +0200
Message-ID: <20081015071152.GB32094@diku.dk>
References: <20081013175705.GA9538@diku.dk> <7vabd6686n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 09:13:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq0Z9-0008QC-6I
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbYJOHL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbYJOHLz
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:11:55 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:33629 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbYJOHLz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:11:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1D18352C388;
	Wed, 15 Oct 2008 09:11:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id opIAkOQ8HTau; Wed, 15 Oct 2008 09:11:52 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id EAF5352C368;
	Wed, 15 Oct 2008 09:11:52 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 977956DFB75; Wed, 15 Oct 2008 09:10:48 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id D3BDA1A4001; Wed, 15 Oct 2008 09:11:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabd6686n.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98243>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-check-attr.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 59d5cd2..dcf7650 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -8,8 +8,9 @@ git-check-attr - Display gitattributes information.
 
 SYNOPSIS
 --------
+[verse]
 'git check-attr' attr... [--] pathname...
-'git check-attr' --stdin [-z] attr... < <list-of-paths
+'git check-attr' --stdin [-z] attr... < <list-of-paths>
 
 DESCRIPTION
 -----------
-- 
tg: (34458dd..) jf/man-git-check-attr-synopsis (depends on: jf/man-git-check-attr-output next)

-- 
Jonas Fonseca
