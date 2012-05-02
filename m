From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull git-po master branch
Date: Wed, 02 May 2012 09:40:58 -0700
Message-ID: <7vtxzyilid.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHtKKWw9LPnr+1khC5Oms-kOtA2WEucoNoE3Njzqiahzw@mail.gmail.com>
 <87d36n2f2r.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Git List <git@vger.kernel.org>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 02 18:41:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPccP-0003vT-IB
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 18:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab2EBQlB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 12:41:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49631 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab2EBQlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 12:41:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BE5F67B4;
	Wed,  2 May 2012 12:41:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+UWTfk6kQfHx
	t3vu3ueDCxFRZko=; b=xXemq8X/625jC1+1NAryP9wSHjlxnLaxrr6pCMnREbSX
	7haUxl7T3UiHNTRI09ukbFrCUYIWG7e/jUEpyt/nkMAxVDtwFDlOo/eicfcw1K/O
	0pz8KVVurmNuA3AwEgsOujMKAymRziBU1N6VXgqwHbw34HO/kCr+MHF/1mTSthQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jhs11z
	nBrM7rMkkOioNQ9ZpSrAWJo+CpNVxAH0PXLpZ0ayXm52t8SWiUmBtYS1vvcepE/m
	0CTvamoWorxtAuGlFpgibew5MyTlGds6I/i/+a1F8R6rCEQTTzfKIhDoy16hUxfk
	JOPUw4FcN+I5ffoai7ILh7KfApiNt9owIcuT8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 627C567B3;
	Wed,  2 May 2012 12:41:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB20267B2; Wed,  2 May 2012
 12:40:59 -0400 (EDT)
In-Reply-To: <87d36n2f2r.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 2 May 2012 09:54:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 990EB498-9475-11E1-AF6E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196839>

Thomas Rast <trast@student.ethz.ch> writes:

> Hi Xin (is that how you are properly addressed?)
> Hi Ralf
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>> Ralf Thielow (3):
>>       l10n: Add the German translation team and initialize de.po
>>       l10n: Initial German translation
>>       l10n: Update German translation
>
> Junio C Hamano <gitster@pobox.com> writes:
>> Both branches pulled; I found it somewhat iffy to *add* new language=
 support
>> on the maintenance track, but decided to let it pass this time.
>>=20
>> A new lang.po file is very unlikely to introduce regression to anybo=
dy
>> else, so it probably is OK.
>
> Objection.
>
> Jan "jast" Kr=C3=BCger and me had most of the following "in the works=
", and
> couldn't get it shaped up before the pull request went out.  Any
> translation mistakes are mine, we drafted it in German.
> ...
> To put it bluntly, we have significant concerns with your translation=
 so
> far.  That's usually not a problem in OSS -- release early and releas=
e
> and release often -- but the maint release would require you to get i=
t
> Right(tm) the first time.

While I can understand your frustration and trust you enough to believe
the issue you are raising for the *.po contents that were merged are ve=
ry
real, it is too late for this round. What happened has happened already=
=2E

Sorry about that.

But I have to be able to trust that such differences are resolved betwe=
en
the i18n coordinator and the l10n teams before a pull request comes to =
me.
That's the only way we can scale the process.

> Of course now that it has been released, we'll also have to file patc=
hes
> in the true open source spirit.  Sigh.

There is nothing to "Sigh" about.  Mistakes happen, and we learn from i=
t.

Thanks.
