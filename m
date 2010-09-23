From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] git-send-email.perl: Add --to-cmd
Date: Thu, 23 Sep 2010 15:37:05 -0700
Message-ID: <7v62xwqe7i.fsf@alter.siamese.dyndns.org>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
 <AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
 <1285227413.7286.47.camel@Joe-Laptop>
 <Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
 <20100923090931.GA29789@albatros> <20100923120024.GA26715@albatros>
 <1285253867.31572.13.camel@Joe-Laptop>
 <Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
 <1285262237.31572.18.camel@Joe-Laptop>
 <AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
 <1285263993.31572.25.camel@Joe-Laptop>
 <AANLkTinCx=+n6bMZw4tQqrQ7WC1o_aeGG_n_PxywTyb8@mail.gmail.com>
 <1285267520.31572.34.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Julia Lawall <julia@diku.dk>, git <git@vger.kernel.org>,
	Vasiliy Kulikov <segooon@gmail.com>,
	matt mooney <mfmooney@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 00:37:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyuQD-0002uz-9F
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 00:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab0IWWhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 18:37:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab0IWWhi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 18:37:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC160D8D65;
	Thu, 23 Sep 2010 18:37:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0kHGef8tfR9B
	T0wYy7L3XVHe6KE=; b=pi1oPllUUxD/OTreWzw9UiOmmdB2ll1M6TXFULweN03r
	JiP6wrk8j5vXbaJfxvo3jus345Nt1uUh78FuEe8Dzs2e4QXuqvwcR0wvK+uAKeol
	TMtoGVbZ8jQaKdimlItSAPzBHabVZA+h2qFrqK4JRASSCwM6x61Hw8cR+BjASwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IJ6jCa
	X+GzxpXStVmAe29VLXHqtKoyBuo56XpFRxytjqQcz3sY66d92toqc6a0qVhYesbN
	HeA6cEcmRsfoHlhnY7lDN5Nj1/K3+AjNdlzwXM6pcCdstxD3qRtQo0CObviYufII
	IboLBWPl8rr2pCgOAEw8ckYEY4J34SESLYCl0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57ED1D8D5B;
	Thu, 23 Sep 2010 18:37:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97CC9D8D55; Thu, 23 Sep
 2010 18:37:07 -0400 (EDT)
In-Reply-To: <1285267520.31572.34.camel@Joe-Laptop> (Joe Perches's message of
 "Thu\, 23 Sep 2010 11\:45\:20 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1FC4761C-C763-11DF-8E89-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156920>

Joe Perches <joe@perches.com> writes:

> +	if (defined $to_cmd) {
> +		open(F, "$to_cmd \Q$t\E |")
> +			or die "(to-cmd) Could not execute '$to_cmd'";
> +		while(<F>) {
> +			my $t =3D $_;

"my $t" masks another $t in the outer scope; technically not a bug, but
questionable as a style.

> +			$t =3D~ s/^\s*//g;
> +			$t =3D~ s/\n$//g;
> +			next if ($t eq $sender and $suppress_from);
> +			push @to, parse_address_line($t)
> +			    if defined $t; # sanitized/validated later

This "if defined $t" makes my head hurt.  Why?

 * The "while (<F>)" loop wouldn't have given you an undef in $t in the
   first place;

 * You would have got "Use of uninitialized value" warning at these two
   s/// statements if $t were undef; and

 * Even if $t were undef, these two s/// statements would have made $t =
a
   defined, empty string.

> +			printf("(to-cmd) Adding To: %s from: '%s'\n",
> +				$t, $to_cmd) unless $quiet;
> +		}
> +		close F
> +			or die "(to-cmd) failed to close pipe to '$to_cmd'";
> +	}

In any case, this whole codeblock obviously is a copy-and-paste from
corresponding $cc_cmd codepath, and I wonder if you can refactor the
original into a common helper function first and then use it to make th=
e
addition of this feature a smaller patch.

	if (defined $cc_cmd) {
        	push @cc, recipients_cmd($cc_cmd, 'cc');
	}
        if (defined $to_cmd) {
	        push @to, recipients_cmd($to_cmd, 'to');
	}

If you did so, the first patch that refactors to create a helper functi=
on
can address issues =C3=86var raised in the review to clean things up, n=
o?

I notice that you use parse_address_line() while $cc_cmd codepath doesn=
't.
I haven't studied other codepaths deeply, but my gut feeling is that th=
e
reason why the $cc_cmd codepath does not call parse_address_line() befo=
re
pushing the result to @cc is _not_ because strings on @cc shouldn't be
sanitized (the codepath to parse "Cc: " calls parse_address_line and
pushes the result to @cc), but because the code is simply sloppy.  So I
suspect that it would be Ok for recipients_cmd to call parse_address_li=
ne
unconditionally.

Hmm?
