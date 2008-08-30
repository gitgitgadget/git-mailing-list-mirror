From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix example in git-name-rev documentation
Date: Sat, 30 Aug 2008 13:11:42 -0700
Message-ID: <7v7i9ygt4x.fsf@gitster.siamese.dyndns.org>
References: <48B9A2C7.3080001@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Greaves <david@dgreaves.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:13:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZWoe-0002e1-Nj
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 22:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYH3ULz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbYH3ULz
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:11:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbYH3ULy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:11:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A794458857;
	Sat, 30 Aug 2008 16:11:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 008AF58856; Sat, 30 Aug 2008 16:11:49 -0400 (EDT)
In-Reply-To: <48B9A2C7.3080001@dgreaves.com> (David Greaves's message of
 "Sat, 30 Aug 2008 20:43:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E36B2DF4-76CF-11DD-8F84-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94415>

Since 59d3f54 (name-rev: avoid "^0" when unneeded, 2007-02-20), name-rev
stopped showing an unnecessary "^0" to dereference a tag down to a commit.
The patch should have made a matching update to the documentation, but we
forgot.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-name-rev.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index abd2237..7ca8a7b 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -59,7 +59,7 @@ Enter 'git-name-rev':
 
 ------------
 % git name-rev 33db5f4d9027a10e477ccf054b2c1ab94f74c85a
-33db5f4d9027a10e477ccf054b2c1ab94f74c85a tags/v0.99^0~940
+33db5f4d9027a10e477ccf054b2c1ab94f74c85a tags/v0.99~940
 ------------
 
 Now you are wiser, because you know that it happened 940 revisions before v0.99.
-- 
1.6.0.1.162.g04bc
