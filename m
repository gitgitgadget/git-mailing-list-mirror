From: Junio C Hamano <gitster@pobox.com>
Subject: Re: contrib/mw-to-git/Git/Mediawiki.pm
Date: Thu, 27 Jun 2013 10:29:56 -0700
Message-ID: <7vzjubsbqj.fsf@alter.siamese.dyndns.org>
References: <51CC6189.6030701@web.de>
	<CAETqRCgctnVqrYaAYn7uZtv0rvQNawUAi513iTeWPufkZPRgAw@mail.gmail.com>
	<vpq4ncjcxt4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Beno=C3=AEt?= Person <benoit.person@ensimag.fr>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 27 19:30:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsG1D-0007xH-Cq
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 19:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab3F0R37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 13:29:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab3F0R37 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jun 2013 13:29:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C53729560;
	Thu, 27 Jun 2013 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jbqoBdmghQKx
	RkU3slhclGYx4k0=; b=Z/fPOF3DUl8htAZ96FgNpS/V+voHqwPxAW78pLEr523a
	h2A4Y521T9FgP7LCk9QesMu+FUxP70DH8ogFYVd70SvuCcz35BZODubBL0Dc3ccj
	k1UcVTF/f3RFgez5YGXJ6LjLVZqwHHITaAC34IAXsYzxrJggKLZN9Om5m54rycA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BJzGrt
	uZUg/ptQjCoB4uLVHSHOaXC9gXq/6WcTZHyYj1fyyT8ag5mPJIbIWqJ8bI1bNphm
	uFEMr9mfC9d5w0m8BD0kBERKpCNGC+yz7hOTaom6Ft8+rK7g2gPVugaZ0xog4zbf
	O3Cq128j6FbHIcTYOdR4c/BEt/Ug2tLrcSmtM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F7612955F;
	Thu, 27 Jun 2013 17:29:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E57C12955C;
	Thu, 27 Jun 2013 17:29:57 +0000 (UTC)
In-Reply-To: <vpq4ncjcxt4.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	27 Jun 2013 18:39:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30410544-DF4F-11E2-9A47-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229126>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Beno=C3=AEt Person <benoit.person@ensimag.fr> writes:
>
>> Junio, Matthieu : should I resend a new version of my serie which
>> renames the 'git' (lowercase) file into something like 'git-dev' ?
>
> I'd call it bin-wrapper/git, so that people can put bin-wrapper/ in
> their $PATH if needed, and by analogy with ../../bin-wrapper. If you =
go
> this way, don't forget to update the $0 relative paths.
>
> git-dev is OK with me too.
>
>> (some comments directly mentionning the 'git' (lowercase) file needs
>> to be updated as well in the Makefile)
>
> Yes.

I just noticed that the script is not strictly a text file, ending
with an incomplete line, by the way.
