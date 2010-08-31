From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 15/17] po/is.po: add Icelandic translation
Date: Tue, 31 Aug 2010 17:01:40 +0000
Message-ID: <AANLkTimYETJcHuKBBRKJ0zbkRBR-K2VAXRLizFQxa-pr@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<1283203703-26923-16-git-send-email-avarab@gmail.com>
	<20100831152959.GH2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 19:01:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqUDU-0002tl-6c
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 19:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab0HaRBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 13:01:42 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42870 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab0HaRBm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 13:01:42 -0400
Received: by gxk23 with SMTP id 23so2618535gxk.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ty0jKpYNXNpS93MDIe7/R5+dZjy8dG3sT3Avkyio9A8=;
        b=NgLWoT1A4Gty2HNH636JW1wIEIonJFVo4xQ8gbLrD0qef4IWLPBuNfxFeXXEpkIn2Y
         D/bmSeKP25QGVkSeqtgZR4eRRCTrc4oCrVR0Imfg0TXGYMuBXKOnhseKkgrpu0Izykmd
         i7T+KfEhNQ0RYQi8QrO1YH7K3rpeM54AYWCMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SI0VycoIbrwjbe0/D+RYrOx4Fu5mqHHBmpuA8nh7/NbPf6zppdy3pXbuefrckacHM+
         sRFPx5vvSzeF/FZM8ep+9OpXmLZv+tjzg7BxpysjYAlABMeHZ0B77d8hLfguHCA0pI0k
         taZgdEkVM+c/66r50a/EUWC5uqQYaziN6IgLg=
Received: by 10.101.148.37 with SMTP id a37mr6860141ano.210.1283274101299;
 Tue, 31 Aug 2010 10:01:41 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 31 Aug 2010 10:01:40 -0700 (PDT)
In-Reply-To: <20100831152959.GH2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154940>

On Tue, Aug 31, 2010 at 15:29, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> --- a/po/is.po
>> +++ b/po/is.po
>> @@ -11,35 +11,154 @@ msgstr ""
>> =C2=A0"Content-Type: text/plain; charset=3DUTF-8\n"
>> =C2=A0"Content-Transfer-Encoding: 8bit\n"
>>
>> -#: t/t0200/test.c:4
>> +#: builtin/init-db.c:34
>
> Is there a diff driver that will ignore these --add-location lines?
>
> Alternatively, would it be possible to get msgmerge and xgettext to
> provide the filenames without the line numbers? =C2=A0My experience i=
s
> that most translation diffs are very hard to read because about 80%
> noise. :(
>
> Aside from that, this looks good and sane (well, the English part
> I can read does).

Some context, an earlier discussion on this:
http://kerneltrap.org/mailarchive/git/2010/5/30/31415/thread#mid-31415

Removing them will have some negative effects. Gettext uses them for
its message fuzzying logic, and they enable you to jump directly to a
source definition.

I've found that it's easier to just go with the flow as far as the
gettext tools are concerned, and they seem to really like to have
these line numbers in :)
