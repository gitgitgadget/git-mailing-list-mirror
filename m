From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 15/17] po/is.po: add Icelandic translation
Date: Tue, 31 Aug 2010 21:14:37 +0200
Message-ID: <AANLkTimGSEVLOjTLt2yntXaDfyUkj=mY46evfRx517MC@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-16-git-send-email-avarab@gmail.com> <20100831152959.GH2315@burratino>
 <AANLkTimYETJcHuKBBRKJ0zbkRBR-K2VAXRLizFQxa-pr@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:15:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWIS-0000vL-0j
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab0HaTO7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 15:14:59 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49410 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab0HaTO6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 15:14:58 -0400
Received: by vws3 with SMTP id 3so5670408vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=GH/lImdlWCgRChLO2ZnPASXS7rQpjxNYmolUT/IG4rg=;
        b=PpvYoBFBDm1PQTKIbSSX1y4WPfB3qHUVzsgM78Oglwa+y08Kw71/y/0oDCfaWWrvVr
         xtS8j6K4AKKYGgUI14qM7QxTC1H9v3QDR4I1dBLb+LayiieO75e5Psxl6GV+7F6DzAIM
         eeSIPileEr+ocJ0ahWSFAOo7NsCeG3dwUUDzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=L1sGP3hlhKbX95OvEPjxPCd2Y1fDCCjgj8eXopARQO9MCycya4sFN9/RRvd4WeQS/L
         bRdYsbe1Teqy/wZxAv1a5tMGXvLZMb26514fjklXLk71PGwzlyA4i0t7SnR4hDYVSygy
         /tm0+xpzEmf132iG8mZdUeauHTkTjalFclH7k=
Received: by 10.220.158.9 with SMTP id d9mr3574764vcx.245.1283282097505; Tue,
 31 Aug 2010 12:14:57 -0700 (PDT)
Received: by 10.220.180.76 with HTTP; Tue, 31 Aug 2010 12:14:37 -0700 (PDT)
In-Reply-To: <AANLkTimYETJcHuKBBRKJ0zbkRBR-K2VAXRLizFQxa-pr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154966>

On Tue, Aug 31, 2010 at 7:01 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Aug 31, 2010 at 15:29, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> =C6var Arnfj=F6r=F0 Bjarmason wrote:
>>
>>> --- a/po/is.po
>>> +++ b/po/is.po
>>> @@ -11,35 +11,154 @@ msgstr ""
>>> =A0"Content-Type: text/plain; charset=3DUTF-8\n"
>>> =A0"Content-Transfer-Encoding: 8bit\n"
>>>
>>> -#: t/t0200/test.c:4
>>> +#: builtin/init-db.c:34
>>
>> Is there a diff driver that will ignore these --add-location lines?
>>
>> Alternatively, would it be possible to get msgmerge and xgettext to
>> provide the filenames without the line numbers? =A0My experience is
>> that most translation diffs are very hard to read because about 80%
>> noise. :(
>>
>> Aside from that, this looks good and sane (well, the English part
>> I can read does).
>
> Some context, an earlier discussion on this:
> http://kerneltrap.org/mailarchive/git/2010/5/30/31415/thread#mid-3141=
5
>

msgmerge and xgettext does seem to have the --no-location flag to
avoid these annotations from being generated. The documentation does
say "Note that using this option makes it harder for technically
skilled translators to understand each message's context. ", though.
But perhaps the annotated versions could be generated when needed and
never checked-in (similar to what you suggested in that e-mail)? It
sounds to me like that would give us the best of all worlds. If it's
possible, that is.
