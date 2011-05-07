From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #03; Fri, 6)
Date: Sat, 07 May 2011 12:11:30 -0700
Message-ID: <7vk4e2wckd.fsf@alter.siamese.dyndns.org>
References: <7v7ha3xvm1.fsf@alter.siamese.dyndns.org>
 <20110507014634.GB25771@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 07 21:11:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QImuk-0001iy-Ky
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 21:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab1EGTLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 15:11:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754973Ab1EGTLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 15:11:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 045F943F2;
	Sat,  7 May 2011 15:13:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PJIdl9RW8Qy1VWlJQS36ClTitdY=; b=W0fvKCz/KPfALM7yofWx
	faYR/WRk3fF6uWEslNtRK5gNe9rcCqb18WIJ1hAcc3vUz0mV+UxyDVacjAGtmplm
	L68Ignk3FZBgWE1gmRq4btHkC1azUhanEfYacDx4MBtVCVKcKwL1BvdywLBBAU6J
	qdavMoMk4Cn9rUClRe5PDXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VtZMwkpTAaHGjYPdl8EiaDA9JsAoVGffsuFh0aNBZ8L6e0
	Be+TVl7FqDf1URjWXW9lkN+0S0RZOwOZef4Wai9IFZ9Gt+Ao6y2iDaaqfWzMViQc
	5A+nlx7UxO6CwelEzYA2j7HD5NKve+v/7t+zptN0Fs5OWVQru7iVSFCOIk7FI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D5A9C43F1;
	Sat,  7 May 2011 15:13:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DF3DA43F0; Sat,  7 May 2011
 15:13:36 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DB9741C-78DE-11E0-98D5-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173063>

Jeff King <peff@peff.net> writes:

> On Fri, May 06, 2011 at 04:22:30PM -0700, Junio C Hamano wrote:
>
>> * jk/merge-one-file-working-tree (2011-04-29) 2 commits
>>   (merged to 'next' on 2011-05-02 at 308fe21)
>>  + merge-one-file: fix broken merges with alternate work trees
>>  + add tests for merge-index / merge-one-file
>
> Hmm, I expected this to end up on maint. Is it worth cherry-picking
> (it cleanly applies to maint)?

I was careless while updating the draft release notes.  The topic was
deliberately forked from a point that is old enough that the topic can
later be merged to older maintenance tracks.

Thanks for noticing.

 Documentation/RelNotes/1.7.6.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes/1.7.6.txt b/Documentation/RelNotes/1.7.6.txt
index 8554918..7f83318 100644
--- a/Documentation/RelNotes/1.7.6.txt
+++ b/Documentation/RelNotes/1.7.6.txt
@@ -38,9 +38,6 @@ Updates since v1.7.5
  * "git merge" learned "-" as a short-hand for "the previous branch", just
    like the way "git checkout -" works.
 
- * "git merge-one-file" learned to honor GIT_WORK_TREE settings when
-   handling "both sides added, differently" conflict.
-
  * "git rev-list --count" used with "--cherry-mark" counts the cherry-picked
    commits separately, producing more a useful output.
 
@@ -84,6 +81,10 @@ included in this release.
    From: "Junio C. Hamano" <jch@example.com>).
    (merge jk/format-patch-quote-special-in-from later)
 
+ * "git merge-one-file" did not honor GIT_WORK_TREE settings when
+   handling a "both sides added, differently" conflict.
+   (merge jk/merge-one-file-working-tree later)
+
  * "git mergetool" did not handle conflicted submoudules gracefully.
    (merge jm/mergetool-submodules later)
 
