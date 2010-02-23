From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Create /gitk as a symlink to gitk-git/gitk-wish.
Date: Tue, 23 Feb 2010 13:56:35 -0800
Message-ID: <7vtyt7ehv0.fsf@alter.siamese.dyndns.org>
References: <1266536738-2933-1-git-send-email-apenwarr@gmail.com>
 <32541b131002231047y4dc49f85s56ba91e6bc7bf16c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, paulus@samba.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:56:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2kL-0000eZ-ML
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab0BWV4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 16:56:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab0BWV4o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 16:56:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BAFB69CFB5;
	Tue, 23 Feb 2010 16:56:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=JLVlIG7TdGgQhIzAYJ+j68Okx
	Ks=; b=VrwkcwyqWok6Ml2FVDadztrd4v8IZPeFupRjVMZfYV8jCqwah6a81Bv4l
	hntQWfJ5CKNQ0asvR2lQYUV/raglrt72JrxKmHBuMCvC/ZwFh80l96jX+2DpCRQX
	08uohI3tKYc5yNHWa8gFGEd2cl4Im+yZET3FG9h83fEWd7G8GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=pkzfULM1x7oQDzZQUmV
	iA95QABII6RmmY+kQ0rs9eqoTl6VvvMh0SNJcZphvvzEMB2E7erd6VjFSrL3lGvH
	9cSRHwOPxANSVEdkPoRPw2WeHR3k+XyXZ4fh7ArQ015hwS31bEHDYnWh+ueZ+KKP
	2kU/aYQ9ntUsubwhiFqcfSCo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 854E99CFAF;
	Tue, 23 Feb 2010 16:56:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A1799CFAD; Tue, 23 Feb
 2010 16:56:36 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 528F9B38-20C6-11DF-81C7-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140850>

Avery Pennarun <apenwarr@gmail.com> writes:

> On Thu, Feb 18, 2010 at 6:45 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> In earlier versions of git, you could add the git source dir to your=
 PATH
>> and the 'gitk' command would work. =C2=A0At some point, this stopped=
 working
>> because the file formerly known as gitk is now gitk-git/gitk-wish.
>>
>> Have the Makefile automatically generate a symlink to it when buildi=
ng, to
>> restore the earlier functionality.
>>
>> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
>
> Any comments on this one?

To be honest, I am not terribly interested, as it seems to affect only
people who build from source.  They know what they are doing and are
assumed to be capable of adjusting the environments for testing and
developing git.

Having said that, adding anything missing to bin-wrappers/ would make m=
ore
sense these days, I think.
