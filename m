From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Mon, 22 Feb 2016 13:56:52 -0800
Message-ID: <xmqqlh6c5ryz.fsf@gitster.mtv.corp.google.com>
References: <vpqoabox66p.fsf@anie.imag.fr>
	<CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
	<vpqd1s2e74l.fsf@anie.imag.fr>
	<20160212130446.GB10858@sigill.intra.peff.net>
	<vpqd1s04zzs.fsf@anie.imag.fr>
	<CACsJy8BzkWSc11ODenEuGBBta+dkLS893o7oRS57_ctoB5ie8A@mail.gmail.com>
	<vpqziutkps7.fsf@anie.imag.fr>
	<20160222214246.GE15595@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 22:57:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXyTT-0000rt-W0
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 22:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbcBVV44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 16:56:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753138AbcBVV4z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 16:56:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F31147508;
	Mon, 22 Feb 2016 16:56:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A3go81Vyac/rcsXTLp/S3hL0CDE=; b=nD0rnh
	4qws/ouw6MhQ9+seSqUODjzxwcoWRvCbMluiotkVve8Aw3hvXhgI1vhNB6UbypYa
	tKECjHhVBF6L3yFKYb49FXOea5E/B28qsxvDrydAIi0W01fG2LjJTpvwUNsLIIMX
	7Q0d38NA3qgaQfAh8uDluBSKOeRrY0lSZjB8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WCk4TjDIEGCKYum7y0MIVfzRKyHT0umc
	I9bgu3X3i2DgQKL/qg2oyMH9HQJzLc87ZHbV80IDHkjXCVKETkmjviThtkiWuM6F
	4qkO9i/vaQQx6zMPO96Iypf5quhACKWuJ/5ad6sMtQhST48bK/VazvIyJDXhUm7a
	J1YXg2eyONQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2519E47507;
	Mon, 22 Feb 2016 16:56:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 96A7447506;
	Mon, 22 Feb 2016 16:56:53 -0500 (EST)
In-Reply-To: <20160222214246.GE15595@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 22 Feb 2016 16:42:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F13822A-D9AF-11E5-B187-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286956>

Jeff King <peff@peff.net> writes:

> I agree that there are a lot of different ways to resolve each instance,
> and it will vary from case to case. I think the original point of a
> microproject was to do something really easy and not contentious, so
> that the student could get familiar with all of the other parts of the
> cycle: writing a commit message, formatting the patch, posting to the
> list, etc.

I had an impression that Micros are also used as an aptitude test,
and one important trait we want to see in a potential developer is
how well s/he interacts with others in such a discussion.  So "easy
and not contentious" might not be a very good criteria.

I dunno.

> It seems like this has a high chance of frustrating students as they get
> embroiled in back-and-forth review. I dunno. Maybe it should be marked
> with a star as a "challenge" microproject. :)
