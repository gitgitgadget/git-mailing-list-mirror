From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation: git-cherry uses git-patch-id
Date: Wed, 28 May 2008 17:04:53 -0700
Message-ID: <7v7idern4q.fsf_-_@gitster.siamese.dyndns.org>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com>
 <7v1w3muw8j.fsf@gitster.siamese.dyndns.org>
 <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com>
 <7vod6qtgfs.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0805281242w5769a100s1153c2101992ff55@mail.gmail.com>
 <7v3ao2tawd.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0805281414x6b97070ag7a1cc36f5d3c5a36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Geoffrey Irving" <irving@naml.us>
X-From: git-owner@vger.kernel.org Thu May 29 02:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1VeU-0001BT-48
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 02:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbYE2AFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 20:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbYE2AFE
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 20:05:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYE2AFC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 20:05:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A7A73BE9;
	Wed, 28 May 2008 20:05:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B777B3BE8; Wed, 28 May 2008 20:04:56 -0400 (EDT)
In-Reply-To: <7f9d599f0805281414x6b97070ag7a1cc36f5d3c5a36@mail.gmail.com>
 (Geoffrey Irving's message of "Wed, 28 May 2008 14:14:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E20DA3C6-2D12-11DD-AA92-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83153>

"Geoffrey Irving" <irving@naml.us> writes:

> On Wed, May 28, 2008 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Thanks.
>>
>> In manual pages, "SEE ALSO" section is a more appropriate place to do this
>> kind of thing.
>
> Here's an improved patch.

Thanks, I'll do this instead...

-- >8 --
Geoffrey Irving noticed that git-cherry talks about comparing commits without
hinting how they are compared.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-cherry.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index b0468aa..d8e0a5b 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -13,6 +13,8 @@ DESCRIPTION
 -----------
 The changeset (or "diff") of each commit between the fork-point and <head>
 is compared against each commit between the fork-point and <upstream>.
+The commits are compared with their 'patch id', obtained from linkgit:git-patch-id[1]
+program.
 
 Every commit that doesn't exist in the <upstream> branch
 has its id (sha1) reported, prefixed by a symbol.  The ones that have
@@ -56,6 +58,10 @@ OPTIONS
 <limit>::
 	Do not report commits up to (and including) limit.
 
+SEE ALSO
+--------
+linkgit:git-patch-id[1]
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
-- 
1.5.6.rc0.43.g823ea
