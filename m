From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: new platform & S_IFGITLINK problem
Date: Mon, 2 Aug 2010 16:26:40 +0000
Message-ID: <AANLkTim2X7w2dUrXXZUnXvYM8j-L2=O=Gn8a61ON=v=T@mail.gmail.com>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
	<7vfx2b2ft5.fsf@alter.siamese.dyndns.org>
	<1279815812.7796.5499.camel@jetpack.demon.co.uk>
	<7vwrsjcvx6.fsf@alter.siamese.dyndns.org>
	<1280080833.3622.4772.camel@jetpack.demon.co.uk>
	<AANLkTikcLk_W_guvBd3s15CY9xz6utmZASb67ndbt4=o@mail.gmail.com>
	<1280765681.15734.1202.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.co.uk>
X-From: git-owner@vger.kernel.org Mon Aug 02 18:26:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofxqi-00038M-Fa
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 18:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab0HBQ0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 12:26:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43601 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0HBQ0m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 12:26:42 -0400
Received: by gyg10 with SMTP id 10so1321372gyg.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6Rp9FGTl053AZ+ypyOH1vIhhksKwVawz0yT8fp9ZDFE=;
        b=qAEeUo/ud0NqAIJBe8FnJLukUmZLcCId9AQx1DPVjk1FMXbBKmrurY1G7zFhp8zKI4
         J0ZQnMsea9jZ739uEJED7j1c5+Bx13Dk9YxUh1UYU9lm8oOo2Nb/O8+/HuSB9OuBcdlk
         C2Vxv9bqSb0iKnuBm4kYz0GW5+2VKxEUaoLCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qnswPZgncAWQ6tEKAH+NqRGOOwV0oRLOwQQkq027eZ2bSEXIO7lxVmO2I7SWCzc1Ug
         o/JKszsAzI8lXxy2Itjf++xl7DvSeN9rBbaeE9tJlaJuemUJv1B9bCG+6bnkAZGf21wt
         50gZ7S0QAv8jwGp/CwdzTsu/KZrMTjrkligCY=
Received: by 10.151.116.2 with SMTP id t2mr6720457ybm.336.1280766400985; Mon, 
	02 Aug 2010 09:26:40 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 2 Aug 2010 09:26:40 -0700 (PDT)
In-Reply-To: <1280765681.15734.1202.camel@jetpack.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152422>

On Mon, Aug 2, 2010 at 16:14, Alan Hourihane <alanh@fairlite.co.uk> wro=
te:
> On Mon, 2010-08-02 at 16:11 +0000, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarm=
ason wrote:
>> On Sun, Jul 25, 2010 at 18:00, Alan Hourihane <alanh@fairlite.co.uk>=
 wrote:
>> > On Sun, 2010-07-25 at 10:29 -0700, Junio C Hamano wrote:
>> >> Alan Hourihane <alanh@fairlite.co.uk> writes:
>> >>
>> >> > Is there any ETA on fixing this up ?
>> >>
>> >> I don't think so, as I didn't see anybody who has a testable syst=
em
>> >> volunteered to do this nor heard that somebody started doing it.
>> >
>> > O.k. Looks like I'll have to take it on over the long term.
>>
>> I've been adding smoke support to Git so that you could set up a cro=
n
>> job that automatically sent us failure reports on your platform. The=
n
>> someone could fix this without your help.
>>
>> Here's the preliminary smoke patch:
>>
>> =C2=A0 =C2=A0 http://github.com/avar/git/compare/git:pu...git-smoke-=
v2
>>
>> Would you be willing to run a smoker on FreeMiNT?
>
> Sure. I'll give it a shot.

It'll be easier for you to wait until this gets merged into core and
we have some easy-to-setup scripts for starting smokers "out of the box=
".

But it's good to know that you're interested in running one.
