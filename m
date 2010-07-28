From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/24] Documentation: Move variables from config.txt to 
 separate file
Date: Wed, 28 Jul 2010 10:23:29 -0700
Message-ID: <7vtynj4j1q.fsf@alter.siamese.dyndns.org>
References: <cover.1280169048.git.trast@student.ethz.ch>
 <75c9db91f5ab43ebb60cace0d20389462a2ab02c.1280169048.git.trast@student.ethz.ch> <20100726193841.GB1043@burratino> <AANLkTikANkubcJ2x5lDLKsKSiOAfMC1QaIoaTaEotN_l@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 19:23:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeAM9-0002yk-OO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 19:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab0G1RXn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 13:23:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab0G1RXm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 13:23:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D06FFC8C48;
	Wed, 28 Jul 2010 13:23:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=skwtBlJVR+Dt+6k25Uk1T5+6e
	HI=; b=NnIjsCuxvYr3Sj0beYkmVh4cmB76oTwKYs9NLzo0eRVgTWsR+UuCvsUT8
	SH43dqOC7WOgHEb5ofX0dygPSmHfZGs0J2GKb9B6APi2NcHBQufFvcDZUaVABCKy
	0jvguiu7PMcSku+FpWIt0ufRD1giUttfBcKBFyxPovnQQjG9b0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Vy6kedYegIHKkeF6Occ
	9AF7m7T7JENxtBijlH5PSszzmsg2vJutrIP/dshaRhWBgxc0wzsg37uDksAmhZvy
	oncw++VLDlAIroEdCZPekTJ8sgS/8Xy+AXjrZGn9v8ddYPdVHDuVjxy8ffzp2Irh
	rP79t9DEWrJhG9Hm4FNKPaKY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E99AC8C43;
	Wed, 28 Jul 2010 13:23:36 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80222C8C3C; Wed, 28 Jul
 2010 13:23:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DAE90E2C-9A6C-11DF-8F35-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152108>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Jul 26, 2010 at 19:38, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> Thomas Rast wrote:
>>
>>> =C2=A0Documentation/config-vars.txt | 1691 ++++++++++++++++++++++++=
++++++++++++++++
>>>  Documentation/config.txt      | 1693 +----------------------------=
------------
>>
>> Scary.  Does -B -M -C -C -C make it any better?
>
> It makes it even scarier:
>
>  Documentation/{config.txt =3D> config-vars.txt} |  223 ++--
>  Documentation/config.txt                      | 1923 ++-------------=
----------

Is it scary?

If bulk of config.txt has been moved to config-vars.txt, but either lin=
es
the moved to config-vars.txt have further edits or more lines have been
added to the file, while the remainder of config.txt had some other
changes, the above two is more or less exactly what I would expect to s=
ee.
