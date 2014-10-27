From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/2] Followup patches for Asciidoctor
Date: Mon, 27 Oct 2014 00:13:41 +0000
Message-ID: <1414368823-427216-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 01:14:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiXwf-0008TE-7O
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 01:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbaJ0ANt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 20:13:49 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49582 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751736AbaJ0ANt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Oct 2014 20:13:49 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D05902808F;
	Mon, 27 Oct 2014 00:13:47 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is essentially the same as the previous v2, but against next
instead.  It moves most of the AsciiDoc operations into a set of
variables (TXT_TO_HTML and TXT_TO_XML) as Junio suggested, and removes
the extensions.rb file, as it is not needed.

I did note Peff's suggestion to add a macro to enable the use of
Asciidoctor, but I want to defer that until a later point.  There isn't
a released version of Asciidoctor with the necessary changes and I'd
like to avoid confusing users by making them think it will work when it
probably won't.

brian m. carlson (2):
  Documentation: refactor common operations into variables
  Documentation: remove Asciidoctor linkgit macro

 Documentation/Makefile      | 22 +++++++++++-----------
 Documentation/extensions.rb | 39 ---------------------------------------
 2 files changed, 11 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/extensions.rb

-- 
2.1.1
