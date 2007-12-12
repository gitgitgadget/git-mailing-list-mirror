From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 0/4] Refactoring for apply and diff
Date: Wed, 12 Dec 2007 17:22:58 +0100
Message-ID: <1197476582-18956-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 17:24:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2UNm-0002gM-O0
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 17:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015AbXLLQXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 11:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755889AbXLLQXl
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 11:23:41 -0500
Received: from wincent.com ([72.3.236.74]:44671 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755859AbXLLQXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 11:23:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBCGN3CG026521;
	Wed, 12 Dec 2007 10:23:04 -0600
X-Mailer: git-send-email 1.5.3.7.1159.g2f071-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68068>

4 more patches which apply on top of the "git diff --check" topic I
posted previously. If you'd prefer any of these to be prepared for
application on top of "master" or "next" let me know.

[1/4] Fix "diff --check" whitespace detection

Fix bug noticed while comparing the whitespace checks in "git apply"
and "git diff". It's exactly this kind of bug which motivates the
refactoring which follows...

[2/4] Extract and improve whitespace check from "git apply"

Extract (and improve) some stuff out of "apply"...

[3/4] Make "diff --check" use shared whitespace functions

... so that the same code can be used by "diff".

[4/4] Add tests for "git diff --check" with core.whitespace options

Cheers,
Wincent
