From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] Documentation: update-index: -z applies also to --index-info
Date: Thu, 07 Oct 2010 21:27:12 +0200
Message-ID: <87sk0hu7lb.fsf@gmail.com>
References: <d3f7e6795adeccbf7746547842d6b65732d568eb.1286457739.git.bert.wesarg@googlemail.com>
	<87wrptua21.fsf@gmail.com>
	<AANLkTimsJ+uG7KhiBMii8szFYmbXo5OjAkYgs99_Hjzr@mail.gmail.com>
	<AANLkTikiOmM0q=XoAJ0nOnr6SChj7PZZJfmXzaihGZMu@mail.gmail.com>
	<20101007191548.GA11955@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 21:28:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3w8c-0002c4-E9
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab0JGT2Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 15:28:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63550 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab0JGT2P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 15:28:15 -0400
Received: by fxm14 with SMTP id 14so33253fxm.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=IGn4zsXvvom2k/m6cOg7zr2uWCS294rcUqIv1OpSiEc=;
        b=QjhRFZ8x0vt1LNmomn0yQjAizOO0kqaYXWQerJ7ohRtyVGj8DV0PrRXlVOYH5VahRL
         M2nm4x+aehIJptIbswpucPTQxb8j1Y/EXatSaOGA4AfVgKaG2N/R9lScqLmcHIdpIH0y
         ylSaeVQr1I66LJrOG78uhTpKUcTpoi4RyKdjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=ve8hkFbyihV2ix3DVfvblRBDPp5xyRqnSrtFf5BeYtDLPXNv3nIDhC3o5F5AbJ5TT1
         DFwcRxOXygkkeOoizp2Vyipm2vM/TEBckJH+3ndFdUgCcqWsHJLVG2bKRBOq0Uyeh+CU
         BQ23iYvvShg6/Y4YLhrBeKIasn+pUZ0QSL4Uc=
Received: by 10.102.253.8 with SMTP id a8mr186402mui.3.1286479694180;
        Thu, 07 Oct 2010 12:28:14 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id c40sm655804fay.2.2010.10.07.12.28.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 12:28:13 -0700 (PDT)
In-Reply-To: <20101007191548.GA11955@burratino> (Jonathan Nieder's message of
	"Thu, 7 Oct 2010 14:15:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158445>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Bert Wesarg wrote:
>> On Thu, Oct 7, 2010 at 20:52, Bert Wesarg <bert.wesarg@googlemail.co=
m>
> wrote:
>>> On Thu, Oct 7, 2010 at 20:33, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <ste=
pnem@gmail.com> wrote:
>
>>>> There is actually at least one more problem with the current SYNOP=
SIS of
>>>> `update-index'. Obviously the `*' on the third line of the Asciido=
c
>>>> source makes the whole `--cacheinfo' line disappear and the rest b=
old
>>>> (cf. e.g. the result at
>>>> <http://www.kernel.org/pub/software/scm/git/docs/git-update-index.=
html>).
>>
>> ls-files too:
>> http://www.kernel.org/pub/software/scm/git/docs/git-ls-files.html
>
> Hmph, this is from v1.7.3-rc0~15^2~9 (Documentation: remove backslash=
es
> in manpage synopses, 2010-08-20).  And it still works for me locally
> (for both manpage and HTML generation). :(
>
> Anyway, the "..." fix sounds good to me (or {asterisk} if the stars a=
re
> still wanted).

Yeah, there are some more actually. I'll send in a separate patch short=
ly.

=C5=A0t=C4=9Bp=C3=A1n
