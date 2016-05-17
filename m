From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Ignore dirty submodule states during stash
Date: Tue, 17 May 2016 10:04:32 -0700
Message-ID: <xmqqa8joy5sv.fsf@gitster.mtv.corp.google.com>
References: <20160517131635.GA5299@gmail.com>
	<xmqqmvnoy82r.fsf@gitster.mtv.corp.google.com>
	<CABSveYgsRU+L5qvY_evwekaRU7-oL_2Mmxt6L1u2dYM7Xfq2rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vasily Titskiy <qehgt0@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 19:04:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2iQD-0001A6-5T
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 19:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbcEQREh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 13:04:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750941AbcEQREg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 13:04:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 346E91C052;
	Tue, 17 May 2016 13:04:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jLzAjkFmoK3X4vywnTo/mOmStBY=; b=v4U3lV
	jctECynFImEm5LchbgqlGdK7XKZkFiz90xXRZ6voLOfzMV7bTHTWi2nan3hH3m5B
	qvjlFhL3P3IDPrWzAmxnhrOLaIIAWJfDgQ+nZLrpO7n0Ew7u42nlZzgY3L7DMVoA
	BJN/pNQoS74TEL9H1zpwiiAWFqSsozQfB+zPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y5qMmi4aFvzo3k0Kj+XasRP25KAaCqFV
	no9voT2zZG5b78z54QW74Hg3W0poHote1AI0NXarJFv37/obVrZBQIUP3M/4pYGl
	0GrXQrG9jvVA0rvyw+mtbqHOMihy4soX3n2DxGZvGWwteh8TF6AMFAfrSafrnQ2X
	QRFYL0Cdujk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B2451C051;
	Tue, 17 May 2016 13:04:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2AC61C050;
	Tue, 17 May 2016 13:04:34 -0400 (EDT)
In-Reply-To: <CABSveYgsRU+L5qvY_evwekaRU7-oL_2Mmxt6L1u2dYM7Xfq2rw@mail.gmail.com>
	(Vasily Titskiy's message of "Tue, 17 May 2016 12:38:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E1E48D0-1C51-11E6-8BD3-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294878>

Vasily Titskiy <qehgt0@gmail.com> writes:

> You're right, it's redundant here. Should I resubmit the path without this line?

I wasn't pointing out that it was not needed.  I was only asking
what it was meant to do.

If you now think it shouldn't have been there, that merely means
your code was wrong.  It does not mean I'm right ;-)

With that line removed, would the patch now becomes right?  Are
there other bugs?
