From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 0/6] git send-email suppress-cc=self fixes
Date: Tue, 4 Jun 2013 10:55:59 +0300
Message-ID: <1370332482-12329-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 09:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujm5d-00046Y-V7
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 09:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759897Ab3FDHza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 03:55:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11744 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580Ab3FDHz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 03:55:29 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r547tQho022904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 4 Jun 2013 03:55:26 -0400
Received: from redhat.com (vpn-203-14.tlv.redhat.com [10.35.203.14])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r547tOEB015211;
	Tue, 4 Jun 2013 03:55:25 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226324>

This includes bugfixes related to handling of --suppress-cc=self
flag. Tests are also included.

Changes from v2:
	- add a new test, split patches differently add code comments
		 to address comments by Junio
	- rename example addresses in tests from redhat.com to example.com
Changes from v1:
        - tweak coding style in tests to address comments by Junio


Michael S. Tsirkin (6):
  send-email: fix suppress-cc=self on cccmd
  t/send-email: test suppress-cc=self on cccmd
  send-email: make --suppress-cc=self sanitize input
  t/send-email: add test with quoted sender
  t/send-email: test suppress-cc=self with non-ascii
  test-send-email: test for pre-sanitized self name

 git-send-email.perl   | 23 +++++++++++++++--------
 t/t9001-send-email.sh | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 9 deletions(-)

-- 
MST
