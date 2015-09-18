From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/3] Clarify the documentation of options with optional arguments
Date: Fri, 18 Sep 2015 17:01:47 +0200
Message-ID: <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
References: <20150917174306.GA29171@sigill.intra.peff.net>
Cc: git@vger.kernel.org, Alastair McGowan-Douglas <altreus@altre.us>,
	Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 18 17:15:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcxNX-0002kK-Jy
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 17:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbbIRPNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 11:13:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49777 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbbIRPCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 11:02:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8IF1qdu023897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 18 Sep 2015 17:01:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8IF1rgx014907;
	Fri, 18 Sep 2015 17:01:53 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZcxAf-00023C-72; Fri, 18 Sep 2015 17:01:53 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
In-Reply-To: <20150917174306.GA29171@sigill.intra.peff.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 18 Sep 2015 17:01:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8IF1qdu023897
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1443193317.24229@UjACpvoUiWm2MDYNLVKG1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278199>

The first patch is essentially to make the last one look good. The
second is a real documentation bug. The last one may be controversial
as it re-documents something already documented in gitcli, but I think
it's a good thing.

Matthieu Moy (3):
  Documentation: use 'keyid' consistantly, not 'key-id'
  Documentation/grep: fix documentation of -O
  Documentation: make explicit that optional arguments must be stuck

 Documentation/git-am.txt          | 3 ++-
 Documentation/git-cherry-pick.txt | 7 ++++---
 Documentation/git-commit-tree.txt | 3 ++-
 Documentation/git-commit.txt      | 3 ++-
 Documentation/git-grep.txt        | 8 +++++---
 Documentation/git-merge.txt       | 4 +++-
 Documentation/git-rebase.txt      | 3 ++-
 Documentation/git-revert.txt      | 7 ++++---
 Documentation/git-status.txt      | 5 +++--
 9 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.5.0.402.g8854c44
