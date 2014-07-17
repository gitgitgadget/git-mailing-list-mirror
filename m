From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .mailmap: Map different names with the same email address together
Date: Thu, 17 Jul 2014 07:29:04 -0700
Message-ID: <xmqqa988qcsv.fsf@gitster.dls.corp.google.com>
References: <1404996506-7723-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jl@opera.com, ksaitoh560@gmail.com, vnwildman@gmail.com,
	git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 16:29:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7mgP-0004zH-HT
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 16:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbaGQO3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2014 10:29:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56584 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756732AbaGQO3M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2014 10:29:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 95547282DC;
	Thu, 17 Jul 2014 10:29:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2f7EgV7bvYBP
	IKxp8Uv/KgHhbOA=; b=EidL3c1v+Kzb/X3SFxoiQq6HqIgFKMjcUZ5PW6LEWa6i
	74ulp6qV2StNoMbl6/T6C/tK4y57x2vLMEljmbuLUG7qFnybJl+G3Gfhyvqfuc2g
	W8OGD3npA5W81HvMKzFBQFWGlWpIiNYY0JMfoJ8ttosbMB96HTt7wOjgJ+3MXKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JFMFAN
	9H8jSSaPVtoNbm9TopLNGuyVtuO6I5aXycF5IZfErrobQVBkuD2bNZGaWr8UI3sV
	7Zg6JlL04aSlcmudzcozClEMRAn0d/41CXWWBNXG5LDLVYzWM+5YnQpyIdo0+ZGW
	np/z6eYl7AH7wcek1Z6idYYUPdasbYOdCsWYY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89B1D282DB;
	Thu, 17 Jul 2014 10:29:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA6AA282D6;
	Thu, 17 Jul 2014 10:29:05 -0400 (EDT)
In-Reply-To: <1404996506-7723-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Thu, 10 Jul 2014 14:48:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B4F87D82-0DBE-11E4-B419-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253736>

Stefan Beller <stefanbeller@gmail.com> writes:

> Pretty much one year ago
> (94b410bba864, Jul 12 2013, .mailmap: Map email addresses to names)
> I cleaned up the output of `git shortlog -sne` of git.git by writing =
a
> .mailmap file fot the git.git project.
> Now I find some time again for another review.
> During the year Jens, Kazuki and Tr=E1=BA=A7n contributed to git.git =
using
> different names, but the same email address.
>
> Would you mind to acknowledge this change to the mailmap file?
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---

It has been a week since this was asked to be eyeballed.  People do
not have objection, or they do not hang around this circle any more.
I would imagine that it does not matter to them a bit how their
names are spelled around here in the latter case.  Or they may have
responded privately to you.

If you received a private "no" to some entries, please advise;
otherwise I would say the patch is ready to be picked up.

Thanks.

>  .mailmap | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.mailmap b/.mailmap
> index 11057cb..2edbeb5 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -85,6 +85,7 @@ Jeff King <peff@peff.net> <peff@github.com>
>  Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
>  Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
>  Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
> +Jens Lindstr=C3=B6m <jl@opera.com> Jens Lindstrom <jl@opera.com>
>  Jim Meyering <jim@meyering.net> <meyering@redhat.com>
>  Joachim Berdal Haga <cjhaga@fys.uio.no>
>  Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindeli=
n@gmx.de>
> @@ -113,6 +114,7 @@ Karsten Blees <blees@dcon.de> <karsten.blees@dcon=
=2Ede>
>  Karsten Blees <blees@dcon.de> <karsten.blees@gmail.com>
>  Kay Sievers <kay.sievers@vrfy.org> <kay.sievers@suse.de>
>  Kay Sievers <kay.sievers@vrfy.org> <kay@mam.(none)>
> +Kazuki Saitoh <ksaitoh560@gmail.com> kazuki saitoh <ksaitoh560@gmail=
=2Ecom>
>  Keith Cascio <keith@CS.UCLA.EDU> <keith@cs.ucla.edu>
>  Kent Engstrom <kent@lysator.liu.se>
>  Kevin Leung <kevinlsk@gmail.com>
> @@ -229,6 +231,7 @@ Tommi Virtanen <tv@debian.org> <tv@inoi.fi>
>  Tommy Thorn <tommy-git@thorn.ws> <tt1729@yahoo.com>
>  Tony Luck <tony.luck@intel.com>
>  Tor Arne Vestb=C3=B8 <torarnv@gmail.com> <tavestbo@trolltech.com>
> +Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com> Tran Ngoc =
Quan <vnwildman@gmail.com>
>  Trent Piepho <tpiepho@gmail.com> <tpiepho@freescale.com>
>  Trent Piepho <tpiepho@gmail.com> <xyzzy@speakeasy.org>
>  Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> <Uwe.Kleine-K=
oenig@digi.com>
