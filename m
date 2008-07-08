From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash: offer only paths after '--'
Date: Tue, 08 Jul 2008 16:23:01 -0700
Message-ID: <7v7ibwq7u2.fsf@gitster.siamese.dyndns.org>
References: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com>
 <20080708044922.GD2542@spearce.org>
 <7vprppvt7a.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807081335470.4319@eeepc-johanness>
 <20080708165614.GB8224@neumann> <7vtzf0rusw.fsf@gitster.siamese.dyndns.org>
 <20080708231837.GA16895@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER GGGbor <szeder@ira.uka.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 01:24:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGMXh-0001KX-Hr
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 01:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759873AbYGHXXP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 19:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759271AbYGHXXO
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 19:23:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759873AbYGHXXN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2008 19:23:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F25C16212;
	Tue,  8 Jul 2008 19:23:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6377E16210; Tue,  8 Jul 2008 19:23:04 -0400 (EDT)
In-Reply-To: <20080708231837.GA16895@spearce.org> (Shawn O. Pearce's message
 of "Tue, 8 Jul 2008 23:18:37 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D5497DB6-4D44-11DD-BD57-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87809>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>>=20
>> > Hope that I got the commit message right (;
>>=20
>> It was very readable.  Thanks.
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
>
>> > +__git_has_doubledash ()
>> > +{
>> > +	local c=3D1
>> > +	while [ $c -lt $COMP_CWORD ]; do
>> > +		if [ "--" =3D "${COMP_WORDS[c]}" ]; then
>> > +			return 0
>> > +		fi
>> > +		c=3D$((++c))
>>=20
>> This assignment is somewhat curious, although it should work as expe=
cted
>> either way ;-)
>
> I agree, its damned odd.  But we already do this in the same
> sort of loop inside of _git_branch() (see around line 541 in
> next).  This new patch is only sticking with our current set
> of conventions in the script, so I say its fine.

Chuckling...  Thanks for sanity checking and an Ack.
