From: Joey Hess <joey@kitenet.net>
Subject: extended hook api and tweak-fetch hook
Date: Thu, 29 Dec 2011 21:07:17 -0400
Message-ID: <1325207240-22622-1-git-send-email-joey@kitenet.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 03:30:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgSF1-00089c-9G
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 03:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754872Ab1L3CaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 21:30:10 -0500
Received: from wren.kitenet.net ([80.68.85.49]:54718 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171Ab1L3CaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 21:30:08 -0500
Received: from gnu.kitenet.net (dialup-4.153.83.252.Dial1.Atlanta1.Level3.net [4.153.83.252])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 58012119287
	for <git@vger.kernel.org>; Thu, 29 Dec 2011 21:30:04 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 31A2C46963; Thu, 29 Dec 2011 20:07:35 -0500 (EST)
X-Mailer: git-send-email 1.7.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187791>

This patch series adds an extended hook API, and uses it to implement
the new tweak-fetch hook.

The remaining hooks (that do not already use run_hook()) could be
refactored later to use this new API.

Also, the API has been designed to allow several programs to be run
for a single hook, when someone wants to add that into git.
