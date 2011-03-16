From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2-3/3] Name make_*_path functions more accurately
Date: Wed, 16 Mar 2011 13:48:19 -0700
Message-ID: <7vei667pws.fsf@alter.siamese.dyndns.org>
References: <1300294266-26875-1-git-send-email-cmn@elego.de>
 <4D80EC57.4050704@drmicha.warpmail.net> <1300299469.3995.10.camel@centaur>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:48:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzxe5-0005ce-GX
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab1CPUsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 16:48:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1CPUsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 16:48:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 249064CAF;
	Wed, 16 Mar 2011 16:50:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fcULMwmR+8YF
	qtARIK63ysC8ptE=; b=RCuEkU8dh5I2qjA9z0C/L9gMcJtL1Wi2Q6o1maTCSjVU
	LI+i6ceQcYDEqsZ/Vtk0CNd4rZuOyqtqBUmNYyPPVSLD41HYoR5U/XU4G/yjLUFN
	USXy0ii2opKkuhk8Tu/Ob25P1P83y5ASmQROw+h0fMLTbBmzrmRB32brSap9I0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kks9Ds
	iMLxGS+KrQqXEDAaVgmoVb3FheMAk1AHgGbkxn7MBGtLA9B54v6JuxWXhSuB132n
	k9uj9K6UN3TTOsEOx8GjtFXaU3r+oYq4JepgtoCRbd/11aMRqqgF8l3CW6I4a5vX
	YBq4pOqSUjTs+QdNTcdg42MlLoU8PlnkYKAIA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB0934CA7;
	Wed, 16 Mar 2011 16:50:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 08D1D4CA4; Wed, 16 Mar 2011
 16:49:54 -0400 (EDT)
In-Reply-To: <1300299469.3995.10.camel@centaur> ("Carlos =?utf-8?Q?Mart?=
 =?utf-8?Q?=C3=ADn?= Nieto"'s message of "Wed, 16 Mar 2011 19:17:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6835EBE-500E-11E0-9984-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169192>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Wed, 2011-03-16 at 17:59 +0100, Michael J Gruber wrote:
>> Why remove the check? Again, this is not just renaming.
>
>  Semantics change. Same as above. The one below (snipped) is the same=
=2E
>>>[...]
>> I think you should strictly separate the renaming issue from other
>> patches (and describe/motivate the latter). It's fine to have a larg=
e
>> patch with mechanical changes (renaming) if you stick to just those.
>
>  Unfortunately I introduced some modifications trying to reduce the
> number of times we call make_absolute_path/real_path and they snuck i=
n.

Michael, thanks for helping with good eyes.
