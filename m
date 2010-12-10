From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@MIT.EDU>
Subject: git-send-email: add some short options and update documentation
Date: Fri, 10 Dec 2010 13:44:14 -0500
Message-ID: <1292006656-1264-1-git-send-email-asedeno@mit.edu>
References: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 19:44:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR7xP-0005Ib-8X
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 19:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab0LJSoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 13:44:34 -0500
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:47461 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754368Ab0LJSoc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Dec 2010 13:44:32 -0500
X-AuditID: 12074425-b7c98ae000000a04-28-4d02750fbb59
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id 9E.93.02564.F05720D4; Fri, 10 Dec 2010 13:44:31 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id oBAIiUvN010311;
	Fri, 10 Dec 2010 13:44:31 -0500
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	 =?ISO-8859-1?Q?=20=1Cby?= outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oBAIiScI001539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 10 Dec 2010 13:44:29 -0500 (EST)
Received: by darkmatter.mit.edu (Postfix, from userid 32861)
	id 155B014C011; Fri, 10 Dec 2010 13:44:28 -0500 (EST)
X-Mailer: git-send-email 1.7.3.3
In-Reply-To: <1291869878-19645-1-git-send-email-asedeno@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163427>

Add short options that were mentioned in the thread to git-send-email,
specifically:

-n for --dry-run
-f for --force
-q for --quiet

Since --force didn't have documentation in
Documentation/git-send-email.txt, a separate commit adds some
first.

[PATCH 1/2] Add --force to git-send-email documentation
[PATCH 2/2] git-send-email: Add some short options

Documentation/git-send-email.txt |    6 ++++++
git-send-email.perl              |   12 ++++++------
2 files changed, 12 insertions(+), 6 deletions(-)
