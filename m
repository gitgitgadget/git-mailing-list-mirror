From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH 0/2] OpenSolaris 2008.11 portability fixes
Date: Sat, 23 May 2009 12:24:55 -0700
Message-ID: <1243106697-6424-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:25:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wqo-0002Cd-PQ
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756465AbZEWTZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755130AbZEWTZB
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:25:01 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553AbZEWTY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:24:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A50B119152
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:24:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3267A19151 for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:24:58 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
X-Pobox-Relay-ID: 676777EA-47CF-11DE-86E5-B4FDD46C8AFF-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119794>

Two small patches that seem to make things better for me on OpenSolaris
2008.11; I am primarily interested in learning if this regresses for other
vintages of Solaris.

Junio C Hamano (2):
  Teach Solaris that _XOPEN_SOURCE=600 really menas XPG6
  OpenSolaris 200811 (SunOS 5.11) does not want OLD_ICONV

 Makefile          |    4 +++-
 git-compat-util.h |    2 ++
 2 files changed, 5 insertions(+), 1 deletions(-)
