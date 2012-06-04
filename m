From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] i18n: Add extra -- to seperate gettext and message
Date: Mon, 04 Jun 2012 09:59:43 -0700
Message-ID: <7vpq9ft3ls.fsf@alter.siamese.dyndns.org>
References: <1338764967-30103-1-git-send-email-worldhello.net@gmail.com>
 <1338764967-30103-2-git-send-email-worldhello.net@gmail.com>
 <CACBZZX5EGvJm0aqG5iVn7wnoqFATUqP4gbS-2tnAiLqeFQZifg@mail.gmail.com>
 <CANYiYbFx=Z7TTYUbAhzgHFYB6O_grROWoWHbtuhuABeXdFk4-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:59:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbadD-00033V-21
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 18:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab2FDQ7q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 12:59:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302Ab2FDQ7p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 12:59:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F69589A4;
	Mon,  4 Jun 2012 12:59:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=A9xzNKmOZ2og
	c0cpHTmRbOqqp6k=; b=ga8T5RsG9nXRvrZcngwBRY5JZZ5heb5NWzo0xJWvWQxF
	x5bhiekQEypYMJG3mLwH/mVlophd+SSXPKv3YkfkJs/bR9JIb8V9zrRAlPHqPF2X
	6J3gPUMlkYJ/X4//tvwMkEXIqRs04LrEUWIP+9M6uBjQoG8qy/Clr48PpbnyIFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=V1NEm+
	1K9MKYdpJG7ZGFVzye6RWUjqLbyQX7B8EVw2Y8lF0ExV1ZypnO9OKYqaCerLDNYM
	b5tJvtMkORdp7h0QnIfQoHDAes2ewwAiKP+T1/s0vZRqRshOWEbPKXzJCAlTkMD/
	NGwxXnodf0sif6bvKHiforB5hQ/8KXbziimKQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25BAB89A3;
	Mon,  4 Jun 2012 12:59:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6F2989A2; Mon,  4 Jun 2012
 12:59:44 -0400 (EDT)
In-Reply-To: <CANYiYbFx=Z7TTYUbAhzgHFYB6O_grROWoWHbtuhuABeXdFk4-Q@mail.gmail.com> (Jiang
 Xin's message of "Mon, 4 Jun 2012 21:55:11 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF34F70E-AE66-11E1-95E0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199149>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2012/6/4 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
>> I think a better solution to this is to just apply this patch:
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "$(gettext --=
 "--cached cannot be used with --files")"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "$(gettext "t=
he --cached option is incompatible
>> with the --files option")"
>
> The rewrite message is a bit odd for there are 40 more alike
> messages (extracted from C files) start with "--=E2=80=9D, such as:
>
>     msgid "--delete only accepts plain target ref names"
>     msgid "--all and --tags are incompatible"
>     msgid "--all can't be combined with refspecs"
>     msgid "--mirror and --tags are incompatible"
>     msgid "--mirror can't be combined with refspecs"
>
>> I think changing the only message suffering from this
>> issue (or likely to suffer from it) beats a solution where starting =
a
>> message with -- only works for some of the xgettext
>> commands/functions.
>
> If I had not changed like this, I would not find out there are 27
> marked messages (by gettext wrappers) have not been
> extracted to "po/git.pot". ;-)

I think there is value for having a generic solution than declaring
"No message shall begin with a dash".

I am not convinced that it is ideal for the implementation of
gettext_ln to prepend "--" in front when it calls gettext, though.
Shouldn't the caller of gettext_ln be the one who is responsible for
doing that?  After all, that is the one that knows that the MSGID
argument needs the quoting.
