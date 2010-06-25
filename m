From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-rev-parse.txt: Document ":path" specifier
Date: Fri, 25 Jun 2010 10:52:01 -0700
Message-ID: <7vpqzfj8zi.fsf@alter.siamese.dyndns.org>
References: <7vvd98b1jh.fsf@alter.siamese.dyndns.org>
 <633f42d1967049780d66cf72552b22ae17bbbead.1277476258.git.git@drmicha.warpmail.net> <vpqvd97rv5q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 25 19:52:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSD4e-0001iw-BM
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 19:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579Ab0FYRwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 13:52:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab0FYRwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 13:52:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09FC0BF1DC;
	Fri, 25 Jun 2010 13:52:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GiHQOhl6mGoCBCJFAHjUsFHVw0w=; b=idPCbb
	ZJ8AiHZ5DVcKvn5AZVy94Px3S6m8tR+b55cfr5hpU/uptxYp/v4q3bBYD+Qdf6FX
	fts5ciPPT0LB9PG7d476I1r4Tn91hq0p8w3uGcNLxUZ53PuPY4wJV3G06Q5P3sNc
	dIpP7Nz+u37iKEZIw0fOGbGAEgfNdE8QcVdZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VfZxeNtyBmMZG3aEi9FwhzyCaWynWKO6
	8s9pCNHnG01kl49imlmWan2AM0jeEKE7wA5CUCnnpTEpqXWVPLQn3Rz8VLEl2WR7
	9kG9k/oC7QEOeIozYeK3/dHFBlkV4K1s24+rVxVblgsphL//DirNngds6eM6tWkQ
	UfqncEe8W+4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C824BBF1DB;
	Fri, 25 Jun 2010 13:52:06 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1096DBF1DA; Fri, 25 Jun
 2010 13:52:02 -0400 (EDT)
In-Reply-To: <vpqvd97rv5q.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri\, 25 Jun 2010 17\:25\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5EBCA48E-8082-11DF-B29D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149700>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Actually, what you're adding is precisely what was already documented
> right below:
>
>>  * A colon, optionally followed by a stage number (0 to 3) and a
>>    colon, followed by a path; this names a blob object in the
>      index at the given path.  Missing stage number (and the colon
>      that follows it) names a stage 0 entry. During a merge, stage
>      1 is the common ancestor, stage 2 is the target branch's version
>      (typically the current branch), and stage 3 is the version from
>      the branch being merged.
>
> Probably it's not obvious enough and your patch is worth it, but then
> it would be less confusing if you added "(see next item)." at the end
> of your sentence.

Another possibility is to swap the order of presentation.  It might reduce
the confusion of ':path' form appearing to be a variant of 'tree:path',
and that is what invited the "what happens when tree is an empty string"
question, I think.
