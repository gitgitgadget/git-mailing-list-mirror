From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/33] Yet more preparation for reference backends
Date: Fri, 10 Jun 2016 08:43:41 -0700
Message-ID: <xmqq8tydgic2.fsf@gitster.mtv.corp.google.com>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
	<575AB797.809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 10 17:43:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBOb7-0003Qb-PT
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 17:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbcFJPnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 11:43:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932099AbcFJPnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 11:43:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A962F21DC4;
	Fri, 10 Jun 2016 11:43:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GtAfsVAtu1uNPAKwDSe9rcgXVWE=; b=Y6HWCW
	GgpR+BlMGQq+m9v0ae5fCzwEYb5gTDZ1C78zFWsy0msiSaglSZl+b/7ThaZ/rX9D
	k0qkJxjExLrfisXenqfGrJGNEE1GygRgAYFOlsPFEGieQXcO2NNHVe/5Uyg5TMrf
	b2LD4j/+1vUUpNzqdhzPjw/R6+UXy21cvH75E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B0Hgsrp67XfPBAhWY6qsn18+ePO6Ggus
	pEoZeKA0UojuYmIqcQFpocEe6p+/OzwHjj8+Ah0k0g9oShYd6XtRRym6qvJ8XKDq
	Bhv/gHtQ/HUhdA3SVjd5ZokZ+RlVXGxURKed/9i46+9vd8iPGv4pjz9a6JGrML8r
	f9Rk1xAq2Wg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A072121DC3;
	Fri, 10 Jun 2016 11:43:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 278F721DC1;
	Fri, 10 Jun 2016 11:43:43 -0400 (EDT)
In-Reply-To: <575AB797.809@alum.mit.edu> (Michael Haggerty's message of "Fri,
	10 Jun 2016 14:50:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C59518C-2F22-11E6-8B3A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297006>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Junio, if you want to incorporate this revised version of the branch in
> your big rewind of next, then we can pretend that the bug was never
> there :-) Otherwise, tell me in what form you would like the fix and I
> will be happy to provide it.

We actually can do both ;-).  That is, when we rewind 'next' after
the upcoming release, we'd queue a series without a bug, but you can
show a preview to the list in a form of an incremental patch so that
others have a chance to see how the end result would look like.

Thanks.
