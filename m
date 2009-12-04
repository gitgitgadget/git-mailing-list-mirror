From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] reset: add --quiet option
Date: Fri, 4 Dec 2009 03:43:01 +0200
Message-ID: <94a0d4530912031743j360fc891m4093e92ecd9a66d5@mail.gmail.com>
References: <1259492290-21771-1-git-send-email-felipe.contreras@gmail.com>
	 <1259543939.5679.5.camel@swboyd-laptop>
	 <94a0d4530911300219j51e21e2cwae17d4248400a345@mail.gmail.com>
	 <780e0a6b0911301345v42c2b22bs34092fb69b21a2a0@mail.gmail.com>
	 <94a0d4530912030133n7e2fbf2asfea6e3896980dc7c@mail.gmail.com>
	 <7v7ht3zgaz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 02:43:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGNCW-0002U7-On
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 02:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbZLDBm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Dec 2009 20:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbZLDBmz
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 20:42:55 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:54622 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbZLDBmy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2009 20:42:54 -0500
Received: by iwn1 with SMTP id 1so1353092iwn.33
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 17:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6a/9qFY4tl/f7TIFcmRQaco+94/JeuZaiCs+113gKMU=;
        b=V/5pIUBOANk7uYBE8iodt8o59iQyLF3R6yqk8sfRyK4MXDlPSxn2Fs6E8L0rSuroqg
         EqcLkWn6/dPJxbIpSOx9z0xd00DKiegPFo14LVe7JF2N6wt9KxT5S6LBfQrpZG2aXAIr
         YF4h4TJuFygZ9kGPtEaASooi+po/sDNZyXtxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kCWHApl4s1h4QeK1f2EucCQdxk8G1p2gWmVwlYTxpO1ngxBufmcKm8eNoRwfG3tU6R
         kr6qPG8WAiY8hKrDtC3h2OPyWsbXGRxBvTxMM9moIe2U9MdSbFsc2AH1MqVxUj3hBP3V
         ohPFirKgTzQMInCCv67QJewNFHpQVE0LwSP4U=
Received: by 10.231.81.148 with SMTP id x20mr4855491ibk.2.1259890981196; Thu, 
	03 Dec 2009 17:43:01 -0800 (PST)
In-Reply-To: <7v7ht3zgaz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134488>

On Fri, Dec 4, 2009 at 3:19 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> Because the less trivial the patches, the less luck I have of gettin=
g
>> them applied :)
>
> Well, the name of the game is not "let me have more commits under my =
name
> in a well known project". =C2=A0It is "let's work together to make th=
e system
> better without stepping on each other's toes and without introducing
> unintended side effects".

Except that different people have different opinions about what's
"better", when it's OK to step on somebody else's toes,  and what's an
important side-effect.

> I actually do not think it is the complexity that matters. =C2=A0It l=
argely
> depends on what other patches are in flight that may have interaction=
s,
> and if the change is suitable for the phase of the cycle.

And whether or not you consider the change desirable at all.

--=20
=46elipe Contreras
