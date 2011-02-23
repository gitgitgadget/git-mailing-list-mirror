From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 00/73] No-op gettextize core Git C programs
Date: Wed, 23 Feb 2011 19:30:01 +0100
Message-ID: <AANLkTinRfACQuCki=QJh4dczoMK8+8bdwLjg6atL4UBT@mail.gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
	<1298418152-27789-1-git-send-email-avarab@gmail.com>
	<7v1v2zbmn9.fsf@alter.siamese.dyndns.org>
	<7vwrkra5un.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 19:42:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsJf8-00036m-BY
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 19:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479Ab1BWSmE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 13:42:04 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55554 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab1BWSmD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 13:42:03 -0500
Received: by fxm17 with SMTP id 17so4316213fxm.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 10:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xm1N7dfZ55P4+UQ7zIIvxvPJwVwq9mq23BB/BV6zp98=;
        b=kwzgFvmF09E6thePusBXC1jSg8pik4lUhFOfMg8ZypmFNPo8DbENcQo6UAieBLzuqV
         P5m/Fzx4pI9pmQlTkif4rHjz51jPIvi0jSl/hBGsWssseXS1eoyhdDOpbEP1qjhYqBqC
         NI/sHV6tHj2RGd5JJmB/llLaFH3syTLbhacXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CG4qhIhXWnSM3VW7u4b2J5y4FSAuqZaKJzNm0s+yPQuL2vhBN0wqtm+lWXX24AKMQs
         Mt0SoLKGZB/vjTWdmpn+kjA8eVxI2ZZXmdgA1BolB2bk2Zpmch8hvhoKgIKcGUcKH2Ed
         8m6d0hcuLFstcvzPpzOqifUEPbc17pUmDkhSs=
Received: by 10.223.54.132 with SMTP id q4mr3375545fag.117.1298485801871; Wed,
 23 Feb 2011 10:30:01 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Wed, 23 Feb 2011 10:30:01 -0800 (PST)
In-Reply-To: <7vwrkra5un.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167709>

On Wed, Feb 23, 2011 at 02:37, Junio C Hamano <gitster@pobox.com> wrote=
:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> =C2=A0 * Reverted back to using the "gettextize" patch subjects I
>>> =C2=A0 =C2=A0 originally used. I'm using these consistetly so I can=
 later git
>>> =C2=A0 =C2=A0 log --grep=3Dgettextize: to find them. I'd like to pr=
eserve that
>>> =C2=A0 =C2=A0 attributed.
>>
>> Can we make that shorter, perhaps just "i18n:"? =C2=A0In this series=
, your
>> first three and Jonathan's are oddballs that do not have "gettexize:=
"
>> anyway.
>>
>> Will give it a whirl. =C2=A0Thanks.
>
> It was a slightly unpleasant experience to merge this round to 'pu' (=
after
> excluding the earlier round from it, of course), as a few topics in f=
light
> that reorganized existing functions into smaller helpers had to confl=
ict
> with this patch. =C2=A0I tried to be careful but please double check =
the result,
> perhaps with:
>
> =C2=A0 =C2=A0$ git show --first-parent origin/pu
>
> when it is propagated to mirrors.

I've gone over the version in pu. It looks good to me.
