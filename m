From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ambiguous argument '...': unknown revision or path not in the
 working tree
Date: Sun, 17 Jan 2010 22:59:33 -0800
Message-ID: <7v3a23ucdm.fsf@alter.siamese.dyndns.org>
References: <87ska5vzbs.fsf@turtle.gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Joachim <svenjoac@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 18 07:59:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWlaY-00040z-D1
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 07:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab0ARG7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 01:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834Ab0ARG7n
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 01:59:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab0ARG7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 01:59:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4381A92635;
	Mon, 18 Jan 2010 01:59:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2QPI3jmnMLXbgMULypvkR+8uq4g=; b=aDbfJV
	ExVnBAnKjwBBVW8r+0+AyXkIszLcWn7y2g4lo0NmFWYZMsVLW1BEaZVmCZXyhOTm
	hey0DBAeC9b8dPVYsEoVk2t3uzVKhs92enrQGbSFuNfTB4hbn1/Vu4nYQa/4wTG4
	tm07KbBYpJr3wevg/zAWnAGPNNpnZWx9bGlmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AIJxBfA7aaMjGbGyPOiKclwgDV+ZAPmC
	OZFqZlAcZojsIAG34XR8TjvDLuqPMs4jFPjRAqNgleGjfjVb9+NNChegSGqFfRLa
	Fj2XbwZl7Ay5xqXsXviZ1K5CH8cxi7mqmrG7FunzGS78IZ0aNW4ek5MR/Qb7ACHC
	1IgpXfE7tTQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E30892634;
	Mon, 18 Jan 2010 01:59:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74EA792631; Mon, 18 Jan
 2010 01:59:35 -0500 (EST)
In-Reply-To: <87ska5vzbs.fsf@turtle.gmx.de> (Sven Joachim's message of "Sun\,
 17 Jan 2010 10\:46\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0B070690-03FF-11DF-8220-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137373>

Sven Joachim <svenjoac@gmx.de> writes:

> I've got a strange error message in 'git push':
>
> ,----
> | % git push
> | Counting objects: 47, done.
> | Delta compression using up to 2 threads.
> | Compressing objects: 100% (24/24), done.
> | Writing objects: 100% (24/24), 4.37 KiB, done.
> | Total 24 (delta 22), reused 0 (delta 0)
> | fatal: ambiguous argument '3bbc6def8a06e4411bee130b811ff9507e90503d:debian/changelog': unknown revision or path not in the working tree.
> | Use '--' to separate paths from revisions

I think there is nothing "fatal" in your git setup, other than that the
repository at the remote end you are pushing into has a broken hook script
(perhaps update, post-receive, or post-update) that is issuing the error
message.  I would raise the issue with the owner of the repository if I
were you.
