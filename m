From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add support for IPv6 on MinGW
Date: Mon, 23 Nov 2009 16:58:42 -0800
Message-ID: <7vy6lwrb5p.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.0911240052440.14228@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin =?utf-8?Q?Storsj=C3=B6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Tue Nov 24 01:59:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCjkE-0002Oi-Ok
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 01:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbZKXA6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 19:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbZKXA6q
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 19:58:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbZKXA6p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 19:58:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FA9582794;
	Mon, 23 Nov 2009 19:58:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vDNS7YzkvZ2/
	r44FLOt1IBB4Aak=; b=R5gL8KbI4b1XUx7O1UaafFspGz4gBzIzKsWfjza5Fd1a
	5t9KDqlVmXdLqp7je4Wat6Bt9SGQyQsJC+v4PO/Du0lA+HQ8xsCp5s1bPvZz03g4
	3QZTyzEAsnmr44oW/s4zqiCfQXfYSxSNlGo89bV4rEVmOWAa6/0mZaIZi7nC3H0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OvMJQ3
	AimQJRwwwBklEI7UV6x4tTbb3Zm74Gi0Ui8ifoG6R4BD7lELjrjqHA0Kq7v50vVS
	jFrhYCjERBG4P/NFPhuB8NWqoWx2XSc0Xxpj0udkox/efL8p3/qeJtk7fxQf91Jj
	mKR0s7z7aJBxE3T1PwbLP3ggYcSijLLdeDd40=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CF4C82793;
	Mon, 23 Nov 2009 19:58:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 572D082792; Mon, 23 Nov
 2009 19:58:44 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.0911240052440.14228@cone.home.martin.st>
 ("Martin =?utf-8?Q?Storsj=C3=B6=22's?= message of "Tue\, 24 Nov 2009
 00\:54\:13 +0200 \(EET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85434392-D894-11DE-92BD-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133549>

Martin Storsj=C3=B6 <martin@martin.st> writes:

> This is a short patch series that adds support for IPv6 on MinGW. The=
se=20
> patches have been in use in msysgit for a few months (but the code wa=
s=20
> accidentally removed recently in a merge). For consistency, it would =
be=20
> good to add them upstream, too.

I am aware of the exchange between you and J6t on msysgit@googlegroups
where he suggested you to send them here.  Giving better visibility to
these patches for public review is good.

But you didn't have to Cc: me; in Windows API issues I have no clue so =
I
won't be a good reviewer.  I do not even compile git on Windows myself,
let alone testing nor using.

As hinted by J6t, he will be saying Ack or something else, so I'll act =
on
these patches when it happens.

Preferrably, I'd like somebody reasonably high in msysgit foodchain to
volunteer to be a coordinator and send me a pull-request whenever a set=
 of
changes that has been:

 (1) cooking in msysgit tree without issues; and

 (2) reviewed favorably here on this list

is ready for git.git.  That way, I do not even have to remember whose
patches in the msysgit area I should blindly trust and apply, or keep
track of which patches are still under discussion in general.

Thanks.
