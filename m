From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always
 use --signoff.
Date: Sat, 27 Dec 2008 00:44:59 -0800
Message-ID: <7v63l6f1mc.fsf@gitster.siamese.dyndns.org>
References: <1230296219-16408-1-git-send-email-dato@net.com.org.es>
 <20081227070228.6117@nanako3.lavabit.com>
 <20081226221033.GA841@chistera.yi.org>
 <7vabaijvxl.fsf@gitster.siamese.dyndns.org>
 <20081227082620.GA5230@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sat Dec 27 09:46:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGUoZ-0002S2-Nl
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 09:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbYL0IpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 03:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYL0IpJ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 03:45:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYL0IpI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 03:45:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D845D8A6A2;
	Sat, 27 Dec 2008 03:45:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BD4C58A6A0; Sat,
 27 Dec 2008 03:45:02 -0500 (EST)
In-Reply-To: <20081227082620.GA5230@chistera.yi.org> (Adeodato =?utf-8?Q?S?=
 =?utf-8?Q?im=C3=B3's?= message of "Sat, 27 Dec 2008 09:26:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A9673EA6-D3F2-11DD-8E91-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103990>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> Does this sound good? If so, I'll send an amended patch (or should I =
send an
> incremental/extra one instead?):
>
> +commit.signoff::
> +       If set, 'git-commit' will always add a Signed-off-by line.

It is not a big deal, but my first reaction to the above was "S-o-b by
whom?  It misses details and does not say where to find them".

How about "if set, 'git commit' will behave as if '-s' option was given=
",
so that we can leave the details of whose S-o-b line to generate and su=
ch
to the description of "git commit -s" manual page?

> +       Please use this option with care: by enabling it, you're stat=
ing
> +       that all your commits will invariably meet the S-o-b
> +       requirements for any project you send patches to. It's probab=
ly
> +       best to only use it from your private repositories' .git/conf=
ig
> +       file, and only for projects who require a S-o-b as proof of
> +       provenance of the patch, and not of its correctness or qualit=
y.

Yeah, many projects do not even have S-o-b convention.

>> By the way, please do not deflect away responses meant to you by usi=
ng a
>> Mail-Followup-To header that points at the git mailing list.  It is =
rude.
>
> I set a M-F-T header because I prefer not to be CC'ed. I have other
> mechanisms in place that prevent me from missing replies to my messag=
es
> (based on In-Reply-To/References headers).
>
> Nevertheless, if the list normally operates CC-based, I can see how p=
ressing
> Reply-to-all and not seing the original autor in the recipient list c=
an be
> offputting, so I'll stop setting M-F-T in my messages to git@. (Hopef=
ully
> starting with this message already.)

Thanks.

Another problem that you seem to have missed about M-F-T is that while =
you
solicited responses from general public by CC'ing the list (which allow=
ed
me to respond to you), by forcing the response go only to the list, you
excluded people on the To: and Cc: list of your original message from m=
y
response.  You required them to be subscribed to the list, if they want=
 to
be kept in the loop.
