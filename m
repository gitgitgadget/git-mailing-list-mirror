From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@MIT.EDU>
Subject: [PATCH 1/2] Add --force to git-send-email documentation
Date: Fri, 10 Dec 2010 13:44:15 -0500
Message-ID: <1292006656-1264-2-git-send-email-asedeno@mit.edu>
References: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 19:44:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR7xO-0005Ib-OC
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 19:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab0LJSoc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Dec 2010 13:44:32 -0500
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:45242 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750929Ab0LJSob (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Dec 2010 13:44:31 -0500
X-AuditID: 12074422-b7c3eae000000a70-a6-4d02750e574b
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id E6.F3.02672.E05720D4; Fri, 10 Dec 2010 13:44:30 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id oBAIiUfa030542;
	Fri, 10 Dec 2010 13:44:30 -0500
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oBAIiS3m001540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 10 Dec 2010 13:44:29 -0500 (EST)
Received: by darkmatter.mit.edu (Postfix, from userid 32861)
	id 1B59814C012; Fri, 10 Dec 2010 13:44:28 -0500 (EST)
X-Mailer: git-send-email 1.7.3.3
In-Reply-To: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163426>

Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
---
 Documentation/git-send-email.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index ebc024a..7ec9dab 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -322,6 +322,9 @@ have been specified, in which case default to 'comp=
ose'.
 Default is the value of 'sendemail.validate'; if this is not set,
 default to '--validate'.
=20
+--force::
+	Send emails even if safety checks would prevent it.
+
=20
 CONFIGURATION
 -------------
--=20
1.7.3.3
