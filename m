From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push.txt: document the behavior of --repo
Date: Wed, 28 Jan 2015 12:12:49 -0800
Message-ID: <xmqqfvauhdfi.fsf@gitster.dls.corp.google.com>
References: <xmqqppa1mrku.fsf@gitster.dls.corp.google.com>
	<d8bed5c1736a4a291208227b0f54c1039d67f5cc.1422361902.git.git@drmicha.warpmail.net>
	<CAPig+cQCf+vKbZ5ydFSNmGCUvmCkQW-DEPhO1JAAap1VorhXsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>, Prem <prem.muthedath@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:13:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGYyw-0002I9-Hz
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbbA1UM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 15:12:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753605AbbA1UMx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:12:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B11133577;
	Wed, 28 Jan 2015 15:12:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z5H30yrSpmVD/fgM7XpaTLgrPhM=; b=MhCLfe
	BAVD5jt4HuOBO676/Lm1M1QeY2yfkx5VPHU0K5VYVewb3vumqQdibniK0XrIyTnL
	AZPr5vm45RNvI3mfdMf8NKKk0B/Rp0GYDQAtsAJXBM48BHnl8jl8In5Rq++tuIlg
	jUnE9QnYrjsj3X1TMTn+hRluK6yXJVlVhpneM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bKPscu5I/jF171L2INS4GGdj20XvEW3Y
	ewVInuAkiqJwvdOc6oFUKVa+U2OYLe5A6/sda47HIx8QCLSnhCvRU3IeHyTDc4XN
	xHo9CAt6RDaCvwDYi8Gg3ZjBUDoKRaiM525HxLkaHaL4x9IAPxFh0L6rGF+XP6Vq
	SQGEO5jbMVs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 326F933576;
	Wed, 28 Jan 2015 15:12:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96B0733575;
	Wed, 28 Jan 2015 15:12:51 -0500 (EST)
In-Reply-To: <CAPig+cQCf+vKbZ5ydFSNmGCUvmCkQW-DEPhO1JAAap1VorhXsA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 27 Jan 2015 17:07:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0968E3A2-A72A-11E4-903E-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263104>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       This option is equivalent to the <repository> argument; the latter
>> +       wins if both are specified.
>
> To what does "latter" refer in this case? (I presume it means the
> standalone <repository> argument, though the text feels ambiguous.)
>
> Also, both the standalone argument and the right-hand-side of --repo=
> are spelled "<repository>", so there may be potential for confusion
> when talking about <repository> (despite the subsequent "argument").
> Perhaps qualifying it as "_standalone_ <repository> argument" might
> help.

I didn't find that "latter" too hard to understand (I admit that my
reading stuttered there, though).

I do not think saying "standalone <repository> argument" there would
help very much, because there is no mention of "standalone" around
there.  The earlier part of the sentence mentions "option" and
"argument", so "the repository specified as an argument is used if
both this option and an argument are given" or something?
