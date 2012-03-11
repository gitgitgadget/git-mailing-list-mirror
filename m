From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Sat, 10 Mar 2012 22:36:15 -0800
Message-ID: <7vsjhfzlsw.fsf@alter.siamese.dyndns.org>
References: <201203052039.16893.tboegi@web.de>
 <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
 <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
 <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
 <7v4nu0m5tb.fsf@alter.siamese.dyndns.org>
 <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com>
 <7vd38okmp0.fsf@alter.siamese.dyndns.org>
 <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org> <4F5BD585.5050007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 07:36:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6cOG-0001RD-B2
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 07:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147Ab2CKGgT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 01:36:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab2CKGgS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2012 01:36:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57C444662;
	Sun, 11 Mar 2012 01:36:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AbyPzVIhaRjU
	Di5+co0NGibgzwo=; b=e9Q5TSKDiIn53nJS9PXKNTR/aAW3mu3/pqhXthmGPo0x
	yKZt9fevxcIsfUe0dc+c8kj1ODHHqUov5qAk/QjRt3mQVg7coGPVM4i5xw5uHrSy
	KoKCjmvDX2nY7Aeo4UufBN7A6a1Zsyb8N17bojRZFN7gaRnTbKliIKhp6ISqGBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=A1v9WR
	1goQVdniBAhldZ3RTz2rsJbvGXlH6MOi3CUoiawiKgI71smTCfUHWdrY/eSqs5ko
	IqyccdV7BNRvg1puNfkaJfNffWd3pjHSDSWannWNwbuo6N9NgZKjqUJmSGSPr0vy
	xQNseoB8RjSRDT5equ/7fT/IFAnbU6yXRJnlA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DE6D465E;
	Sun, 11 Mar 2012 01:36:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C272D465A; Sun, 11 Mar 2012
 01:36:16 -0500 (EST)
In-Reply-To: <4F5BD585.5050007@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Sat, 10 Mar 2012 23:28:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 813DB364-6B44-11E1-854E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192796>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> This is not because Mac OS X does not have the island locale (it has)=
,
> but because GIT_INTERNAL_GETTEXT_SH_SCHEME" =3D fallthrough.

You need to trace and see what happens in git-sh-i18n.sh then, I
would think.
