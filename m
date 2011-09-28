From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] parseopt: add OPT_NOOP_NOARG
Date: Wed, 28 Sep 2011 12:47:14 -0700
Message-ID: <7vlit8zby5.fsf@alter.siamese.dyndns.org>
References: <7v39fhv8se.fsf@alter.siamese.dyndns.org>
 <4E835CFE.7020501@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Sep 28 21:47:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R906E-0006p6-I3
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 21:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389Ab1I1TrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 15:47:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab1I1TrR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 15:47:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFF475D7E;
	Wed, 28 Sep 2011 15:47:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=FNEX/5
	MI4XK8clYfYBe+TgmQZaefp5RZzsws1ok20AuEMub4w2hxUkM43R5kHYHScGuz7r
	FJUZ94ySrZ0JjypGHqMqnsa3Cx7lZtSa2wrWtlUqrOtSCvq8PBy2r7CF6SQrTViK
	5BPWxPwQVZgiAFv8msQj1k+eEkvUstFNdq3Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YWt4bFr4trfxrTeXGYriQ1565WhF60bS
	duRpd0heTdwiKIBxyfKNRpRX1v0uvpHoiJ/A46rDDoDyeYMs2H99i04nAt5rJ0qf
	f+G0ZKHQnFyvr8NMI+lJ0Q7KiD+yv4pzh1tkVPP++cDPuNBu1RXgkX2wgaiH7peI
	sjwPGnqsNn8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A58C15D7D;
	Wed, 28 Sep 2011 15:47:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C4E85D7C; Wed, 28 Sep 2011
 15:47:16 -0400 (EDT)
In-Reply-To: <4E835CFE.7020501@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Wed, 28 Sep 2011 19:44:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB1E5410-EA0A-11E0-9975-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182363>

Thanks.
