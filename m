From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] shorten_unambiguous_ref(): Allow shortening refs/remotes/origin/HEAD to origin
Date: Tue, 07 May 2013 15:06:54 -0700
Message-ID: <7vtxmeigw1.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-2-git-send-email-johan@herland.net>
	<7vy5bsq9m9.fsf@alter.siamese.dyndns.org>
	<CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
	<7vy5bqiij3.fsf@alter.siamese.dyndns.org>
	<CALKQrgdaXOjXFeWSpGtgqKhALqpRN0L7VEMbNf+93UJEBTD9ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed May 08 00:07:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZq2I-0000Dv-N5
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 00:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab3EGWG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 18:06:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab3EGWG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 18:06:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E34081D6EC;
	Tue,  7 May 2013 22:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WUmGztrXRwFVhowKiZRaHRRD74M=; b=Ir1ads
	ZJ20MT97aahQ59OfzqhYn/6v22IcfAUu2gnhFKMzNpf288gMFFVUGf497nP0EmQh
	ayCOUQsZDfQvHmk2tthdh9NN0gdjuq+5M62lUQYgNKhWVIvJvUq+4Bab2+UhvnyB
	DcD9qXoJFYzBG5lH+fd5JOO1XzzIt8TdIFAgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=epO5AkCnXWJIz2kioVzUqYpRaRotNLfz
	77C4+6joSY/vQUfHp9cZFDfAkqJL4zZo0KSL8eO2OWa7ESmmvyTZL5t1OOMXqZRR
	uaY4meMQULo+9A2k8roaJ422EWZjKk4cEYd+dOwhlWds5MVI/S3VUhj6Jf6zXMXR
	Y7ovlf2siN8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D84FE1D6EB;
	Tue,  7 May 2013 22:06:56 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D7A71D6EA;
	Tue,  7 May 2013 22:06:56 +0000 (UTC)
In-Reply-To: <CALKQrgdaXOjXFeWSpGtgqKhALqpRN0L7VEMbNf+93UJEBTD9ig@mail.gmail.com>
	(Johan Herland's message of "Wed, 8 May 2013 00:03:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E8CACFA-B762-11E2-86E3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223621>

Johan Herland <johan@herland.net> writes:

> ...oops, I see I forgot the trailing && on this line. Do you want a
> resend, or fix up yourself?

I've pushed out a heavily fixed-up version on 'pu', mostly for
styles and some log message changes to describe "when it is not a
symref".
