From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitremote-helpers.txt: rename from
 git-remote-helpers.txt
Date: Thu, 31 Jan 2013 12:36:16 -0800
Message-ID: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
References: <7vfw1ijtz2.fsf@alter.siamese.dyndns.org>
 <fc96ae61bb64ce19e856d7a1624e2130c99afd47.1359662569.git.john@keeping.me.uk>
 <vpqpq0lw1ge.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Max Horn <max@quendi.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jan 31 21:37:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10sD-00054E-DP
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab3AaUgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:36:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628Ab3AaUgS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 15:36:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDEACBB36;
	Thu, 31 Jan 2013 15:36:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/IfaOpzs43LpNvwolu6oBoSbKyk=; b=UnIgPH
	Iw7F7fhXo0Yl1FZVrClOekXdwm8Qt9uL35L4kRC4K/9kSX2DwBpM9GzsULM7g5pp
	ILt2pamzUeMSW2ZwSvqlEDrwVAORiFCCqUxa700UPJ8iXRxh+55MNDRTT0KJQFjj
	/Imf2OLMJuVuB1mFw/buHiSH0RvsDgCcDI3eE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xwm51jN3299UkybRMmagzIZ56vokqEFi
	OWQCzu3cK6Qtw4xDh4QqorAnUJfEAR8OxqXQeM+Iy0lpS4bIWfbNFnjwRwV1JwMk
	DU9qxYYuPFdcQ/n8u/vF9x6+9WPKEpJTbQNGan/+YGy5XPvMM28dbjrpKG9KOglu
	lzIEZRqyfx4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E35F9BB34;
	Thu, 31 Jan 2013 15:36:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68E6FBB32; Thu, 31 Jan 2013
 15:36:17 -0500 (EST)
In-Reply-To: <vpqpq0lw1ge.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Thu, 31 Jan 2013 21:18:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD05FD12-6BE5-11E2-B785-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215166>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> John Keeping <john@keeping.me.uk> writes:
>
>> Would we want to do something to avoid breaking links to the existing
>> document as well?
>
> That would be nice to add a new git-remote-helpers.txt saying "document
> has moved, see linkgit:gitremote-helpers.txt[1], so that HTML links to
> http://git-scm.com/docs/git-remote-helpers and friends do not get
> broken, yes.

Yeah, John's patch fixes internal links, but this will make links
from other sites stale.  Adding to our installation rule to put a
handcrafted HTML page that says "The document moved here; please let
the owners of the referring site to know so that they can update the
link you clicked to get here" would be appropriate, I think.
