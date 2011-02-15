From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] Introduce CHERRY_HEAD
Date: Tue, 15 Feb 2011 15:10:46 -0800
Message-ID: <7vzkpwlwqx.fsf@alter.siamese.dyndns.org>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-2-git-send-email-jaysoffian@gmail.com>
 <20110215221832.GA826@elie> <7v4o84nbuh.fsf@alter.siamese.dyndns.org>
 <AANLkTimZUhxkxuUMubmPxjd8MG0Pu=9mrLoPqi=MpPWZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 00:11:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpU35-00018d-2A
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab1BOXLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 18:11:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab1BOXLE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 18:11:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74A794FC1;
	Tue, 15 Feb 2011 18:12:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mAj+Vd7si0f3
	sWtphsIgtaGmORQ=; b=MG8DXZ2/6AKJl2TWzLBYDGAM7J+y1v2NwSsuG8HyVAYN
	Ywn8gx0NOtPKVLkn9/0XwfLgYhQhAOK8Gb/YvnliEer65tJ19DD1KHWrAOUe6yF7
	xz5yupWYxyOZ+hiAiQbZJKjHZE9C5LRT8Xcxv9fjujcniHG6wKnXdEP37EzAbxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KUYNYV
	R1ud0c9qCCYiV3K8NJXxNg7y1yaK2obS0rrap0O/vJ2/2mOInbWzbDGbbrCiS/g6
	LEhBbyoT2AbN5szcAy0wRVNkK48SslODdXCSxAOQwJ86moafS4XMZQUteZnlTJsa
	t+bKUAMsy0Wcm8lQCgNvfwIzN1i/j9ICGQy/4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 244094FBC;
	Tue, 15 Feb 2011 18:12:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 660C94FBB; Tue, 15 Feb 2011
 18:11:54 -0500 (EST)
In-Reply-To: <AANLkTimZUhxkxuUMubmPxjd8MG0Pu=9mrLoPqi=MpPWZ@mail.gmail.com>
 (Bert Wesarg's message of "Wed\, 16 Feb 2011 00\:02\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF1CD432-3958-11E0-8677-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166897>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>> What happened to the `=3D=3D=3D=3D=3D=3D=3D`? =C2=A0I thought you we=
re copying and pasting
>> from the said section.
>
> I think this is clear enough, else you would need to mention the
> '|||||||' and conflict_marker_size too.

If so then probably the section this was copied from needs updating?
