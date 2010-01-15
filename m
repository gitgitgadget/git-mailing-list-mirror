From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in 
	summary
Date: Fri, 15 Jan 2010 03:21:42 +0200
Message-ID: <94a0d4531001141721j261facedlf5d1bd9e611c224c@mail.gmail.com>
References: <20100113173408.GA16652@coredump.intra.peff.net>
	 <20100113184510.GA22849@coredump.intra.peff.net>
	 <5722BD3D-E7C9-47F7-B547-09B14D87DA39@wincent.com>
	 <201001141602.22244.trast@student.ethz.ch>
	 <94a0d4531001141104w74dbaf35jb5fded9e266bc04b@mail.gmail.com>
	 <7vy6k0cxbz.fsf@alter.siamese.dyndns.org>
	 <94a0d4531001141136m3eb51d11rafdf7f0672e68dff@mail.gmail.com>
	 <7vy6k0bheg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 02:21:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVasm-0006Ax-DP
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 02:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166Ab0AOBVo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 20:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092Ab0AOBVo
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 20:21:44 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:61546 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab0AOBVn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2010 20:21:43 -0500
Received: by iwn32 with SMTP id 32so228561iwn.33
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 17:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lsjZjyCcJqE4lg508fFWTyodGaMCcf9+Fdx6Y8UktlU=;
        b=RlD7GSw2d+VFuat5WRSPLUnAUy//nufhuQgwSqCO0vhfqPmxvsxLMF47QFOgMOyqpC
         A/oi9O9ahg/kD50U3GECa4fe09jEN6rT2tAPdBa1buc6kI7SSVquxs28fuxTY5LMRkyY
         nJlwVZzHRamIzY9cMF7fg/XKer4XpBnzXzxzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=is0VYjkplUF4Xb1SRj1y2JgTP9kqh80HVgxJikJJrnY5d2INw7BNH/pPzHOFvlwLe1
         TznifB93/c6ZSDiA92z/e4Uf2VGqEhMwJsU5XKFw37nAebc73Q4NmYCFxQe72o17uMND
         gblPQp6TbpNIXo+a0rwsOIKWSPxlzdkzOke1w=
Received: by 10.231.59.5 with SMTP id j5mr923930ibh.6.1263518502094; Thu, 14 
	Jan 2010 17:21:42 -0800 (PST)
In-Reply-To: <7vy6k0bheg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137046>

On Thu, Jan 14, 2010 at 9:44 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Users are lazy.
>
> And the ones that suffer from the issue discussed in this thread will=
 not
> read the manual your patch touches. =C2=A0When you make changes to th=
e manual,
> you should not be targetting them, as they won't read it anyway. =C2=A0=
Instead,
> the description of the manual should aim to help people who _read_ it=
=2E

The world is not clear-cut between users who read, and users don't.
Most probably user laziness follows a Pareto distribution:
http://en.wikipedia.org/wiki/File:Pareto_distributionPDF.png

The long tail of users who don't read much is so big that you will
find *a lot* that don't read anything at all, therefore you would also
find many that read a bit, and as a consequence a tiny amount that
actually would read the whole user manual.

Clearly, Thomas' comment implies that some people might need to adjust
their mental model to reflect reality.

--=20
=46elipe Contreras
