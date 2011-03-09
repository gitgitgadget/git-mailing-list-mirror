From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SubmittingPatches: clean up commit message tips
Date: Wed, 09 Mar 2011 14:20:29 -0800
Message-ID: <7voc5k7x76.fsf@alter.siamese.dyndns.org>
References: <4D77F03B.4050605@gmail.com>
 <1299706069-5463-1-git-send-email-haircut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 23:20:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxRkP-0006c2-33
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 23:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369Ab1CIWUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 17:20:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab1CIWUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 17:20:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58EFC4C28;
	Wed,  9 Mar 2011 17:22:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XJIxXHGT12IfUsFSZbXRERkk0iE=; b=HXpWK5
	Wi9BfVQZJJt9cKqVuXSpRUL+gUZXejSH0TMjKbxjwlzBAaUHVk14XLPV2x3admoH
	jF9Ld0X9obwO1cPNVZxCq7nN3742YN8JLHOkBF2z5SGWTcaNAix2mXAOBVvHVkh/
	h6biJ9wlzo0gPYKURmx/BFpPVwT6/JHbbeeQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D+aTGawi1XqqjVHbEVL4eQq5k+e6v7zF
	/3FKDTYfDhVeX4rhDxhQVEj0cAVTF2zz5jmDM4wk8n7IZuM9IMDcdWJpK16kUx4I
	H8bNaozkiRXcY565GbpBIqjC1ppEiYdKa/FrunGlrQoUelRFRVEWGFZMhtphE4Dd
	hs6bwKaPmdg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 10E424C25;
	Wed,  9 Mar 2011 17:22:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9A5794C24; Wed,  9 Mar 2011
 17:21:59 -0500 (EST)
In-Reply-To: <1299706069-5463-1-git-send-email-haircut@gmail.com> (Adam
 Monsen's message of "Wed, 9 Mar 2011 13:27:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9C66BF2-4A9B-11E0-AFFF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168771>

Adam Monsen <haircut@gmail.com> writes:

> Removed uncommon acronyms in the "Checklist" section. I had to look up
> "iow" online, but this documentation should stand alone (without online
> access) as well as commit messages.

We have only a handful of instances of that phrase in the codebase (run
"git grep" for them), so I am not strongly opposed to spelling it out, but
use of IOW is quite common on this list---I suspect that it is largely
because Linus uses the phrase quite often.  Cf.

    $ git log | grep -e IOW -e '^Author: ' | grep -B1 -e IOW

> Leave wiggle room for including URLs in commit messages.

I don't think the updated text is too bad, but I don't very much like the
above "wiggle room".

The guideline is written to suggest what you absolutely should include; it
is obviously Ok to add other things as necessary.  If common sense tells
the reader external references will help recollection, the guideline does
not forbid to include them. IOW, there are enough wiggle rooms already.

> Modify the section about trivial changes slightly... it makes more sense
> that it is discouraging diffs pasted in emails as opposed to patches
> generated with "git am".

s/am/format-patch/;

> Remove recommendations on commit messages from the "Make separate
> commits for logically separate changes" section,...
> sentence about breaking apart big commits into separate patches.

While I do not particularly hate this part, I think people who did the
"Checklist vs Long Version" meant to make each of them stand on its own.
Lazy people (or people who think they are experienced enough) read the
former, while the others who pride themselves being thorough will skip the
"for-lazy-people" digest version and read only "the real thing".

So overall, I am not enthused by this version.  Input from others may
be appreciated.
