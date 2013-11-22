From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Fri, 22 Nov 2013 12:05:25 -0800
Message-ID: <xmqqr4a8yzga.fsf@gitster.dls.corp.google.com>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
	<20131122102345.GC12042@sigill.intra.peff.net>
	<xmqq61rk1b52.fsf@gitster.dls.corp.google.com>
	<CAFFjANQy72zLuxtpA+-nMhYEt=qfOu_FSszR8X7QNPTKBEi6tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Vicent =?utf-8?Q?Mart=C3=AD?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 21:05:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjwyu-0003Y7-BW
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 21:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab3KVUFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Nov 2013 15:05:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755723Ab3KVUFb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Nov 2013 15:05:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AD8854D72;
	Fri, 22 Nov 2013 15:05:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=e9UY+LDlyn3a
	pu2pvE2VAbO3bP8=; b=a5HGdzXp67OZiqaD7whQHTh4p4nKm7kv1GfF4ESplJET
	ih1BmxTZEiwYVe8LIKRZk+LBCUZr+AS0DpCQ9Zmr3hXonOwOuqaH8yLuYV56n17y
	fmjWr7/4qKzqBKoFQPCRpYcgTPm0cLlohwDzGSpFb8ViVgO3ukhqvdZc3Vhv5GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f2JHu4
	qqC0TIgWNzt5P7hkR/TYW6CXI1GZsgDckpsag+v2fVdgKMEjJvzHuFynYXiH8Mu6
	CafT++piKQFK+iU1SOEpcq9E+ynGMONibe9cd5LSADEr2U+1N2IxME5kBRUKZFZc
	5eB4shb3qXSROQbTvTuYUQ5qCPyEW08cCJ8+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3C7454D70;
	Fri, 22 Nov 2013 15:05:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A98354D6F;
	Fri, 22 Nov 2013 15:05:28 -0500 (EST)
In-Reply-To: <CAFFjANQy72zLuxtpA+-nMhYEt=qfOu_FSszR8X7QNPTKBEi6tA@mail.gmail.com>
	("Vicent =?utf-8?Q?Mart=C3=AD=22's?= message of "Fri, 22 Nov 2013 20:47:25
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6EC23A82-53B1-11E3-A9BB-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238211>

Vicent Mart=C3=AD <tanoku@gmail.com> writes:

> On Fri, Nov 22, 2013 at 8:36 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>
> We are running a slightly older version of the patchset, because we'r=
e
> still on 1.8.4 and the current reroll doesn't apply cleanly there.
>
> If this could make it to `next` some time next week, that would work
> out great for us, because we may start considering using `next` as a
> partial or full deployment on our production machines

I do not think potentially incompatible stuff that are slated for
2.0 that have been cooking in 'next' affects the server side, so
that may be a good and safe move.

> This also means that we could exercise the patchset and everything
> else that is queued up in next release...

There is no 'next release' though; there is no guarantee what is
cooking in 'next' will be in any future release ;-).

In any case, it is nice to see that people from a large hosting site
finally taking a hint from my occasional light complaints that come
after "thanks for reporting" whenever I see regression and breakage
report soon after a topic graduates to 'master' ;-).  It is good to
see that more people starting to adopt the 'next' branch early for
wider testing.

Thanks.
