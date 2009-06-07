From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 0/6] fixes for git-send-email
Date: Sun,  7 Jun 2009 23:40:51 +0200
Message-ID: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 23:41:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQ7Y-0004bz-5q
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 23:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbZFGVlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 17:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbZFGVlF
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 17:41:05 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33444 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbZFGVlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 17:41:03 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 59CC5104B5CF8;
	Sun,  7 Jun 2009 23:41:04 +0200 (CEST)
Received: from [89.59.87.118] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDQ6y-0007ZM-00; Sun, 07 Jun 2009 23:41:04 +0200
X-Mailer: git-send-email 1.6.3.2.221.g0ff2f
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18zzo7iQ3JJHqQ3jpW7B+EcFMEjJDPWlKnKqkN7
	1LlEwwiuqAt5Av6vA/BWj8BUXRUsvPD0Jbr5MqeZeI1sL1w3K9
	5MCLNmxCz9Sdx8WklRLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121006>

Markus Heidelberg (6):
  send-email: fix a typo in a comment
  add a test for git-send-email for threaded mails without
    chain-reply-to
  send-email: fix threaded mails without chain-reply-to
  add a test for git-send-email for non-threaded mails
  send-email: fix non-threaded mails
  doc/send-email: clarify the behavior of --in-reply-to with
    --no-thread

 Documentation/git-send-email.txt |    5 +++--
 git-send-email.perl              |    7 +++++--
 t/t9001-send-email.sh            |   21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 4 deletions(-)
