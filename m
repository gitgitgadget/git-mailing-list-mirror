From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix typo 'In such these cases'
Date: Mon, 02 May 2016 12:36:44 -0700
Message-ID: <xmqqlh3ss14j.fsf@gitster.mtv.corp.google.com>
References: <572703EC.20405@renenyffenegger.ch>
	<xmqqa8k8ti0q.fsf@gitster.mtv.corp.google.com>
	<5727AA7F.70504@renenyffenegger.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Nyffenegger <mail@renenyffenegger.ch>
X-From: git-owner@vger.kernel.org Mon May 02 21:36:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJeH-0002iy-1C
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 21:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbcEBTgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 15:36:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754654AbcEBTgs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 15:36:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D5DA15FCE;
	Mon,  2 May 2016 15:36:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HibbmweNQhev
	VWwE/FOkAH6cpKA=; b=qb8SLeH5pAobiFVC3YaEEf3jq8X2bQlPPmB6V6cY0oCV
	qGIPnnkraA5Y6rPBEKQ2Ds2o4qUslxZBoTPWmfnN0dJ3SwcaITgCE1lk+C4fzjLm
	vEJ5fDfeYwgf6PUkfyWhpaLUR9HO7XRQHQuYaJ1P9BDoIHG4DZaPEzg0vOBwVk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gZvJDn
	gA0W6D+rSTvWR3aOUcaR7tYWQ2nyVuW3MpXudf3zoyXzSuTxeKT1fg8qxM9a9sI5
	YDSHZWZrUmcslHk0w5+SjfMp1SLRUlL20wu95iDyTAAH3Dp7B5gi3fpKj48mKAKO
	A3CqypsarbkYVIT+IvDz1Jp/KkIRXuTIfKYCE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0485115FCD;
	Mon,  2 May 2016 15:36:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B86915FCA;
	Mon,  2 May 2016 15:36:46 -0400 (EDT)
In-Reply-To: <5727AA7F.70504@renenyffenegger.ch> (=?utf-8?Q?=22Ren=C3=A9?=
 Nyffenegger"'s message
	of "Mon, 2 May 2016 21:29:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34D8B110-109D-11E6-8E20-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293276>

Ren=C3=A9 Nyffenegger <mail@renenyffenegger.ch> writes:

>> Ren=C3=A9 Nyffenegger <mail@renenyffenegger.ch> writes:
>>=20
>>> From 5e2b47833c8d434784fa1a797cfd6a087df10dc8 Mon Sep 17 00:00:00 2=
001
>>> From: =3D?UTF-8?q?Ren=3DC3=3DA9=3D20Nyffenegger?=3D <rene.nyffenegg=
er@adp-gmbh.ch>
>>> Date: Mon, 2 May 2016 09:19:46 +0200
>>> Subject: [PATCH] Documentation: Fix typo 'In such these cases'
>>=20
>> For the next time, remember that these four lines are usually not
>> meant to go to the body of the e-mail.
>
> Thanks for the reminder. This kernel and git patch-process is fairly =
new
> to me. I will try to do better the next time.

Re substance, I am wondering if "In such a case" might be better, by
the way.  That is:

 	A fast-forward is a special type of <<def_merge,merge>> where you hav=
e a
 	<<def_revision,revision>> and you are "merging" another
 	<<def_branch,branch>>'s changes that happen to be a descendant of wha=
t
-	you have. In such these cases, you do not make a new <<def_merge,merg=
e>>
+	you have. In such a case, you do not make a new <<def_merge,merge>>
 	<<def_commit,commit>> but instead just update to his
 	revision. This will happen frequently on a

It is not like there are multiple variants of "fast-forward"
situations, in all of which the HEAD pointer is just moved without
creating a new commit.  There is only one variant of "fast-forward".
