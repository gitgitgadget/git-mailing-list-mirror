From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/21] i18n: sequencer: mark entire sentences for translation
Date: Sun, 22 May 2016 17:44:15 -0700
Message-ID: <xmqqk2ilbo2o.fsf@gitster.mtv.corp.google.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-6-git-send-email-vascomalmeida@sapo.pt>
	<CAPig+cQzsxMMv1XSdStFDs08C3qvb_Ttb4oVeN3T1si85v=f7w@mail.gmail.com>
	<573CD84F.7000207@sapo.pt>
	<CACBZZX790=CtGnryUNrc7S1rpV7D75MOnWnXqd=Smdkojx=ymw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 02:44:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4dyv-0007eo-Pn
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 02:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbcEWAoT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 20:44:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752720AbcEWAoT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2016 20:44:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5750D1CC17;
	Sun, 22 May 2016 20:44:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=02SC0wW7nfcF
	W08oEjkYm0C1eUw=; b=VAmFsG+lqd2D5hU7zmjSi1wI7lSZ0rpmcJxlEbtjE2KW
	BfwM7pBI6n3cgD8EJJP2Y5bO5ZrZEQhdr5hnT/Uxvs8J6uWtPGJUDa89OJ5Go0k7
	Q+FW0ubKp61Isg/3Eu14S3zwmE4P6pInVm+c19jbDOUCWzSW4fBAD2OCx5sZL7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R8UdgC
	YveiwjUsTaepkUTrvqwQg/YrjmXM9s0bifYNezsFk5AEJlPOoPPHlaKiEWl+OuEt
	f7myJh3IsSzfrFdqjs4qItovBk8zR///SN5U7uRoygrrRtfPKC8EagzFfEcjAKsy
	YDGW/I+lslgz2ug6gAkxen87oEfBilllNDZa8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E6C71CC16;
	Sun, 22 May 2016 20:44:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEF5E1CC15;
	Sun, 22 May 2016 20:44:16 -0400 (EDT)
In-Reply-To: <CACBZZX790=CtGnryUNrc7S1rpV7D75MOnWnXqd=Smdkojx=ymw@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 21 May
 2016 15:15:08
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A71B3E2-207F-11E6-AE4B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295294>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> For what it's worth I agree with you and disagree with Eric here and
> Junio in the "[PATCH 03/21] i18n: advice: internationalize message fo=
r
> conflicts" thread.
>
> Of course there's a trade-off in source code verbosity when you have
> to change every occurance of (pseudocode):
>
>     "our %s failed" # %s can be revert or merge
>
> to:
>
>     if (action =3D=3D "merge")
>         gettext("our merge failed")
>     elsif (action =3D=3D "revert")
>         gettext("our revert failed")
>
> But forcing the translator to turn every such occurrence that flows
> naturally in English into "the '%s' command failed" leads to a worse
> translation.
>
> For example, if I ever get around to doing the Icelandic translation
> which I've had on my backlog I might translate something like this:
> ...
> I.e. even though you might be running "git merge" or "git revert" the
> UI is talking about those terms in the translated using native terms
> for the action of merging or reverting, but referring to the literal
> command names in English.
> ...
> It just doesn't flow as well, and leads to a more verbose translation=
=2E

OK.  I couldn't judge your example in Icelandic, but I have enough
trust in you to believe your conclusion ;-).

> Now instead of referring to the translated verb I'd already
> established I have to just refer to literal command names.
>
> Both this change and the change you submitted in
> <1463585274-9027-4-git-send-email-vascomalmeida@sapo.pt> and Junio
> didn't like in <xmqqd1ojqciz.fsf@gitster.mtv.corp.google.com> are
> actual examples of cases where if I was (finally getting of my ass to=
)
> doing the Icelandic translation I'd take advantage of this.
