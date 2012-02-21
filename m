From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Working with remotes with (too) many branches
Date: Tue, 21 Feb 2012 14:47:30 -0800
Message-ID: <7vwr7ferct.fsf@alter.siamese.dyndns.org>
References: <CAKHWUka763XRWyMz2Xq1qQ2rfKqSYdTX0xtdVFm8zWJ_+6tGqA@mail.gmail.com>
 <7v7gzipkt8.fsf@alter.siamese.dyndns.org>
 <CAKHWUkY_bEtKoPOiWFz6i2bp-tbekapROOaCYR0k5Ymh0HYMdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Philip =?utf-8?Q?J=C3=A4genstedt?= <philip@foolip.org>
X-From: git-owner@vger.kernel.org Tue Feb 21 23:47:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzyUk-00018D-SL
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 23:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209Ab2BUWre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 17:47:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245Ab2BUWrd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 17:47:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5D1D664F;
	Tue, 21 Feb 2012 17:47:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PWo/R0upa0LC
	b5kgyntfCLlARJs=; b=xKktStyOsG3tznl23EpST0EPM1LBzC4Za8cBm6WjoJRX
	IDRB5g60C/GgnSxwP1iQ3VUx1gksCGJiXLeMSO1dmk+QT5k/SaFHIuFbo1kPQ047
	qWs1wiYNnpeq66pmCRAcSKrNtPrffK103DGtb+b67fvUq6bo/QaB0crxFnxWR+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e2lzuu
	a12u5ylfBqLtWO3qklXcu9CnnZXodN1wmj1M/Ia5pXhzaJGkuKRkVD6mbKb8S+L6
	o+PjiMcGM7IfdjI5CkjAozW21infakfT2w3IE6o+3Wc1/Y20hB9lRckllvsXaW7r
	SRh3ENInwc0k2TsM3fK9UBE34FWJxQkv1Co9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDF3A664E;
	Tue, 21 Feb 2012 17:47:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5383E664B; Tue, 21 Feb 2012
 17:47:32 -0500 (EST)
In-Reply-To: <CAKHWUkY_bEtKoPOiWFz6i2bp-tbekapROOaCYR0k5Ymh0HYMdA@mail.gmail.com> ("Philip
 =?utf-8?Q?J=C3=A4genstedt=22's?= message of "Tue, 21 Feb 2012 23:36:25
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A52F8F0-5CDE-11E1-AC24-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191195>

Philip J=C3=A4genstedt <philip@foolip.org> writes:

> This looks a bit odd to me, shouldn't the new setting file under
> [remote "origin"]?

Yeah, remote.$name.fetchDefault or something.

> Thanks for the tip. (I did look at the original commit and search the
> archives, but found no answers.)

Heh, it does say --delete # not implemented ;-)
