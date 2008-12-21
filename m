From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Have manpage reference new documentation on reverting
 merges.
Date: Sun, 21 Dec 2008 13:54:18 -0800
Message-ID: <7vy6y9kxdh.fsf@gitster.siamese.dyndns.org>
References: <200812201832.48992.bss@iguanasuicide.net>
 <7vtz8ytft0.fsf@gitster.siamese.dyndns.org>
 <E1LEVxk-0001jS-Cc@rei.iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Dec 21 22:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWH7-0000q5-Em
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 22:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbYLUVy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 16:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbYLUVyZ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 16:54:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbYLUVyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 16:54:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D53089283;
	Sun, 21 Dec 2008 16:54:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7BD5E89280; Sun,
 21 Dec 2008 16:54:20 -0500 (EST)
In-Reply-To: <E1LEVxk-0001jS-Cc@rei.iguanasuicide.net> (Boyd Stephen Smith,
 Jr.'s message of "Sun, 21 Dec 2008 15:35:18 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE329582-CFA9-11DD-B85A-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103715>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

> I took the alternative approach.

Thanks.  I was thinking about doing this instead; how the reference to the
HOW-TO is done is different, and I am hoping that it would give better
result for HTML version at least.

 Documentation/git-revert.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git c/Documentation/git-revert.txt w/Documentation/git-revert.txt
index caa0729..b87f2b3 100644
--- c/Documentation/git-revert.txt
+++ w/Documentation/git-revert.txt
@@ -44,6 +44,15 @@ OPTIONS
 	option specifies the parent number (starting from 1) of
 	the mainline and allows revert to reverse the change
 	relative to the specified parent.
++
+By reverting a merge, you are telling git that you never want the changes
+the merge made to your tree.  If the branch the reverted merge merged is
+updated later, and you merge from it again, git remembers this, and only
+brings in the changes on the branch that are made after the previously
+reverted merge.  This may or may not be what you want.
++
+See link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for
+more details.
 
 --no-edit::
 	With this option, 'git-revert' will not start the commit
