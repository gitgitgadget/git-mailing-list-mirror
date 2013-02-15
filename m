From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4+ 3/4] count-objects: report garbage files in pack
 directory too
Date: Fri, 15 Feb 2013 15:20:51 -0800
Message-ID: <7vliapf9kc.fsf@alter.siamese.dyndns.org>
References: <7vehgkb43v.fsf@alter.siamese.dyndns.org>
 <1360930030-21211-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 00:21:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6Uak-0007Id-AE
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 00:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290Ab3BOXUz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2013 18:20:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37375 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256Ab3BOXUy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2013 18:20:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC1C8A485;
	Fri, 15 Feb 2013 18:20:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hQ5FjBZL7oWA
	7NBbBAPxSl+3l0A=; b=rgbv+c6VY6J6WabgUsrDVPlN2RHcqYaN/xE2oHpYH/5n
	YMbGU5AL4wPWx/Gb8ZfYkuYYaGzeKAeP+12IC1qwOzmNXwu0RHZ4Q8nlb3e3vmLI
	uTO7rh8FchU6q4PS9etYRq6KIxCCyuGO33cC//RiBnZPPuZ8W2mIlzNf0UIkaj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KrSgJF
	1C8wLXE1vUbRIRsQJ+vmP3G77iENWG8I/+18ZGC7Zf8YQS2Avv+A1tAWteZpzLlo
	MpNcFlPz1WV75f6D5q2/VkVBihpLgGTNxuSoMEApy5ZohUYdZyWwFe5+n/CpvOzF
	QJ6K9xK53sRZZBCY6DDmXsj801lmLm9GF81UM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0A71A484;
	Fri, 15 Feb 2013 18:20:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33DC6A483; Fri, 15 Feb 2013
 18:20:53 -0500 (EST)
In-Reply-To: <1360930030-21211-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 15 Feb
 2013 19:07:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57A51B34-77C6-11E2-9982-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216365>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> prepare_packed_git_one() is modified to allow count-objects to hook a
> report function to so we don't need to duplicate the pack searching
> logic in count-objects.c. When report_pack_garbage is NULL, the
> overhead is insignificant.
>
> The garbage is reported with warning() instead of error() in packed
> garbage case because it's not an error to have garbage. Loose garbage
> is still reported as errors and will be converted to warnings later.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Will replace the one from the other day and advance the topic to 'next'=
=2E

Thanks.
