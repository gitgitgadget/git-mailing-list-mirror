From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Thu, 31 Mar 2011 15:42:27 -0700
Message-ID: <7voc4qhpyk.fsf@alter.siamese.dyndns.org>
References: <1301582187-20340-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:42:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5QZf-00027l-Te
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 00:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759388Ab1CaWmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 18:42:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab1CaWmi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 18:42:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A0CB55B0;
	Thu, 31 Mar 2011 18:44:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=GG4OSXoi5+KKhUHx0pVGy66dd
	HY=; b=hHgSUTxb+qx2+1eutxMjKtFRmUOGU3/WFjBe7ZwQjDuLM30Eu/X/oO2Xc
	r7F/Sq8eye9cep4/30WZeXWMqOCr/+HVTQdfW7YRibGVr7shWrTT8iV4+t47eKEV
	266yV9KngzQSyo1VD0cljp7cdY+uCHJ0HTJCe9nYi5GsSpXu4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=xnX2RVDB3T78LFjF7Gy
	OcfabDRXC7U/EjdyxbtQLfh7xrHqO8/imUXmJ6yJ/O8glfmaUPV5rSfHaxo24jrT
	NxR1WOrh0XzkT/N0+9d6V5K91Awpzt29d0y/XH9TNPD8+CuZwKcyPlQz65B2upRJ
	QlnQ5b5hkLGrFih+VU8mfIM8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECFDC55AF;
	Thu, 31 Mar 2011 18:44:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1CBEF55A8; Thu, 31 Mar 2011
 18:44:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C512998-5BE8-11E0-B862-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170539>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

>  Slightly changed version of the patch in pu with the error strings
> changed. Junio, do you want this patch at all. I think in your "what'=
s
> cooking" messages, you said you don't like this type of band-aid? As
> it's not that big a deal, I'll drop it if you don't want it.

The "band-aid" refers to the topic listed after your topic, I think.  I
didn't even have a comment on your topic in the message.

We'll be in pre-release freeze for 1.7.5 soon, and I want to see patche=
s
that deal with internal clean-up held for now and resubmit after 1.7.5 =
is
released.  This cycle lasted a bit too long but hopefully we can conclu=
de
it by the mid April.

Thanks.
