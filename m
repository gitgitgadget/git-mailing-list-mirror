From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Verbose as default for commit (optional)
Date: Fri, 24 Apr 2015 21:33:10 -0700
Message-ID: <xmqqr3r825fd.fsf@gitster.dls.corp.google.com>
References: <20150424191809.GA18897@alvaca.santafe.altoros.com.ar>
	<vpqbnidmgzh.fsf@anie.imag.fr> <20150424235103.GA1798@localhost>
	<CAPig+cRegJ9b0NyvkrZvJMw3CAU0TdgyzH1DMDjB_hV2X4ysHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eloy Espinaco <eloyesp@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 06:33:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlrmP-0001KI-KI
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 06:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbbDYEdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 00:33:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751045AbbDYEdN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 00:33:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F79F4CDEB;
	Sat, 25 Apr 2015 00:33:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JfkR2Sk9IWmB29/ZUEnzYbRRLPk=; b=b/ia+Q
	jLY5/Wm+m0qar0TOwAWZH7rG1ueROMEEhdyXimBRWfNj4vPEymlG/pmCbj2EZXOv
	FWOfwPrQmEpfA1aI9FFBz+G5mRFiKjfKfbGxYQkc5dL3mGv5igD2b3ctV8HSecGQ
	9CySqnnDjYQ8k6WmNbyDgpfGjvjdlL1o5zwrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iNLuW1tAZdYfk5mEEbitzRnUI+XfJbDp
	8zmuYiloMNyeImgXFYebzUqHzvOnVLX/F5643O93N+G6ODoBal08+35b+QclhpuU
	U7JQ9falXns1qUxCH+IIfWdNAn/sNCpsvmXw7G7Jr/OZCKcMaa07vPYuv+61gEyB
	zhWvH49y0FE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 787134CDEA;
	Sat, 25 Apr 2015 00:33:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8C9B4CDE9;
	Sat, 25 Apr 2015 00:33:11 -0400 (EDT)
In-Reply-To: <CAPig+cRegJ9b0NyvkrZvJMw3CAU0TdgyzH1DMDjB_hV2X4ysHg@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 24 Apr 2015 21:08:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E735A88-EB04-11E4-92A6-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267770>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Apr 24, 2015 at 7:51 PM, Eloy Espinaco <eloyesp@gmail.com> wrote:
>> Ok, now I found [this
>> thread](http://thread.gmane.org/gmane.comp.version-control.git/251376)
>> that seems abandoned, but implements this config, a --no-verbose that
>> disable it for one-time and the tests, but was not merged (don't know
>> why)
>
> I recall reviewing Caleb's patch series and making a number of
> suggestions for improvement. v6 was the last version he posted[1], and
> it seems that he intended to post v7 but never got around to it.
> Apparently, Torstein Hegge asked in February 2015 about picking up
> where Caleb left off, but nothing has materialized.
>
> You are welcome to revive the series by taking reviewer comments into
> account and submitting v7 (and beyond if necessary). Be sure to keep
> Caleb's authorship and sign-off intact, and add your own sign-off
> following his. If you make changes to his patches, briefly describe
> your changes in a bracketed comment in the commit message, starting
> with your initials, like this: [ee: changed blah to bleh].
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/251943/focus=264608

Also, the world order has changed recently, if I am not mistaken.
Back when Caleb's series was done, there were only two choices
(i.e. are we verbose, or not verbose?)  Now "commit" and "status"
can take three choices, so commit.verbose boolean would not cut it.

Should the configuration variable be commit.verbose and only affect
"commit" and not "status", or should both of these commands pay
attention to the single variable and behave the same way?

I offhand do not have a strong opinion on these questions, but
whoever is doing a proposal must think about it and justify the
decision.

Thanks.
