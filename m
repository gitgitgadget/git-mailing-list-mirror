From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] git-rev-parse.txt: Document ":path" specifier
Date: Sun, 27 Jun 2010 12:29:56 -0700
Message-ID: <7vocewff4b.fsf@alter.siamese.dyndns.org>
References: <7vpqzfj8zi.fsf@alter.siamese.dyndns.org>
 <6af64ac563a9a165bec7fddc779b31ae5bcb9997.1277644307.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Jun 27 21:30:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSxYj-0007bv-FF
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 21:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230Ab0F0TaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 15:30:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128Ab0F0TaI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 15:30:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DCD2ABFC57;
	Sun, 27 Jun 2010 15:30:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=inLzFN5lEnluib7qTNDiufV94Ko=; b=At1ntF
	81jWAeyL3LLkOsM+KOkPRw+8JhhkCTd8yg0qGh11OR7UtQWoAx/u91Tijz4RN6JR
	1v0eebrRmSP30SuuThnZBhiFORjLGoQ7VVQuS6K/60bTh5RtDRcCkFPaABfaf5rb
	+llwM26I1M4kC1iRHB96/Njw06zMiy+6mN0WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mc+oCZTgooDElsVnDVTtMD7nqW60y+jh
	9l+ZWcJCdFZxGXE0m7Hp6HecUjjOn5tliRQspEza2qnJ1O+tDX8zoh7+U2LztEPa
	KfUTR6DbQ2smSSrfYzhfyBeBlSygbuSL5XbZYT/iidjxqR50zPbyuYN6F5BOn0cg
	9EHNCbETbh0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9312BFC55;
	Sun, 27 Jun 2010 15:30:01 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0299BFC54; Sun, 27 Jun
 2010 15:29:57 -0400 (EDT)
In-Reply-To: <6af64ac563a9a165bec7fddc779b31ae5bcb9997.1277644307.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Sun\, 27 Jun 2010 15\:15\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6141E984-8222-11DF-8E53-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149800>

Thanks, will replace v2 with this versoin, but I suspect that swapping the
two bullets in the existing documentation without anything else may be a
simpler and easier-to-read alternative.

Orthogonal to this, it would probably make sense to give a simplest
example in-line in the text, i.e.

 Documentation/git-rev-parse.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 8db600f..c03f31d 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -291,12 +291,12 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
 
 * A suffix ':' followed by a path; this names the blob or tree
   at the given path in the tree-ish object named by the part
-  before the colon.
+  before the colon (e.g. "HEAD:README").
 
 * A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path; this names a blob object in the
-  index at the given path.  Missing stage number (and the colon
-  that follows it) names a stage 0 entry. During a merge, stage
+  index at the given path (e.g. ":0:README").  Missing stage number (and the colon
+  that follows it) names a stage 0 entry (e.g. ":README"). During a merge, stage
   1 is the common ancestor, stage 2 is the target branch's version
   (typically the current branch), and stage 3 is the version from
   the branch being merged.
