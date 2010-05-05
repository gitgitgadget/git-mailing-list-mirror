From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Set GIT_PATHNAME_PREFIX with aliases.
Date: Wed, 05 May 2010 09:07:34 -0700
Message-ID: <7v1vdql4c9.fsf@alter.siamese.dyndns.org>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
 <20100505005153.GC25390@coredump.intra.peff.net>
 <4BE115EF.8010306@viscovery.net>
 <20100505070131.GA11265@coredump.intra.peff.net>
 <19425.9169.537598.876589@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed May 05 18:07:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9h8e-0000YJ-GT
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 18:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933960Ab0EEQHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 12:07:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593Ab0EEQHs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 12:07:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD1C5B096C;
	Wed,  5 May 2010 12:07:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GaY0TNR1DC/F+rWGPa8i+pdXZsU=; b=KohVVx
	E16r9Kh3UB/oSMNl6lNImQcLg08ufzl8B2kbtOIbjRGSoY5dtv8z7qHGPmHys5yi
	UZhZpGwXPR3m1n423t/zAw5hUCIZ5EvOdtPNuYtsLmtK8QjQUB7qYGVCjcQEBkWS
	AA76nKgizyFkMK10UaO89tL+jr5xqVqkXzs0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IrJ90rrEBtrJogSmPfdkbLkxsspVcRmt
	IDe1XKoMU3sfYcmvbht4iYXWQSiX9b71Otf5OAVXHGTlLogBsfFNImEAaoHQLKvn
	a6VEWZTsLvUNLQ9N+W9Cxh3zn7awgP6Tghh/9INNa7dcFit2/vY9XZ4RlzbZ+Spj
	F1Ig1cmxF2k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 890EDB0968;
	Wed,  5 May 2010 12:07:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAFE7B0963; Wed,  5 May
 2010 12:07:35 -0400 (EDT)
In-Reply-To: <19425.9169.537598.876589@winooski.ccs.neu.edu> (Eli Barzilay's
 message of "Wed\, 5 May 2010 03\:52\:49 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55483F52-5860-11DF-8824-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146408>

Eli Barzilay <eli@barzilay.org> writes:

> On May  5, Jeff King wrote:
>> 
>> Yes, I agree it sucks.

I would not use such a strong word but I agree that it would have been
nicer if the original directory were used.

> Something that Jonathan suggested earlier is a different magic
> character instead of "!" that will do the cd -- perhaps a second
> character would be more acceptable, something like "!!"...

That sounds a reasonable compromise.
