From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 02/73] gettext tests: add GETTEXT_POISON to simulate
 unfriendly translator
Date: Fri, 25 Feb 2011 20:50:05 +0100
Message-ID: <AANLkTimdNXFjDLhKqGidLeqgeRnKCcYcnfMwgcAkwP0m@mail.gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
	<1298418152-27789-3-git-send-email-avarab@gmail.com>
	<20110225070834.GB23037@elie>
	<7vvd08atnu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 21:00:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3qF-0003EZ-8r
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 21:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890Ab1BYUAi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 15:00:38 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63216 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932648Ab1BYUAh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 15:00:37 -0500
Received: by fxm17 with SMTP id 17so2022267fxm.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JE7zI/kdKJfjD7XPYZ2R+/OpOWXLN/6UOkiGP7C96Yw=;
        b=vZJgpu60FbbnPSCVrF41KmLcSVtnrJ7ynF2uj6nhHQvmIa4IJkBldg4QGKgi4i8XL0
         ubYAEAdD6GWwQ49v3mcC1DI1dsYGYipNEPzfbvdJcbkc5u19EcaBOfLPbo18GmoeQdTg
         jjhDtvaJBFD4TavX9tTnK7j2n5AKxjqBnFdZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u1cV0KmcXSVoWMHHi+2U9gJB7koGCGoBLm7smS53cPHFutZr4A69asVnjf3Fu4vzv4
         xJj8sxLzcC+k+udi2bdpfsAh1H8o7nrnE7Po/0THNCgGg5JtyJ2+x375EO3fRRobXDqP
         Ojaq1GycXmShvoglx1EanYGslpTpnEp9DWnAk=
Received: by 10.223.103.197 with SMTP id l5mr3191861fao.7.1298663405093; Fri,
 25 Feb 2011 11:50:05 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Fri, 25 Feb 2011 11:50:05 -0800 (PST)
In-Reply-To: <7vvd08atnu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167931>

On Fri, Feb 25, 2011 at 18:52, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> [offtopic: why is Jakub on the CC list? -- I don't recall him saying =
much
> on this topic yet...]

I see that I screwed up my J-completion. I meant to include Jonathan,
not Jakub. Oops. Sorry for the spam Jakub.

>> The idea of the GETTEXT_POISON facility is to simulate a worst-case
>> translation, so that strings marked for translation that cause troub=
le
>> can be noticed and dealt with.
>
> I've never thought this was about a "worst-case translation".
>
> Isn't this about emitting all the strings marked for translation in a=
 form
> significantly different from the original, in the hope that such an o=
utput
> would help us find messages that should never be marked for translati=
on by
> triggering test failures? =C2=A0I do not see any "worst-case", just d=
ifferent
> enough for the plumbing tests to break.
>
> IOW, I don't think this is about helping translators in l10n, but abo=
ut
> helping coders in i18n department.

Yes, exactly.
