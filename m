From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] fsck updates
Date: Fri, 30 Jan 2009 03:05:12 -0800
Message-ID: <1233313517-24208-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 12:07:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSrD2-0005hA-5L
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 12:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbZA3LF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 06:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbZA3LFZ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 06:05:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbZA3LFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 06:05:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 612842A11B;
	Fri, 30 Jan 2009 06:05:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D38C72A111; Fri,
 30 Jan 2009 06:05:18 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.312.g5be3c
X-Pobox-Relay-ID: E2E4C9B0-EEBD-11DD-AEAC-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107793>

These go on top of the previous two patches I sent earlier.

Junio C Hamano (5):
  pack-check.c: minor formatting fix to match coding style
  verify_pack(): allow a quicker verification for a pack with version 2 idx
  verify-pack: add --quick
  fsck: three levels of validation
  [squash] fsck: revert --quick to the default and introduce --medium

 builtin-fsck.c        |   13 ++++++++++---
 builtin-verify-pack.c |   10 +++++++---
 http-push.c           |    2 +-
 http-walker.c         |    2 +-
 pack-check.c          |   36 ++++++++++++++++++++++++------------
 pack.h                |    5 ++++-
 6 files changed, 47 insertions(+), 21 deletions(-)
