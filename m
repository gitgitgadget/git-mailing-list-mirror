From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: Add a section on writing documentation
Date: Mon, 01 Nov 2010 18:00:02 +0100
Message-ID: <87fwvl2d4d.fsf@gmail.com>
References: <20101021222129.GA13262@burratino> <20101024155121.GA9503@headley>
	<AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
	<87wrp12p00.fsf@gmail.com>
	<AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 18:01:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCxlH-0004px-4Q
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 18:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab0KARBa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 13:01:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48265 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab0KARB2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Nov 2010 13:01:28 -0400
Received: by fxm16 with SMTP id 16so5057558fxm.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=ozLOKe6IPzEFLMI7iQHQmgdGM301SZQfnDjXGZ+wy74=;
        b=SZ3YIxAJ4QoTA8ND5cfZSrjizOx5cXJV5oVCYywL91kNOL25++YKJXsM1plL3o/q2Q
         86M/ze1Px8sQoiXz07Tc5OIl4iqM37I7B4ilc6qwX+xJoH/hA4EEOe2euucXEqPVnU1B
         U1tGpxg9QUzzybdhNmSOo/T9s79DMRZu7lBbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=KrM7VEG46fwj0yhlofRFxAiMwr6ntv8dU3kQUANGLFajObi2njSA3zqSHm7cRs0hbB
         ZQjZBntQIpbt5kh2zHFGWWXivteoHZW4NLLYP+XhXO4UpYLsvoG+IsM5Ml+3i3iLZXB1
         Cm8RR7bHcNKC7qYv/U5Wk3ggpAsx+SLw/+ZL0=
Received: by 10.223.101.206 with SMTP id d14mr7736066fao.128.1288630887635;
        Mon, 01 Nov 2010 10:01:27 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id c25sm2546328fac.9.2010.11.01.10.01.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 10:01:25 -0700 (PDT)
In-Reply-To: <AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
	(Sverre Rabbelier's message of "Fri, 29 Oct 2010 10:14:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160485>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Fri, Oct 29, 2010 at 04:54, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <step=
nem@gmail.com> wrote:
>> But given that it's only used as {0,2} at the two places right now
>> (disregarding occurences of "0{40}" in the documentation), I agree i=
t
>> might be better to get rid of it, although I don't feel strongly abo=
ut
>> it. Any other opinions?
>
> Let's get rid of it for now, we can always resurrect it later if we
> have a need for it.

OK.

>> I thought about this already when preparing the recent unification
>> series, and came to the conclusion "no, there shouldn't". :-) As the
>> examples you give show, the current usage is inconsistent, but given
>> that it brings no semantic ambiguity, I don't think it is a problem.=
 You
>> could find more similar cosmetic inconsistencies and I don't think i=
t
>> makes much sense to mandate any rules for such things. (But again, I
>> don't feel _too_ strongly about this either, so if more people think
>> it's worth it, I can prepare a patch that unifies them and mention t=
he
>> preference in CodingGuidelines.)
>
> Perhaps we can set a standard to do it, but just leave the existing
> cases as is (to prevent unneeded churn)? That way we'll eventually
> converge on something.

Hm... that seems like the worst solution to me -- if we do end up
standardizing this after all, any occurence of non-standard usage would
be a bug that needs fixing (think about it from the POV of a new
contributor who reads CodingGuidelines but sees the actual usage being
different).

I guess it wouldn't be so much of a code churn to unify the spacing, bu=
t
I'm still not convinced we should be enforcing this kind of thing.

=C5=A0t=C4=9Bp=C3=A1n
