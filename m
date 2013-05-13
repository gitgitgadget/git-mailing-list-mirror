From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-prompt.sh: strip unnecessary space in prompt string
Date: Mon, 13 May 2013 06:58:28 -0700
Message-ID: <7vvc6noubf.fsf@alter.siamese.dyndns.org>
References: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
	<1368289513-8700-2-git-send-email-artagnon@gmail.com>
	<7v61ynsci8.fsf@alter.siamese.dyndns.org>
	<CALkWK0m0dT-sX=nu5jaDj=y1oOSo0cRKQ=2K_S-yepnsm8ny7A@mail.gmail.com>
	<20130513091718.GA21636@goldbirke>
	<CALkWK0m+mG39W7RqU-9KfPWLnaey5pL+jvfdZg49ixsASE+QoQ@mail.gmail.com>
	<20130513110551.GT2331@goldbirke> <20130513111143.GU2331@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon May 13 15:58:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbtGt-0000GT-ME
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab3EMN6c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 May 2013 09:58:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab3EMN6b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 May 2013 09:58:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB35E1C153;
	Mon, 13 May 2013 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oIx7MF4UZIu3
	folKrOedvpYYyTc=; b=hYsL1sTZhHr4KnP/o6SVR3uCkbzlyCyXxkWhFAyrbfc/
	CVJ6OkXHbGf3+ZPy7xayd1PT5L4BFhcLiZkO0TsFezhz/1bpGstgdRtWKPMce2qo
	IoV0MzpnsvKaIHQeaOlf5WtAxLlw2U8euIFarwSSktnmqXYJQXihbEr/3wGGvyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Bz4ErG
	o5ymOPkNwkJ9hSBQrsuXShEL+9HFO/GkUH6bcVlSBz0MmfiFKq4hogH0RRMcVNSw
	amI0qKIYMPDZZ+y83xUdqJ6VFo+GBNBe7LtKhPFvU+CjMZI3K/7w6YoBaztIE8lR
	N6HXlEodIz+Y4aGbKl1qa9fyL3cIXbV5hmk0g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E5CC1C152;
	Mon, 13 May 2013 13:58:30 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B6761C151;
	Mon, 13 May 2013 13:58:29 +0000 (UTC)
In-Reply-To: <20130513111143.GU2331@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Mon, 13 May 2013 13:11:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 311794DA-BBD5-11E2-9F25-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224144>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Mon, May 13, 2013 at 01:05:51PM +0200, SZEDER G=C3=A1bor wrote:
>> On Mon, May 13, 2013 at 03:43:43PM +0530, Ramkumar Ramachandra wrote=
:
>> > If we can agree that it's just a matter of taste, we should both b=
e
>> > able to have what we want.  Any suggestions on how to make this
>> > configurable?
>>=20
>> The same way we make other things configurable in the prompt: specif=
y
>> the GIT_PS1_HIDESTATESEPARATOR or something similar variable to stri=
p
>> that space from the prompt.
>
> Or perhaps better yet: use a variable, e.g. GIT_PS1_STATESEPARATOR or
> whatever, to specify what should separate the branch name from the
> repo state, defaulting to a space to keep the current behavior.

Why just a single knob for that SP? =20

If you restructure the code to formulate "gitstring" to call a shell
function to do so, people can override it and come up with whatever
format they want to use, no?
