From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 0/6] git send-email suppress-cc=self fixes
Date: Thu, 30 May 2013 10:11:08 +0300
Message-ID: <1369897638-27299-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 09:10:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhx0a-000339-IR
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 09:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967712Ab3E3HKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 03:10:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9323 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967670Ab3E3HKn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 03:10:43 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4U7Af6t031247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 30 May 2013 03:10:41 -0400
Received: from redhat.com (vpn-203-5.tlv.redhat.com [10.35.203.5])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4U7AcZm017183;
	Thu, 30 May 2013 03:10:40 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225936>

This includes bugfixes related to handling of --suppress-cc=self
flag. Tests are also included.

Changes from v1:
	- tweak coding style in tests to address comments by Junio

Michael S. Tsirkin (6):
  t/send-email.sh: add test for suppress-cc=self
  send-email: fix suppress-cc=self on cccmd
  t/send-email: test suppress-cc=self on cccmd
  send-email: make --suppress-cc=self sanitize input
  t/send-email: add test with quoted sender
  t/send-email: test suppress-cc=self with non-ascii

 git-send-email.perl   | 20 +++++++++------
 t/t9001-send-email.sh | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 8 deletions(-)

-- 
MST
