From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] parse-options.c: introduce OPT_DATE
Date: Mon, 24 Mar 2008 23:58:48 -0700
Message-ID: <7vmyonnvbr.fsf@gitster.siamese.dyndns.org>
References: <200803232150.29971.barra_cuda@katamail.com>
 <200803241502.21465.barra_cuda@katamail.com>
 <7vwsnrubmd.fsf@gitster.siamese.dyndns.org>
 <200803242218.44026.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 07:59:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je38M-0002kS-NN
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 07:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbYCYG7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 02:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbYCYG7H
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 02:59:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbYCYG7F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 02:59:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 14D722F7C;
	Tue, 25 Mar 2008 02:59:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4082D2F7B; Tue, 25 Mar 2008 02:58:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78153>

Michele Ballabio <barra_cuda@katamail.com> writes:

> On Monday 24 March 2008, Junio C Hamano wrote:
>> Michele Ballabio <barra_cuda@katamail.com> writes:
>>=20
>> > +int parse_opt_approxidate_cb(const struct option *opt, const char=
 *arg,
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0int unset)
>> > +{
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*(unsigned int *)(opt->value) =3D a=
pproxidate(arg);
>>=20
>> Doesn't approxidate return ulong, not uint?
>
> Yes, you're right.

Now, it is getting somewhat tiring to keep track of "oops, that was wro=
ng,
and here is a fix-up on top".

So here is my attempt to summarize by presenting them in an order that =
I
think is sensible.
