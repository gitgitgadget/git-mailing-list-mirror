From: David Kastrup <dak@gnu.org>
Subject: [PATCH 0/2] Two mostly janitorial patches for builtin/blame.c
Date: Wed, 22 Jan 2014 01:20:13 +0100
Message-ID: <1390350015-3040-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 01:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5lYU-0006u2-LF
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 01:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbaAVAU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 19:20:26 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:47883 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaAVAU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 19:20:26 -0500
Received: from localhost ([127.0.0.1]:46926 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W5lYP-0007h1-49; Tue, 21 Jan 2014 19:20:25 -0500
Received: by lola (Postfix, from userid 1000)
	id B9EE7E051D; Wed, 22 Jan 2014 01:20:24 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240806>

Same series as sent previously, just signed off this time.

David Kastrup (2):
  builtin/blame.c: struct blame_entry does not need a prev link
  Eliminate same_suspect function in builtin/blame.c

 builtin/blame.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

-- 
1.8.3.2
