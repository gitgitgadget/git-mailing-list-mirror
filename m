From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] add -p: make the beginning of the hunk easier to see
Date: Sat, 13 Feb 2010 17:01:13 +0100
Message-ID: <6672d0161002130801j1971cd32p9f6de7d250a1b289@mail.gmail.com>
References: <4B768807.3030003@gmail.com>
	 <20100213112342.GA1299@coredump.intra.peff.net>
	 <6672d0161002130333m55372972x909234cae7bd0d82@mail.gmail.com>
	 <6672d0161002130342h348765a0j76f63972c4bbe060@mail.gmail.com>
	 <20100213115512.GA5472@coredump.intra.peff.net>
	 <6672d0161002130634j6d9b4994w5cd44405fe9b98a1@mail.gmail.com>
	 <da1290fab3da0339a2f08dc320e297f9@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Feb 13 17:01:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgKQq-00019Y-EQ
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 17:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438Ab0BMQBP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 11:01:15 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:42053 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab0BMQBO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Feb 2010 11:01:14 -0500
Received: by ewy28 with SMTP id 28so2640546ewy.28
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 08:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XRIyfQQvGdkNsLB8PQ8LicmRpjPrAOmidCwDX2+slM0=;
        b=GhNAUmlxbQ4ntBMBBcZvxAdf7ARDhy6YygJ1LAIUF2BCCzXS2yjtaF8+aOniVlluEN
         NRh60hztJbe+96UcGVno4w7Nq/0Cve4+Da9uDfIwx56SpDgPSZdu4mwJDy/72aKzwIfz
         CSmDMKqolfyhY4gyByTdY608RL92dZc6UFaS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GduZ+5rgXxiUzKDaIW7Qres75p1frUdObVfUBztKsjboqd5IovMHvV0fEjzPADqWox
         yoplCx6TvCjEe7tCTLNBQdNgGLHKx5MtzCQYG2Sh4y0aaxbRY0Ljg3RMYkrQc5vVnfsX
         chJehxm2vlx0QA8dLllxx+zcuNq3hAOByrYXk=
Received: by 10.216.87.133 with SMTP id y5mr1820615wee.139.1266076873116; Sat, 
	13 Feb 2010 08:01:13 -0800 (PST)
In-Reply-To: <da1290fab3da0339a2f08dc320e297f9@212.159.54.234>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139808>

2010/2/13 Julian Phillips <julian@quantumfyre.co.uk>:
>> Personally, I would prefer if more colors were turned on by
>> default, or if there were a master setting to turn on all colors
>> at once.
>
> quoting man git-config:
>
> =C2=A0 =C2=A0 =C2=A0 color.ui
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 When set to always, always use col=
ors in all git commands which
> are
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capable of colored output. When fa=
lse (or never), never. When
> set
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to true or auto, use colors only w=
hen the output is to the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 terminal. When more specific varia=
bles of color.* are set, they
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 always take precedence over this s=
etting. Defaults to false.

Thanks!

I have learned a lot today.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
