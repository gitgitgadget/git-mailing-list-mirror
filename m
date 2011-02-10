From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Thu, 10 Feb 2011 14:01:27 -0800
Message-ID: <7vhbcb35xk.fsf@alter.siamese.dyndns.org>
References: <4D0ED5EC.9020402@burntmail.com>
 <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com>
 <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com>
 <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
 <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino>
 <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com>
 <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guy Rouillier <guyr@burntmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Martin Langhoff <martin@laptop.org>
X-From: git-owner@vger.kernel.org Thu Feb 10 23:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PneaJ-0004eB-BU
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 23:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055Ab1BJWBu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Feb 2011 17:01:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827Ab1BJWBt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Feb 2011 17:01:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13A014BE0;
	Thu, 10 Feb 2011 17:02:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8Fq1Re3XobgP
	f+Izlo0nbzzS0o0=; b=uCarwFnMSd5THOfEekaGQs21Gkn7f/mZwwJHbfukwOGf
	jpBRMqNLpwMSwAoe+DpbwiUv6jlU0lZLultkrLy51z+qoKkBIoH4ojslI4J1iZDV
	gz3Rm7xSN9bx86EfscrHJsSZb2tIP9v+AtyD0tl360Yr7OAbHdKBVtEbl+jKVF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eifQ5y
	KG24WU0jWyARvHge2DEjCzUll5HYgGKjo9qLZOR99Jaawnldgm2hg6V8XjltVy+l
	I04vVw7PTT5U7kxb7bQUW5iFB6hY4u8bG+eOpknbpzPGRGwsv7C8zgtz0kA5ZO9L
	EN36u1k1EOPfcTnHVTwkqbUymOf8iTUPvNLAw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 96FF94BDD;
	Thu, 10 Feb 2011 17:02:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 921424BD9; Thu, 10 Feb 2011
 17:02:29 -0500 (EST)
In-Reply-To: <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com>
 (Martin Langhoff's message of "Sun\, 30 Jan 2011 13\:19\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7963B806-3561-11E0-8ACA-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166503>

Martin Langhoff <martin@laptop.org> writes:

> On Sat, Jan 29, 2011 at 11:33 PM, Guy Rouillier <guyr@burntmail.com> =
wrote:
>> That was my original inclination. =C2=A0As no other opinions have be=
en posted
>> since your message, here is my amended patch, incorporating Martin's
>> ideas and dieing if the script finds both CVS and CVSNT password fil=
es.
>
> ACK! Thanks!

Can somebody resubmit an appliable patch with a proper commit message t=
hat
describes the problem and the solution please.

Thanks.
