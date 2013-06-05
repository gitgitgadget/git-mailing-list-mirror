From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 0/7] git send-email suppress-cc=self fixes
Date: Wed, 5 Jun 2013 21:10:49 +0300
Message-ID: <1370455737-29986-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 05 20:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkIAC-0002Zl-6C
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 20:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387Ab3FESKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 14:10:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755840Ab3FESKR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 14:10:17 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r55IAF3s017398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 5 Jun 2013 14:10:15 -0400
Received: from redhat.com (vpn-203-36.tlv.redhat.com [10.35.203.36])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r55IAD3q008493;
	Wed, 5 Jun 2013 14:10:14 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226462>

This includes bugfixes related to handling of --suppress-cc=self
flag. Tests are also included.

Changes from v3:
	- v3 submission was missing one patch (1/7). Re-add it.
Changes from v2:
	- add a new test, split patches differently add code comments
		 to address comments by Junio
	- rename example addresses in tests from redhat.com to example.com
Changes from v1:
        - tweak coding style in tests to address comments by Junio

Michael S. Tsirkin (7):
  t/send-email.sh: add test for suppress-cc=self
  send-email: fix suppress-cc=self on cccmd
  t/send-email: test suppress-cc=self on cccmd
  send-email: make --suppress-cc=self sanitize input
  t/send-email: add test with quoted sender
  t/send-email: test suppress-cc=self with non-ascii
  test-send-email: test for pre-sanitized self name

 git-send-email.perl   | 23 ++++++++++------
 t/t9001-send-email.sh | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 8 deletions(-)

-- 
MST
