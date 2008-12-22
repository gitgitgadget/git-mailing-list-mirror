From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: [PATCHv3] Have git revert documentation reference new HOWTO on reverting faulty merges.
Date: Sun, 21 Dec 2008 18:26:03 -0600
Message-ID: <200812211826.03208.bss@iguanasuicide.net>
References: <200812201832.48992.bss@iguanasuicide.net> <E1LEVxk-0001jS-Cc@rei.iguanasuicide.net> <7vy6y9kxdh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 01:27:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEYdY-0007Tt-9c
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 01:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbYLVAZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 19:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbYLVAZu
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 19:25:50 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:44682 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbYLVAZt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 19:25:49 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LEYcF-0001uI-SJ; Mon, 22 Dec 2008 00:25:47 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <7vy6y9kxdh.fsf@gitster.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy.
Content-Disposition: inline
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103735>

Signed-off-by: Boyd Stephen Smith Jr <bss@iguanasuicide.net>
---
On Sunday 2008 December 21 15:54:18 Junio C Hamano wrote:
> Thanks.  I was thinking about doing this instead; how the reference to the
> HOW-TO is done is different, and I am hoping that it would give better
> result for HTML version at least.

Here's a pruned version of my prose, with your link style.  I prefer my prose
because I don't want to use the word "branch", which implies refs having some
important in the later merges, which is not the case from what I understand.

 Documentation/git-revert.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index caa0729..ee9cb82 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -44,6 +44,14 @@ OPTIONS
 	option specifies the parent number (starting from 1) of
 	the mainline and allows revert to reverse the change
 	relative to the specified parent.
++
+Reverting a merge commit declares that you will never want the tree changes
+brought in by the merge.  As a result, later merges will only bring in tree
+changes introduced by commits that are not ancestors of the revert commit.
+This may or may not be what you want.
++
+See the link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for
+more details.
 
 --no-edit::
 	With this option, 'git-revert' will not start the commit
-- 
1.6.0.2
-- 
Boyd Stephen Smith Jr.                     ,= ,-_-. =. 
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-' 
http://iguanasuicide.net/                      \_/     
