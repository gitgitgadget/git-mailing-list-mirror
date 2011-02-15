From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 00/10] Cleaning up --help-all inconsistencies
Date: Tue, 15 Feb 2011 11:02:56 -0800
Message-ID: <7v1v39p1cv.fsf@alter.siamese.dyndns.org>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
 <cover.1297774306.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 20:03:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpQBB-0000Kz-3V
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 20:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab1BOTDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 14:03:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706Ab1BOTDL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 14:03:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C99BD3034;
	Tue, 15 Feb 2011 14:04:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p6EmEuzlaxGvE/czMOaa9tdBrKM=; b=Mhwr27
	JasTJ52Xz+F5I8m11f94Xq1gPVIg6SHWiKnBIeEgfNBjkOTvl8IUCK7v6JRqLAfD
	oaUzrINjOkOpKVbsxDUiN2hgebHO6WnazVFXPzyU7McrdQFz1Uo44/hDIvo2M/Oh
	W9r1oaEC+SVXztSTMEZ+FjBfuN3rTWgmiKRHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gE1Q/GLupKeUZqzmKEQ090G2eUcWCsmt
	C585Hp9fGhx+x56NcW0ukPOGI6Z/mKE1xoLcyScqZVjv35b0HFkfkfVeuoC7p5Au
	Jpt2x3mYBXPP59EzS2pGgc2FFgeMQGBEbkEaH424fTxKx+Jgnueo07/7/9csW5f/
	3LfcTodWimU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78019302E;
	Tue, 15 Feb 2011 14:04:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C58173028; Tue, 15 Feb 2011
 14:04:04 -0500 (EST)
In-Reply-To: <cover.1297774306.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Tue\, 15 Feb 2011 14\:09\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F8277AA-3936-11E0-B32A-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166866>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> v2 incorporates the changes as discussed so far.

Looked reasonable; thanks.

> It comes with three bonus patches which enforce the use of lowercase
> <identifiers> (as per CodingGuidelines) in command messages (usage).
>
> Besides the guidelines, this is also the prevailing style in code.

Not that I am opposed to this change, but I don't see anything that says
we want lower-case in CodingGuidelines. "Placeholders are enclosed in
angle brackets." is the only thing it says as far as I can tell.

So perhaps insert this before the last three patches.

-- >8 --
Subject: CodingGuidelines: downcase placeholders in usage messages

We accumulated some inconsistencies without an explicit guidance to spell
this out over time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index ba2006d..fe1c1e5 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -152,7 +152,7 @@ Writing Documentation:
  when writing or modifying command usage strings and synopsis sections
  in the manual pages:
 
- Placeholders are enclosed in angle brackets:
+ Placeholders are spelled in lowercase and enclosed in angle brackets:
    <file>
    --sort=<key>
    --abbrev[=<n>]
