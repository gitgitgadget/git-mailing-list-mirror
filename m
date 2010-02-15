From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Fix 'git var' usage synopsis
Date: Sun, 14 Feb 2010 18:22:47 -0800
Message-ID: <7vfx53xmo8.fsf@alter.siamese.dyndns.org>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock> <20100214115533.GA3499@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 03:23:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngqc8-0002Qz-DD
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 03:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab0BOCXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 21:23:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab0BOCXA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 21:23:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D63D9AE3E;
	Sun, 14 Feb 2010 21:22:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sZ+cyTHzpnnm16vJVtTkYbvk0pU=; b=Fojc+I
	EranIwjldCWyb4cJgEHLOgImNOOzQYZv9Cv6dagtj9mDK3W1L2ISGi5Gg0G870oq
	euzFx2yE8uYf7T2vpTejkqet0NeX37nZbEES3Kj3e11eqK4Y+6QiA98o37GkaOI3
	rO8aiXMUOUR1t4KdelPS369U9KD/hHtES5jpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sGRQ5vs/Vwwd72jPE7KOMFifiozIxjVo
	axmmfuEdc/BT75JzCZhscpnuiaeSQvAIqUn+UsN4vgwEhceaK35i2h8x19wMEegN
	3FndhZyjj14nMHq6/kRYJ8BjcyjHV7pvS1+Wd3mP349Ozgqm2Q+J7uw4Yf8WR8L7
	nuDKH/Pb6L0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDCA59AE3D;
	Sun, 14 Feb 2010 21:22:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 122DD9AE3C; Sun, 14 Feb
 2010 21:22:48 -0500 (EST)
In-Reply-To: <20100214115533.GA3499@progeny.tock> (Jonathan Nieder's message
 of "Sun\, 14 Feb 2010 05\:55\:53 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05BEEC3A-19D9-11DF-8A73-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139958>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The parameter to 'git var' is not optional.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Noticed while considering changing the usage.

And the patch does not even apply.  Sigh.
