From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/5] test-lib: Adjust output to be valid TAP format
Date: Fri, 25 Jun 2010 14:36:07 -0700
Message-ID: <7v6316kd6g.fsf@alter.siamese.dyndns.org>
References: <AANLkTinVp6kivNzbdUj-7EXjKrolBqvtsNROo-dCSydn@mail.gmail.com>
 <1277416332-12072-1-git-send-email-avarab@gmail.com>
 <7v6317koy2.fsf@alter.siamese.dyndns.org>
 <AANLkTilYoGtTIr9lIQD4sx4PRjlWYjIwSDMquREzv6eq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 23:36:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSGZS-0002S7-GO
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 23:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab0FYVgR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 17:36:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43140 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab0FYVgQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 17:36:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 510C5BFE51;
	Fri, 25 Jun 2010 17:36:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BhX7OjrX+j5H
	qV5PdHtOR5y9RKw=; b=aabA22RdceFli5YNO2rIXBuZLhVVwSI0sTkLbUle9qyd
	7DNtZCdN/AQJFATXU4deRf2gPzuR3YofZpwj8mYb45BMNxvKaFOHIBLuVyPimuod
	NHhdzyv+YmVg7oM3Zbvr2Iay20STMI2KohzgTlDlSTLxfDtzDi+u1t9GeoTphPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CWfwfI
	nSggzWq0vYbJN/UN2yt0MbR9SGBSfqzSYWYUN2k1P48WJNpyXRo5Ubh4FHNwcI/f
	JKJmO7BeERR77MWVLRStPkhrBQys8EkRFDrN+Aw8CV7V8dQIZEVdW1kYJcnb3DZg
	1bO8u0qdGY0HGZ0jC1smLE2bZeJ0Q1GD9mx8Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01DABBFE50;
	Fri, 25 Jun 2010 17:36:11 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48D6EBFE4E; Fri, 25 Jun
 2010 17:36:09 -0400 (EDT)
In-Reply-To: <AANLkTilYoGtTIr9lIQD4sx4PRjlWYjIwSDMquREzv6eq@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 25 Jun
 2010 21\:24\:47 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ACB14CA2-80A1-11DF-B8B0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149710>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jun 25, 2010 at 17:21, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> diff --git a/t/README b/t/README
>>> index 0e4e8d8..aa4ed28 100644
>>> --- a/t/README
>>> +++ b/t/README
>>> @@ -18,25 +18,48 @@ The easiest way to run tests is to say "make". =
=C2=A0This runs all
>>> ...
>>
>> This describes the general framework of tests from the point of view=
 of a
>> person who runs them and reads their output well. =C2=A0I'll replace=
 ab/tap
>> topic with these five patches.
>> ...
>> I'd however like to ask you to update the sections in t/README to he=
lp
>> test writers....
>>
>> Earlier I kept wondering if this series is worth the trouble. =C2=A0=
Having to
>> learn and follow the set of these new rules is exactly what I meant =
by
>> "trouble". =C2=A0Let's make sure that the new rules are clear, small=
, and easy
>> to follow for other contributors.
>
> I'll write those docs, but I probably won't have time in the next few
> days so I'll submit a patch for that it separately if that's OK.

Oh, absolutely.  I meant to say that v4/v5 round already has a good
documentation for test users/readers; a follow-up patch to help test
writers would make the series more complete.

Thanks.
