From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9501: Do not use export X=Y
Date: Fri, 26 Apr 2013 09:46:09 -0700
Message-ID: <7v38udz1da.fsf@alter.siamese.dyndns.org>
References: <201304252049.00811.tboegi@web.de>
	<7va9om2v9z.fsf@alter.siamese.dyndns.org> <517A4723.7050309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 26 18:46:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVlmr-0002kv-RL
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 18:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881Ab3DZQqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 12:46:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42540 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092Ab3DZQqM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 12:46:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E63161A750;
	Fri, 26 Apr 2013 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=n+tTTp02aJEB
	9m9R/60fHOvJyyc=; b=me6EGtCd1agP5dzcQnrKsXsoWpG1H0wx+rLK+Pd23nPK
	qke4WR+tCiJqKuJdq/b5VLtCrk1tE41xfSeTUYEnGTP7ZFRhJ913Itf7VzVX5081
	0X682BlHgbr33bYgbDq7JkPFRjkaY+GAZJol70xqJZ34wrHbk1LCzn1wwP2NDNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NkTYrM
	mbBxxgcjsADVNw1iAdb0cxLdSEB6YXoyheazkd07sdEFJfUPG1p4sQkuJY9YUr9h
	oEFFCx5rosLDypYGtEGWnQIjISEyW4Q5wU4g1SLD8XdtJoGvaZhFEGiymcK+i8kp
	r0wNnI6QM61mqshjEX+B5lYKbjIINLyaBvbgc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD75B1A74F;
	Fri, 26 Apr 2013 16:46:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F41B1A74C;
	Fri, 26 Apr 2013 16:46:11 +0000 (UTC)
In-Reply-To: <517A4723.7050309@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 26 Apr 2013 11:21:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD189CB4-AE90-11E2-B328-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222539>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2013-04-25 22.46, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>=20
>>> Spilt lines like export X=3DY into 2 lines:
>>> X=3DY
>>> export X
>>=20
>> That can be read from the patch text.
>>=20
>> If you are going to spend three lines, please describe why it has to
>> be split; that would help educate developers new to the codebase.
>>=20
> So true,
> writing good commit messages is not easy.
> and this was a good example for a bad example
>
> Side questions:
> Which shells of which OS/distribution do not understand export X=3DY?

I have not met one for quite some time myself. cf.

http://thread.gmane.org/gmane.comp.version-control.git/35543/focus=3D35=
551
