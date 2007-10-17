From: Jonathan del Strother <maillist@steelskies.com>
Subject: [PATCH] Quoting paths, take 3
Date: Wed, 17 Oct 2007 10:31:34 +0100
Message-ID: <11926134961610-git-send-email-maillist@steelskies.com>
References: <B495731E-C854-450B-943B-B96248B8F609@steelskies.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 11:31:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii5Fm-0004q0-Gl
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 11:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758466AbXJQJbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 05:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757803AbXJQJbi
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 05:31:38 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:53721 "EHLO
	gir.office.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437AbXJQJbi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 05:31:38 -0400
Received: by gir.office.bestbefore.tv (Postfix, from userid 501)
	id 643A72B97FC; Wed, 17 Oct 2007 10:31:36 +0100 (BST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <B495731E-C854-450B-943B-B96248B8F609@steelskies.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61359>


These patches attempt to fix things up for people who like to have awkward directory paths including spaces & apostrophes.  First patch fixes git-rebase (all other git tools handle these paths fine), second patch fixes up the tests so they can be run from spaced directories.
Third time lucky?
