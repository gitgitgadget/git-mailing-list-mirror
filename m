From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 04/15] Makefile: "pot" target to extract messages marked
 for translation
Date: Mon, 21 Feb 2011 14:14:44 +0100
Message-ID: <AANLkTi=1DK8TCMjXXgM4dMiyqcxuoK9Vhc_98AL+RfxO@mail.gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
	<20110221040012.GB26968@elie>
	<20110221101229.GA32137@elie>
	<20110221101530.GE32137@elie>
	<AANLkTi=ewuq=QS=MTyOF95FUBJNoQ=f2CY53GEZOVOAL@mail.gmail.com>
	<20110221130525.GB18427@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 14:15:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrVbb-0003qp-O7
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 14:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab1BUNPF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 08:15:05 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35437 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab1BUNPD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 08:15:03 -0500
Received: by fxm17 with SMTP id 17so1448832fxm.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 05:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p/VAKCj3NRXxiGWyJEhGzWN7sFuUjQs3fkyhaDmkOTI=;
        b=awtBvDx1p0Ta7hQ8SoKZcGd+H6pCGFoP2DyOTA+J0yVWCltMt2AmtPQpYrOes4voJm
         oDuRbVbLzKlWIabcIcl4yZajHE94Efo+1a0B5Dyk49qezefwgxE7Cqo5kNcOhVdOdLOv
         F8g/nG+F/ub1ytaJ/DnCkBwkF5w4knqmj3Aog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T91yVuIhoszHmHEry/NXSpEPv0qIDfxNFXEqSPk13iCZ3BS5ozJ0B4qA+2XC8wGM0m
         DevLL/oaK5xa3tuZW8KItIUDZtgo2M62Vt7d/ElK5L5Z7PnLJqJUy+SnSO5YXCU5U6Km
         jycB+7juAI32Z2xMHBkN0TPGggwpha2vNTGGw=
Received: by 10.223.95.203 with SMTP id e11mr1831415fan.60.1298294084104; Mon,
 21 Feb 2011 05:14:44 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Mon, 21 Feb 2011 05:14:44 -0800 (PST)
In-Reply-To: <20110221130525.GB18427@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167482>

On Mon, Feb 21, 2011 at 14:05, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Feb 21, 2011 at 11:15, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>
>>> Add rules to generate a template (po/git.pot) listing messages mark=
ed
>>> for translation in the C portion of git.
>>
>> Can we please not apply this?
>
> I included it in the series because I used it to test, for what it's
> worth.
>
> I also think it could be useful to translators, so they could work
> against git.git directly once it has enough translatable strings.
> That sounds valuable to me.

Yeah it's valuable, but I'm just optimizing this for the time I can
spent on it, I already have a patch series that has these things. It's
much easier if I can:

 1. Apply C translations
 2. Apply Shell translations
 3. Apply Translation documentation / po/* stuff

Then later:

 4. Add actual gettext support

But not have to deal with bits of #3 while I do #1 and #2. That's all.

Since hopefully we'll get to #3 relatively quickly I think that's OK.
