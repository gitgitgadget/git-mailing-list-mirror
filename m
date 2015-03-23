From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Draft of Git Rev News edition 1
Date: Sun, 22 Mar 2015 21:49:41 -0700
Message-ID: <xmqq619sb9ne.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1WtwKri8cWABnzeRvxKhdNmUfVw5xm=F4oLrevuOGyUA@mail.gmail.com>
	<CAPc5daVU77hpsWeJb9BhvHW9YwoSVb8Jgc38zZ9xEnx0cB2QDw@mail.gmail.com>
	<CAEcj5uV0adYn_F6D1mmueR5F8N459dgP1TTWmPiEH9NFeDqFeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, David Kastrup <dak@gnu.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dongcan Jiang <dongcan.jiang@gmail.com>,
	Jeff King <peff@peff.net>, Doug Kelly <dougk.ff7@gmail.com>,
	Bharat Suvarna <bharat.bs84@icloud.com>,
	Kevin D <me@ikke.info>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 05:49:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZuJA-0007q7-Mt
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 05:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbbCWEto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 00:49:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751985AbbCWEtn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 00:49:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 429373735B;
	Mon, 23 Mar 2015 00:49:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ey8u2c8Fpn2fUiwUZNF4SMCV168=; b=WqbhiP
	RgRQB5ekWdkqjhMl3rjBfMH/frJpXqYuTGPwqzrxVBTf4VQbJgBU6xnkA0QMXawL
	C+8Fi8rplpIra6v5pEaqIqalTsE4q45KV1TsWu/2gl/p9JYeuv64TWY5PbYdmHcI
	u3diZJOWbev/sgcg5wYsBKjnAIfZfrZ+9keqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AtXTkOa76C4wgbd18Axja9yhMkeFLPZQ
	4zyXOKVN6IVUKG8+5AIziy5ejBj40fLqWk9HP7CUiQkVwPQAwJNrx/lxNrX+EZcu
	EU5+6RnKw125EHOikNOBedQ50wHBJ2fLQSDsrAlglWqBtIKBvQAb/Lk5zr/ZXBii
	C4/AYxAU0tU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 377DD37359;
	Mon, 23 Mar 2015 00:49:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B61437358;
	Mon, 23 Mar 2015 00:49:42 -0400 (EDT)
In-Reply-To: <CAEcj5uV0adYn_F6D1mmueR5F8N459dgP1TTWmPiEH9NFeDqFeQ@mail.gmail.com>
	(Thomas Ferris Nicolaisen's message of "Sun, 22 Mar 2015 21:50:53
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 055AF472-D118-11E4-B7F3-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266124>

Thomas Ferris Nicolaisen <tfnico@gmail.com> writes:

> Good point. There hasn't been a decision on frequency. Weekly is a
> good rhythm for publications seeking readership, but that's a lot of
> work. My vote is we should first aim for a monthly consistent release.
> I'll try working this into the draft, and Christian may change as he
> sees fit.

I agree weekly would be too much for any hobbist, given how
high-volume our list has, but I probably shouldn't have said
"periodical".  Surely, aiming for consistent update is a very good
thing to gain reader trust if anything else, but it is OK if it were
"we will see a new release when enough interesting things happen",
too.

The primary reason I suggested to explicitly state the beginning of
coverage is to set and manage the expectation of the readers.  I
think the current draft roughly covers 1/4 - 1/3 of discussions that
happened in the month of March 2015 and nothing earlier than that,
so "This issue covers what happened in March" or something would be
appropriate.  I'll throw a pull-request.

>>  - As an inaugural edition, we may want to have a word on
>>    how it came in existence by covering the discussion that
>>    led to its birth. Perhaps the discussion that led to the
>>    publication should be made into as an item on its own,
>>    next to "make git-pull a builtin", "Forbid log --graph..." etc.
>>    Because it is neither a review nor a support discussion,
>>    "Reviews & Support" heading may want to become
>>    "Discussions". I think that is a better title for the section
>>    anyway, if its purpose is "what happened on the list that
>>    are not visible from "git log", as I expect future editions
>>    to cover design discussions that advanced the shared
>>    understanding of a problem but not quite solidified to
>>    become a patch series.
>>
>
> I hope it's OK that I leave this bit to Christian.

I took a stab at this myself, and threw another pull-request.

Thanks.
