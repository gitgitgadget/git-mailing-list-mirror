From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/73] No-op gettextize core Git C programs
Date: Tue, 22 Feb 2011 16:49:30 -0800
Message-ID: <7v1v2zbmn9.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 01:49:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps2vI-0003kd-Bn
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 01:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab1BWAtk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 19:49:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab1BWAtj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 19:49:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ACCA74923;
	Tue, 22 Feb 2011 19:50:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KNt4poYZYYKV
	SOXROqHiAtdnQnA=; b=j8JuzNOlMFV/DhFVCPC21pM7ZSjDVKGS4mxrF3kBF/zw
	0tjHihPCsHnlqsma83C2se4FMiqDx0RUTK2DNuyKB9QVmIlphKIADNhYQMh3mg3S
	Qj81nrMJiwXhcI+qnumEw+n2noOmZFkgPGogokbTEQ967IrSn5WAZvEd4PHoIR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XxQmrB
	4fmqcUn+6IaDzq46iDDLfx0DMlax77Gn9986A0BU6Wt8TJFkXMikocXNOLxIrWUw
	DrjFqalkJyDC8iLepK48jPZGuqili0saUrkDB9tytUYZP7coxC8F8el57q2fM89q
	9VBWib96xySecBV+smd/5eArhPfYDI9K0C/R8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B2074922;
	Tue, 22 Feb 2011 19:50:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6E34D4921; Tue, 22 Feb 2011
 19:50:44 -0500 (EST)
In-Reply-To: <1298418152-27789-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue\, 22 Feb
 2011 23\:41\:19 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4630866-3EE6-11E0-8605-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167669>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>   * Reverted back to using the "gettextize" patch subjects I
>     originally used. I'm using these consistetly so I can later git
>     log --grep=3Dgettextize: to find them. I'd like to preserve that
>     attributed.

Can we make that shorter, perhaps just "i18n:"?  In this series, your
first three and Jonathan's are oddballs that do not have "gettexize:"
anyway.

Will give it a whirl.  Thanks.
