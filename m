From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2009, #07; Sun, 29)
Date: Sun, 29 Nov 2009 23:34:32 -0800
Message-ID: <7vfx7wxy7r.fsf@alter.siamese.dyndns.org>
References: <7vocmlbq8d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 08:34:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF0mS-0002n6-Vy
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbZK3Hed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbZK3Hec
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:34:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbZK3Hec (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:34:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1875F140D;
	Mon, 30 Nov 2009 02:34:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JKbxXVijzEgY168cC2XWuyNUk5w=; b=c98Zci
	cVp2ALqxh+QPZWTBBWeRyIVcNQdSCXOEBn/JkJX+6sksYiaDtklEN/SBvGJfk2pZ
	+bZSf4HZbBo8lFtzykLfFPYhEdclTGkKKCmZO1zE38q9vt+NJOALyxhv1HL0lMbp
	0dTIS/2KFAJCU+DUFgiMlkzMfawtYx2XNSdgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dxz4Ks2cZjsFUf/Hlox+npK8o6EwI7Ym
	R0RktBS8xa82F1FV736v7PeJfdqSZg0Dv+3uNmnOmWBWoCDMoPWRBGAMGqJRXlLE
	G8bfYPnX0jamlFGZv6vU6H80qDlZd0Qfjm+/EBRIiLrEyAnuW42+QjSeJN2Dm5YH
	C5hzV2g8hbg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 06A88140B;
	Mon, 30 Nov 2009 02:34:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 459FC140A; Mon, 30 Nov
 2009 02:34:34 -0500 (EST)
In-Reply-To: <7vocmlbq8d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 29 Nov 2009 02\:05\:38 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CFD36C00-DD82-11DE-979A-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134068>

Junio C Hamano <gitster@pobox.com> writes:

> This will be the last update before deciding what should go in 1.6.6-rc1
> and describes my current thinking.

I do not want to decide unilaterally what will be in and what will be left
out of 1.6.6, so here is a seocnd call for comments.

I said "Perhaps merge it to 'master' before 1.6.6-rc1?" for these:

> * uk/maint-shortlog-encoding (2009-11-25) 1 commit.
> * fc/send-email-envelope (2009-11-26) 2 commits.
> * jc/mailinfo-remove-brackets (2009-07-15) 1 commit.
> * tr/reset-checkout-patch (2009-11-19) 1 commit.
> * em/commit-claim (2009-11-04) 1 commit
> * cc/bisect-doc (2009-11-08) 1 commit
> * jc/pretty-lf (2009-10-04) 1 commit.
> * ns/send-email-no-chain-reply-to (2009-11-29) 1 commit

I didn't say so in the message but I think this is Ok for 1.6.6-rc1.

> * bw/diff-color-hunk-header (2009-11-27) 2 commits

I would love to see necessary fix-ups to make them suitable and include in
the 1.6.6 final for these:

> * jn/gitweb-blame (2009-11-24) 8 commits.

I am inclined to keep the rest out of 1.6.6.

Even though I did it myself, I am ambivalent about the diff.bwoutputonly
anti-procrastination measure.  The send-email one looked fine and is a
welcome addition to the "don't surprise users" effort to prepare for 1.7.0,
and diff.bwoutputonly is in a sense in a similar spirit, but an option to
keep an old and broken semantics feels somewhat wrong.

Also anybody has comments on the part for preparing users for 1.7.0 in the
draft release notes?
