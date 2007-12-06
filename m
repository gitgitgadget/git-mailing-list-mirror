From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Reroll colorized "git add -i"
Date: Wed,  5 Dec 2007 18:05:06 -0800
Message-ID: <1196906706-11170-4-git-send-email-gitster@pobox.com>
References: <475697BC.2090701@viscovery.net>
 <1196906706-11170-1-git-send-email-gitster@pobox.com>
 <1196906706-11170-2-git-send-email-gitster@pobox.com>
 <1196906706-11170-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 03:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J067Y-0004ZH-MN
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 03:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbXLFCFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 21:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754515AbXLFCFQ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 21:05:16 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46711 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbXLFCFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 21:05:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20071206020514.ZLFX20016.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 5 Dec 2007 21:05:14 -0500
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id ME5D1Y00T1gtr5g0000000; Wed, 05 Dec 2007 21:05:13 -0500
X-Mailer: git-send-email 1.5.3.7-2132-gbd1cf
In-Reply-To: <1196906706-11170-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67218>

Another try of the colorized "git add -i" series.

[PATCH 1/3] Documentation: color.* = true means "auto"

This is a documentation fix that has already been applied to 'master'
(not pushed out yet as of this writing).

[PATCH 2/3] git config --get-colorbool

This allows scripts to figure out if they should use colors.

[PATCH 3/3] Color support for "git-add -i"

This is Dan's colorized git-add -i, but uses --get-color and
--get-colorbool options to git-config.
