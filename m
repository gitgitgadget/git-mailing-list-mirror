From: Pierre Habouzit <madcoder@debian.org>
Subject: proposal for an OPTION_SUBARRAY (recursive parser)
Date: Mon,  5 Nov 2007 13:03:20 +0100
Message-ID: <1194264204-3475-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 05 13:03:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip0gB-0002EE-Js
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbXKEMD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 07:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbXKEMD1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:03:27 -0500
Received: from pan.madism.org ([88.191.52.104]:52831 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881AbXKEMD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:03:26 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4E5CF28874;
	Mon,  5 Nov 2007 13:03:25 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 61B787D21; Mon,  5 Nov 2007 13:03:24 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1531.g59008
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63500>

While working on OPTION_SUBARRAY I noticed a quite bad bug in how
abbrevations are dealt with, here is the fix, should be applied to next:
  [PATCH 1/4] parse-options: abbreviation engine fix.

Here is a better documentation of the struct option, only touch
comments, safe for next:
  [PATCH 2/4] Some better parse-options documentation.

Here is a 2 patch series that implement recursion and option relocation
of struct options when nested:
  [PATCH 3/4] Add OPTION_BASEOFFSET/OPTION_SUBARRAY.
  [PATCH 4/4] Implement OPTION_SUBARRAY handling.

Those two patch have nor real reason to go anywhere else than pu yet, I
post them for review and comments, and will probably base diff/log
migration on those soon.
