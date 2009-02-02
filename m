From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] "add -p" enhancements
Date: Sun,  1 Feb 2009 19:42:36 -0800
Message-ID: <1233546159-30347-1-git-send-email-gitster@pobox.com>
Cc: William Pursell <bill.pursell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 04:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTpjK-0006QD-Rw
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 04:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbZBBDmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 22:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753672AbZBBDms
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 22:42:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbZBBDmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 22:42:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 16E3F2A438;
	Sun,  1 Feb 2009 22:42:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 59F4C2A436; Sun, 
 1 Feb 2009 22:42:41 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.331.g8c4c8
X-Pobox-Relay-ID: 8C265FD8-F0DB-11DD-9A44-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108041>

I've looked at an earlier series by William Pursell to add "Find hunk"
action to "git add -p" and it was fairly trivial to resurrect.  I'll be
queuing them to 'next' unless people object.

William Pursell (3):
  git-add -i/-p: Change prompt separater from slash to comma
  Add / command in add --patch
  In add --patch, Handle K,k,J,j slightly more gracefully.

 git-add--interactive.perl |   81 +++++++++++++++++++++++++++++++++------------
 1 files changed, 60 insertions(+), 21 deletions(-)
