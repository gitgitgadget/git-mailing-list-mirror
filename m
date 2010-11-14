From: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
Subject: [PATCHv2 0/2] Fix username and password extraction from HTTP URLs
Date: Sun, 14 Nov 2010 02:51:13 +0100
Message-ID: <1289699475-11364-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Cc: srabbelier@gmail.com,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 03:02:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHRvU-0003Pg-3c
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 03:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351Ab0KNCCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 21:02:23 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:50142 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053Ab0KNCCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 21:02:22 -0500
Received: from localhost.localdomain (unknown [88.180.106.44])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4FF1EA61C4;
	Sun, 14 Nov 2010 03:02:16 +0100 (CET)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161402>

Percent-decode username and password in HTTP URLs. This is necessary
to specify a username with a '@' character in the URL.

Gabriel Corona (2):
  t5550: test HTTP authentication and userinfo decoding
  Fix username and password extraction from HTTP URLs

 http.c                  |   12 +++++++++++-
 t/lib-httpd.sh          |    3 +++
 t/lib-httpd/apache.conf |   29 +++++++++++++++++++++++++++++
 t/lib-httpd/passwd      |    1 +
 t/t5550-http-fetch.sh   |    7 +++++++
 5 files changed, 51 insertions(+), 1 deletions(-)
 create mode 100644 t/lib-httpd/passwd

-- 
1.7.2.3
