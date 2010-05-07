From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Fri, 7 May 2010 20:29:27 +0200
Message-ID: <AANLkTilp0d28QMs_K7cVrfqmkzeqs8FTJbU1oeuUy7V6@mail.gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
	 <1273180440-8641-1-git-send-email-avarab@gmail.com>
	 <AANLkTik6z4cvUzjfq-q61tgk_MhqWKc_A55i3VauPSQC@mail.gmail.com>
	 <AANLkTinhh8TXY9r9Jf394YKYXDxpU65qjg7MbPcb12Ls@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 20:29:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OASIs-0003Un-Kh
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 20:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597Ab0EGS33 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 14:29:29 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57244 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757530Ab0EGS32 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 14:29:28 -0400
Received: by gwj19 with SMTP id 19so806268gwj.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gtZrW2p8dCBXMSL7IGjMZwAEZp9BjSEW22c2PhfGdF0=;
        b=SvI74MCAcdOX9Q9mhI9WwqxfjaxanqJ9om8UlENmMGjdl0aRmcGwzvYUVh0kv/BVdG
         qmQF6oh87k7HEZY8ubMAiLo8gSQSMtvFsLTqFZJAsNRYuKgEN20DV8MSVepS92kbt2Av
         ouAK7cNL/wBBcN4KXkIRAArv0/V6HXt9U4XPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wknbvi+/mCWuxyUkk5RlJYY2DTv6X4VhX6iRtDlcrJk7AcX8ODeuW7U5Ms7kf2SrCM
         EA7RuxO0vaCsJQ58aU6e++Jdu6NfUdsxcBT8w5EkJH82JM39EE6ukxofkA0flAHzkKWX
         pHWJGZej3VUB3QYOFAMnVBLiiCeY9oZDXDZ+I=
Received: by 10.231.168.9 with SMTP id s9mr263294iby.7.1273256967608; Fri, 07 
	May 2010 11:29:27 -0700 (PDT)
Received: by 10.231.39.205 with HTTP; Fri, 7 May 2010 11:29:27 -0700 (PDT)
In-Reply-To: <AANLkTinhh8TXY9r9Jf394YKYXDxpU65qjg7MbPcb12Ls@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146549>

On Fri, May 7, 2010 at 18:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On Fri, May 7, 2010 at 06:00, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
>> On Thu, May 6, 2010 at 23:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>>>
>>> Not-signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>
>>
>> So you don't agree to the Developer's Certificate of Origin, don't y=
ou?
>
> Signed-off-by is for "if you want your work included in git.git"
> (according to Documentation/SubmittingPatches). I don't think this
> patch is ready for inclusion as-is, but I wanted to solicit comments
> on the general approach.
>

Can you please quote SubmittingPatches for your argumentation.

I think you mix technical and legal aspects of submitting patches.

Thank you and please note I'm not a lawyer.

Bert
