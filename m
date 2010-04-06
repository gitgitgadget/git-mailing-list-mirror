From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation: reorganize documentation of URLs
 understood by git
Date: Mon, 05 Apr 2010 23:57:13 -0700
Message-ID: <7v6345jcfq.fsf@alter.siamese.dyndns.org>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com>
 <20100329191832.GA26842@progeny.tock>
 <f3271551003291224s7fb0d8d3sce75b7c893fabfa8@mail.gmail.com>
 <20100406060606.GA26629@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 08:57:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz2jE-0007tb-PF
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 08:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264Ab0DFG5e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 02:57:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab0DFG5c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 02:57:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72BB6A83FF;
	Tue,  6 Apr 2010 02:57:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wB8ndOuJUs6e
	q6LVRpnNbQk2XJU=; b=C81nn/NwL+mxuR1Kqu1KCNGpLsq7FuSv6hazjhBETk7T
	Rg7rwPqD8FbqKBt19Io1M6e/Qj1HSzMSq3GYimvdQRNQsxpYncPxOyPEbXf1skH8
	9EldzqdmLJBbs+cnDwklpMymse3QUwRfFe0BiXNIDIDCA2o1uWxDpntlJxLOdOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QglGNs
	uEWw9kRgAXxHLYnWcuQ54ooYbX5iv7rxtolJO8qCfQ4yUUc7bQHE770OgiXRZvm8
	A/dGY3oYmtQO5xgwVpth4ALBq3n+LyLTSJI+zl0A4CkkBzaiMMcBvP9jtDmLKxIc
	ldO7neweK1la4YBigMrJgZVveXX1ybsK+62P8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB3A2A83F8;
	Tue,  6 Apr 2010 02:57:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B231DA83F5; Tue,  6 Apr
 2010 02:57:14 -0400 (EDT)
In-Reply-To: <20100406060606.GA26629@progeny.tock> (Jonathan Nieder's message
 of "Tue\, 6 Apr 2010 01\:06\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A73D3796-4149-11DF-BA53-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144107>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The main idea driving this for me is that the reference manual should=
 be
> something that a sufficiently interested person could read from cover=
 to
> cover.  As it is, there=E2=80=99s too much repetition for that.

I am of two minds.  It is frustrating if "git clone" (or "git fetch", o=
r
"git remote") page didn't list any examples an intelligent person (or a=
t
least one who thinks he is intelligent enough) to mimic and instead
referred him with "look there" indirections.  While I fully share your
"cover-to-cover" concern, the current organization was chosen to minimi=
ze
such indirection.  It is optimized for different audiences than we are =
(I
am also from "cover-to-cover" school) who want to pick only the pages
relevant to the task at hand.
