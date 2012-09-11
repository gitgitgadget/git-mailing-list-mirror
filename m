From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git an case-insensitive Mac OS X filesystem
Date: Tue, 11 Sep 2012 08:44:13 -0700
Message-ID: <7va9wwk1iq.fsf@alter.siamese.dyndns.org>
References: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com>
 <1347355466-ner-6656@calvin>
 <CAPLaKK4Xm8KzQ8HcM_TbbuDr1hcLjhjSOWSyJS3jFX0toFBjsA@mail.gmail.com>
 <CAPabhsKrnFq3z6wTcZny+Jh1PF-7arx_r8WyNRHmgQUu=U4sig@mail.gmail.com>
 <CAPLaKK6R=BNjgY8wc8nZzyPy53ppeO4bKN=Cum_+b6Kwb5F=SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@entel.upc.edu>
X-From: git-owner@vger.kernel.org Tue Sep 11 17:44:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBSdU-0003oJ-Vd
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 17:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750Ab2IKPoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Sep 2012 11:44:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756086Ab2IKPoP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 11:44:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A8456465;
	Tue, 11 Sep 2012 11:44:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Q+M3eJVjZDMO
	D2nl1BFAOZk4Jjs=; b=d7vBR1HRTqTSQiKTrvPwfNytY2rrWYNZq1udB0Bi7NHI
	Y9a7ZWP8ZOL149QCj8Zw53edFNX+9JeOL0S7htC7YLTNdXHA7kRrM4/5Sem1zuMa
	Z3ho824Fy1FArn3T3DR+qI478ylGoqIE2u896KkeCJf1lsYaXT44L5iH9g/3yWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=E/7K1d
	b89ybGS0tDoTlhnAQYBKbjkQlaw7ZN1ZWomi07eS+VI27zLaZ9JV/LQ4fTdixwld
	05GMEgODRoUIQZPm6Zmf37MWUeIP8OHsv2W1X0B8iEf5ZvHS3aUoP0xRyY9TgWTd
	HigwduxGozy5lruiVVpb8qtXDMC566tSCIBTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7828B6464;
	Tue, 11 Sep 2012 11:44:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC70D6463; Tue, 11 Sep 2012
 11:44:14 -0400 (EDT)
In-Reply-To: <CAPLaKK6R=BNjgY8wc8nZzyPy53ppeO4bKN=Cum_+b6Kwb5F=SA@mail.gmail.com> ("Roger
 Pau =?utf-8?Q?Monn=C3=A9=22's?= message of "Tue, 11 Sep 2012 10:44:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A29F554-FC27-11E1-8AE9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205239>

Roger Pau Monn=C3=A9 <roger.pau@entel.upc.edu> writes:

> I understood this, it's just that I would prefer to avoid doing this
> kind if things, I would prefer to be able to work natively on my
> filesystem, but it seems like there's no other option.

If you are unwilling to keep both lowercase and uppercase separately
on your end, and if the other side (the project you are interacting
with) wants you to have both, then I do not think there is any way
to resolve such conflict between you and your project.
