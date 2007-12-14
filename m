From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 0/3] diff topic tweaks
Date: Fri, 14 Dec 2007 12:23:41 +0100
Message-ID: <1197631424-52586-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 12:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38ez-0002kz-0j
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 12:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760117AbXLNLYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 06:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757654AbXLNLYS
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 06:24:18 -0500
Received: from wincent.com ([72.3.236.74]:50227 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754527AbXLNLYR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 06:24:17 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBEBNkhW018244;
	Fri, 14 Dec 2007 05:23:47 -0600
X-Mailer: git-send-email 1.5.4.rc0.1099.g76fa0-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68295>

I've eyeballed and done some testing of the changes that Junio
pushed out to "next" and they all look good to me.

Some minor adjustments:

[1/3] Revert changes and extend diff option documentation

Seeing as Junio's adjustments changed the behaviour, the
documentation needs to be changed as well.

[2/3] Use shorter error messages for whitespace problems

Cosmetic only.

[3/3] Test interaction between diff --check and --exit-code

Just to make sure it does what we think it does (and it does).

Cheers,
Wincent
