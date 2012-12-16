From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 0/3] Help newbie git developers avoid obvious pitfalls
Date: Sun, 16 Dec 2012 19:35:58 +0000
Message-ID: <1355686561-1057-1-git-send-email-git@adamspiers.org>
References: <7vobl0804s.fsf@alter.siamese.dyndns.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkK0r-0000fB-Je
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 20:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab2LPTgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 14:36:05 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41237 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab2LPTgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 14:36:04 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id E97A62E5D5
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 19:36:01 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
In-Reply-To: <7vobl0804s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211606>

I fell into various newbie pitfalls when submitting my first patches
to git, despite my best attempts to adhere to documented guidelines.
This small patch series attempts to reduce the chances of other
developers making the same mistakes I did.

Adam Spiers (3):
  SubmittingPatches: add convention of prefixing commit messages
  Documentation: move support for old compilers to CodingGuidelines
  Makefile: use -Wdeclaration-after-statement if supported

 Documentation/CodingGuidelines  |  8 ++++++++
 Documentation/SubmittingPatches | 21 ++++++++-------------
 Makefile                        |  7 ++++++-
 3 files changed, 22 insertions(+), 14 deletions(-)

-- 
1.7.12.1.396.g53b3ea9
