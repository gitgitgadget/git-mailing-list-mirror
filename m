From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/WIP 0/2] Documentation clean-up: git commands
Date: Mon, 23 Mar 2009 15:28:51 +0100
Message-ID: <1237818533-31577-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 15:30:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LllAt-00064l-P4
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbZCWO3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbZCWO3N
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:29:13 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33029 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753697AbZCWO3M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 10:29:12 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id EB1732FA168;
	Mon, 23 Mar 2009 10:29:09 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 23 Mar 2009 10:29:09 -0400
X-Sasl-enc: 0wBFw+PT34xDceluYn4IzssIRWhW19NJ314yqL0tMLXH 1237818549
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 35BA246004;
	Mon, 23 Mar 2009 10:29:09 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.149.g6462
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114315>

In current git documentation, git commands are still written in various
styles: with and without dash, unformatted and formatted with `, ' or ".

I propose to use `git command` consistently. In asciidoc, backticks are
for commands, ticks for paths. [Quotes should be like ``this''.]

A first step is reaching a consistent use of backticks. A second step
would be sed magic to get rid of the dashes in the text, not in the
links (linkgit:...).

Patch 1 is a preparation patch where I spotted the use of a command with
"git" in an instance where it looks very inconsistent. (It feels OK when
talking about commands more colloquially.)

Patch 2 is an example for the first step.

Questions:
- Do we want this at all?
- Do we want it this way (`git command`)?
- How to prepare: 1 patch per file/per 5 files/per 50 changes?
- How to submit: single patch once ready or whole series at end (5 years
  from now)?
- How to send: Bother the list or send pull requests only?

I don't know what I'm getting myself into...
Michael

Michael J Gruber (2):
  Documentation: fix minor inconsistency
  Documentation: format git commands consistently

 Documentation/config.txt              |  114 ++++++++++++++++----------------
 Documentation/diff-format.txt         |    6 +-
 Documentation/diff-generate-patch.txt |   12 ++--
 Documentation/diff-options.txt        |    4 +-
 Documentation/everyday.txt            |    6 +-
 Documentation/fetch-options.txt       |   12 ++--
 Documentation/git-add.txt             |   28 ++++----
 Documentation/git-am.txt              |   16 ++--
 8 files changed, 99 insertions(+), 99 deletions(-)
