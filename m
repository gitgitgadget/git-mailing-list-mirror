From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bisect code 125 - "WFT?"
Date: Thu, 17 Mar 2011 10:56:24 -0700
Message-ID: <7vei654omv.fsf@alter.siamese.dyndns.org>
References: <AANLkTikZ3Po-YdhO-qCn5usVkt4J196eFF6YdbAeMG_X@mail.gmail.com>
 <7v1v267no9.fsf@alter.siamese.dyndns.org>
 <AANLkTikRttGnxex1CYSQnSg4PgctFj0-qNjf5un+fL0W@mail.gmail.com>
 <4D81B04A.1010802@viscovery.net>
 <20110317072723.GH11931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 18:56:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0HRQ-0005eK-6y
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 18:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab1CQR4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 13:56:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab1CQR4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 13:56:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E813C4A97;
	Thu, 17 Mar 2011 13:58:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z6RtjDHlywrH8KO/yvmEOw8H0HE=; b=R6eoST
	47OlD2zIOSAV58HG+ONdOAqMNdxXQLRloNxWNNzWnlgCFLdi/IJMgu/MkemRzpJa
	n8derhr8AapvxATOXwE1ZlgEhQB/dzeDW7hvxb4aDDud3m8EXXIVhy6wIfuwA65n
	6L+bkqox3L4i2b1HbWQruqVokKco63VE381ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sQEkjiBsVD6zO3qrD5hRuk7F9iM1Udpf
	0N6aRQIJQbJTTqYTLz2UV6/y9xF4/6YJQz1wkDoG5iCbsjgAEcFJjuLLY6bsAt84
	PUV5djTyouiLz0cq/C9lbSszlzu7pRREcIHpWsI5TfygBgTd+FrigPk5OwIjd0VO
	vDAfXq7oK/o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6FFE84A96;
	Thu, 17 Mar 2011 13:58:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 33DE24A95; Thu, 17 Mar 2011
 13:57:58 -0400 (EDT)
In-Reply-To: <20110317072723.GH11931@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 17 Mar 2011 03:27:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DB917E2-50C0-11E0-A8BB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169250>

Jeff King <peff@peff.net> writes:

>   2. If we do detect such a mishap, I'm not sure that "indeterminate
>      result" is necessarily the best result, as that will just keep
>      trying more and more commits without success. It is more likely a
>      sign of a poorly written test script, and the best thing we could
>      do is die and say "your test script looks buggy".

Exactly. I agree "Aborting the bisect as run-script is a crap" is the
right thing to do here.
