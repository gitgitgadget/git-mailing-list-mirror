From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3703, t4208: add test cases for magic pathspec
Date: Mon, 09 May 2011 15:06:35 -0700
Message-ID: <7viptjo7f8.fsf@alter.siamese.dyndns.org>
References: <1304764507-27547-1-git-send-email-pclouds@gmail.com>
 <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <7v7ha1t6o9.fsf@alter.siamese.dyndns.org>
 <BANLkTikONPUVvAEw+fSDva8RUp-YSm-Nxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:07:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYbR-0006eE-DH
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312Ab1EIWGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 18:06:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284Ab1EIWGr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 18:06:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C046447B1;
	Mon,  9 May 2011 18:08:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0m2uAVpANY7I
	U6/KugTlNnOGHeg=; b=SjhTb9A7WAPFfDo6GOXR2HL382xMuPeBBn8i2b4NVy0u
	6sGsRtP2dDI0nPiaeGsJlcgFf4rkTSOrqjJSBxu0Q8XzceRbk3St79MjRKFx7l0q
	ZBxaoD1N2HOJAkTLesanITNv7tugNFAfhoyDzT38Zvqfxl0/XT7II9RbwWjwLxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oGHYs2
	yYu/RSnRB7F7adsyi1TUANxm1EJ9XowJgRQL87d2/POaVLDBY6C8jy8Kp96yT8m6
	B8Kfce+3M9CvdaUsXVh7GVKQeCdHM5dQy+J5sXTdiG+hxAZJT6+5wz4KDQTiUa3B
	Rls4woglYse58M++W/7/jle+8UgD2refonj7o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B52147B0;
	Mon,  9 May 2011 18:08:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3CA0E47AD; Mon,  9 May 2011
 18:08:42 -0400 (EDT)
In-Reply-To: <BANLkTikONPUVvAEw+fSDva8RUp-YSm-Nxw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 9 May 2011 19:33:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA2DC100-7A88-11E0-BD23-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173271>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2011/5/9 Junio C Hamano <gitster@pobox.com>:
>>> +test_expect_failure 'colon alone magic can only used alone' '
>>> + =C2=A0 =C2=A0 test_must_fail git add -n sub/foo : &&
>>> + =C2=A0 =C2=A0 test_must_fail git add -n : sub/foo
>>> +'
>>
>> I don't care too much about this case (it is a user error), but if y=
ou
>> promise you will turn this expect-failure to expect-success in a fol=
low-up
>> patch, why not ;-)?
>
> failed tests are (annoying enough) to be fixed, right? :)

Didn't I say it is not my itch already?
