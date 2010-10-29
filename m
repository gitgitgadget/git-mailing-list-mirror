From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: Add a section on writing documentation
Date: Fri, 29 Oct 2010 10:14:20 -0700
Message-ID: <AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
References: <20101021222129.GA13262@burratino> <20101024155121.GA9503@headley>
 <AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com> <87wrp12p00.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 19:14:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBsXO-0005Vd-Cl
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 19:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934163Ab0J2ROm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 13:14:42 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56206 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932342Ab0J2ROk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Oct 2010 13:14:40 -0400
Received: by ywk9 with SMTP id 9so2132632ywk.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4VJyQg3Ws5XbvAClpt7pnATkKDxpyQ1eaxpubyKHdVY=;
        b=rLgtU8akyzNa4spRCfukpBQC3C9z7tH7kzPmkKBYNHg7j8R9aMgCk+tb4aN6230izh
         I+GGr0MkruVkyqKlbd6QFhlnlh5B7XqhmZuv1vkKUyszBmNb1dIvGF4RONZ+p51uZKrZ
         RI6oPWJndJMYkry1AVeCfllJGHjAjDz1TRxmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IQXlGyRa7kWPDqsaRu7+6anfzCxlZk+4PDsegu9l4jeOn5U0Ri66Ol+DB76q7FjaBy
         IZuaj38GOOOoKKcOAopFAUb6prewVhHH1+NCs8LZbabHehn/P0rWbLUGa7Kci635bf1p
         4CCFq0X6grar/KZEOx5x23XIav38lsU+hwbj8=
Received: by 10.151.103.14 with SMTP id f14mr8268323ybm.319.1288372480243;
 Fri, 29 Oct 2010 10:14:40 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Fri, 29 Oct 2010 10:14:20 -0700 (PDT)
In-Reply-To: <87wrp12p00.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160345>

Heya,

On Fri, Oct 29, 2010 at 04:54, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepne=
m@gmail.com> wrote:
> But given that it's only used as {0,2} at the two places right now
> (disregarding occurences of "0{40}" in the documentation), I agree it
> might be better to get rid of it, although I don't feel strongly abou=
t
> it. Any other opinions?

Let's get rid of it for now, we can always resurrect it later if we
have a need for it.

> I thought about this already when preparing the recent unification
> series, and came to the conclusion "no, there shouldn't". :-) As the
> examples you give show, the current usage is inconsistent, but given
> that it brings no semantic ambiguity, I don't think it is a problem. =
You
> could find more similar cosmetic inconsistencies and I don't think it
> makes much sense to mandate any rules for such things. (But again, I
> don't feel _too_ strongly about this either, so if more people think
> it's worth it, I can prepare a patch that unifies them and mention th=
e
> preference in CodingGuidelines.)

Perhaps we can set a standard to do it, but just leave the existing
cases as is (to prevent unneeded churn)? That way we'll eventually
converge on something.

--=20
Cheers,

Sverre Rabbelier
