From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] quiltimport documentation: --dry-run and -n are synonyms
Date: Sat, 12 Sep 2009 19:41:41 -0700
Message-ID: <1252809701-3655-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 04:42:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmf2s-0006s5-3X
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 04:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbZIMCln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 22:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754471AbZIMClm
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 22:41:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZIMClm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 22:41:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3ECB64E562
	for <git@vger.kernel.org>; Sat, 12 Sep 2009 22:41:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=qIGsL+LELLxjVHCDfcMaxIwWFUI
	=; b=EzEcTjcW8+RciYDkrrw3y4qVSQlFD2pdTtPA0p5g9ljaBR8/cZO4XSEqwQ6
	7ZTlEAcJmJ8x8hIK9M7Eo7ThbzixavEzyJ7E2NAP/nCY/FYyl6e/hRJi2WHtpYPo
	feJwpk/Pgq/n8/SAWSag2iF3pHO8inbYtrBSgc0xf2frrnog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=Tkzjlyp/fvsSfjLmZ319of3au8mza
	tjioNMKIQU23HoVbce6U3CSQW9uLgbng9Gs/pQyDEFSzCsyMHKu8V3pOwCcRSbwM
	zoyp15lGUyJW2hdBfhwHfbcx+E65UDojbdGXflVKm7Jkm4NgwrNu7U4geHhsQJT7
	AY4ZjPo/ByhSvk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B75A4E560
	for <git@vger.kernel.org>; Sat, 12 Sep 2009 22:41:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AD4D64E55F for
 <git@vger.kernel.org>; Sat, 12 Sep 2009 22:41:42 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc0.82.g1c5d9
X-Pobox-Relay-ID: F9FF7CBE-A00E-11DE-91F5-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128324>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-quiltimport.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index d4037de..579e8d2 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -9,7 +9,7 @@ git-quiltimport - Applies a quilt patchset onto the current branch
 SYNOPSIS
 --------
 [verse]
-'git quiltimport' [--dry-run] [--author <author>] [--patches <dir>]
+'git quiltimport' [--dry-run | -n] [--author <author>] [--patches <dir>]
 
 
 DESCRIPTION
-- 
1.6.5.rc0.82.g1c5d9
