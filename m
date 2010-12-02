From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problems using perl's Git.pm module
Date: Thu, 02 Dec 2010 10:18:59 -0800
Message-ID: <7v4oawrqb0.fsf@alter.siamese.dyndns.org>
References: <20101202114003.GA26070@raven.wolf.lan>
 <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
 <7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
 <AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 19:19:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODkU-0004fa-1n
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 19:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178Ab0LBSTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 13:19:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab0LBSTM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 13:19:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 003013F33;
	Thu,  2 Dec 2010 13:19:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OFRN3T4Ipnmw
	O8tq56GXGeO0scI=; b=b9gTjwmHwvqbfmq+g0ScY7agksE/k4o6qaXcPp7jYhiA
	qDVRGPcGANU9UtmWu1vduqyiseiRL97aSqj3pcwt4H0ELrqk1XOaSqsSSbJZKRM3
	ngSi078IHc7pdARxdcoxMq1sVP5WS3UOEBLn1wGNj7RO2ClWzMY1Wpo5UzhHG5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Qi3chY
	uqUc1WbhGbrZz8Vtya1F2+4BjAiGlVdj7VD/EAj5469laa54w9mL9D2hGoZzS5gA
	K8pj0ZWT4H50C4uKfEglAQdDquYFtjWOpNR8JpCqfDnYyvbdH7vJ8UDK2KP7DSjx
	39IphOpDgUcBV8J3o64mdVQ2xRzixvvR7a3lg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A0B603F32;
	Thu,  2 Dec 2010 13:19:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 148063F2A; Thu,  2 Dec 2010
 13:19:21 -0500 (EST)
In-Reply-To: <AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
 (demerphq@gmail.com's message of "Thu\, 2 Dec 2010 19\:10\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2D5CE1A-FE40-11DF-9D7B-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162725>

demerphq <demerphq@gmail.com> writes:

> On 2 December 2010 18:46, Junio C Hamano <gitster@pobox.com> wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Thu, Dec 2, 2010 at 12:40, Josef Wolf <jw@raven.inka.de> wrote:
>>>> I am trying to use perl's Git.pm module, but for some reason, it k=
eeps
>>>> bailing out:
>>>
>>> Why are you using it? It's for internal use only.
>>
>> That is not a valid question nor answer, I am afraid.
>
> So you are saying that it is for more than internal use?

No.

Imagine you were adding a new function to git-svn.perl and wanted to kn=
ow
why your addition that looked somewhat similar to what Josef sent did n=
ot
work as you expected.

We should be able to answer such a question, don't you think?  People
often seem to badmouth this list as git develper's list that is unfrien=
dly
to end users.  I don't think that is true, but even if that were true (=
or
especially if that were true), shouldn't we be try to be friendly at le=
ast
to a potential developer who tries to learn and use Git.pm module?
