From: Wincent Colaiuta <win@wincent.com>
Subject: [RFC PATCH 0/3 UPDATED] diff --check enhancements
Date: Wed, 12 Dec 2007 11:03:05 +0100
Message-ID: <1197453788-3097-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 11:03:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ORS-00041S-PM
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 11:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756621AbXLLKDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 05:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756484AbXLLKDV
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 05:03:21 -0500
Received: from wincent.com ([72.3.236.74]:43893 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754903AbXLLKDU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 05:03:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBCA39ui018416;
	Wed, 12 Dec 2007 04:03:10 -0600
X-Mailer: git-send-email 1.5.3.7.1159.g2f071-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68027>

[1/3] Use "whitespace" consistently

Same.

[2/3] "diff --check" should affect exit status

Additional tests added, and one correction (git diff-tree was only
setting the exit status if the --stdin option was passed).

[3/3] New version of pre-commit hook

A demonstration of the benefit of [2/3]; the pre-commit hook
effectively becomes a one-liner.
