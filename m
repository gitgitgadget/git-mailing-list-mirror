From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: fix 'git status --help' character quoting
Date: Mon, 20 Oct 2014 10:14:31 -0700
Message-ID: <xmqqy4sa3bpk.fsf@gitster.dls.corp.google.com>
References: <1413728235-1504-1-git-send-email-philipoakley@iee.org>
	<xmqqwq7vr91j.fsf@gitster.dls.corp.google.com>
	<8D139BC1FB1E4335B4375FB0F056BB0B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "GitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 19:14:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgGXX-0001Nx-M1
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 19:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbaJTROg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 13:14:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750962AbaJTROf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 13:14:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ED551601C;
	Mon, 20 Oct 2014 13:14:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qO8pKYu9pUk01uVVfs1iy1zUGPk=; b=oESXyQ
	BdDk4LkoQXtnJZCx4y5wNlF3mjq0I7yRDZde4MGNK4TinilFGuQnY2WuyptyD+9G
	Q1h7gq4UcF2t5aMpU8si4CaI5rnsz/8hSTdunvFoTzr8hMAHpVo74CA9HXl4C/nP
	XTC8FB/wOJYvFZZ3lmlcKa7h1GuGeGJRJO9kI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ic84TEEaeNADezQuVEfodjJWwR3gcHkh
	0kcI+ZTUG/PcLe7JfB1huuK+Hp/zXBQF8FGRomey0oimWzch4Hiq1IBtC9DAznST
	F+ouxVbEl3ygr1JSPQeP/C8iv/zmlO/e1vIRUQcfNhRBrZYgbopf1dzz7Ac+DB0E
	6HF6/NvCYbk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86AE71601B;
	Mon, 20 Oct 2014 13:14:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0354216016;
	Mon, 20 Oct 2014 13:14:32 -0400 (EDT)
In-Reply-To: <8D139BC1FB1E4335B4375FB0F056BB0B@PhilipOakley> (Philip Oakley's
	message of "Mon, 20 Oct 2014 11:46:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F3C0BC8-587C-11E4-8B26-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> Philip Oakley <philipoakley@iee.org> writes:
>>
>>> Correct backtick quoting for some of the modification states to give
>>> consistent web rendering.
>>
>> This is to match the way how "XY PATH1 -> PATH2" is typeset, I
>> presume.  Some in the body text are already `XY` to match, but some
>> others are not,
>> and you are fixing them, all of which look good.
>
> Do you need me to add this to the commit message?

Nah, it already mentions "consistent"; I was just double checking
that I correctly understod consistency with what part of existing
doc is achieved with the patch.

> The reason I proposed the change is because on the web view, on my
> machine, I questioned whether the specially formatted character
> (remember its quotation is consumed by ascidoc) looked too much like
> an Oh, so I specially checked on the original .txt to see if it was
> correct there, which led me to the proposal for '00' in this case.
>
> I'd be just as happy with a single zero, as long as it's distinct from
> O (as you probably know, in the depths of hsitory typewriters didn't
> even have 0 and 1 keys - the O and l were used interchangably and many
> fonts keep too much to that pattern of undifferetiability!)

Yes, and that is why I said

>> there is
>> no risk for anybody to mistake "O" (oh) as part of digits, whether
>> you use decimal or hexadecimal.

;-)

> Note the more recent http://git-scm.com/docs/git-status has the
> formatted round o and

I think it is just the font. I just opened the above page with
Chrome and futzed the text from '0' to '0123456789' to see how it
look.  That round thing is consistent with how other digits are
rendered.

https://plus.google.com/u/0/+JunioCHamano/posts/dzNXV2FwP6K

(sorry for a URL to plus)

> https://www.kernel.org/pub/software/scm/git/docs/git-status.html
> (which IIUC is out of date) has an unformatted 0.
