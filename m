From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: windows smoke tester (was Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Fri, 13 Aug 2010 01:01:08 +0000
Message-ID: <AANLkTikuy3q8JrppTr+YPwZHFh2PNk+An2qvdoWiuAJH@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
	<AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>
	<AANLkTi=N-fA9r-Akm3_=ucFYew8BhcsQoWM-Z9S8+58C@mail.gmail.com>
	<AANLkTina+62MczLNhXC6VCtz_kQZ_t0+uZ8fH=vTV=XO@mail.gmail.com>
	<4C64308D.8030000@gmail.com>
	<AANLkTikh14FVmE6E78FNRvSG0B_5ZmNcOLSwye4ExNVx@mail.gmail.com>
	<4C647360.50304@gmail.com>
	<AANLkTimp5TSvjcmZG-pGtG6ep3axertqWuooS7e+A3Ow@mail.gmail.com>
	<4C647C85.2080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	kusmabite@gmail.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 03:01:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojie4-000823-0l
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 03:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab0HMBBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 21:01:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46100 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab0HMBBJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 21:01:09 -0400
Received: by gwb20 with SMTP id 20so679657gwb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ilyj2U3WSnQq8g62rWyzuAKC1vHokceCDDEx+5sQESg=;
        b=dKO2hnn86tvq6RmNv1scREKmnyFlDjwlHFv/z4mFMpTAOD7poWeOlxQ0ByhBeoj1Vi
         n8BT2wJXBtJs6YRyuHB6mPgzjTjlytdq2hEChfCtiPmEvGi5/UdaL7fb/mMoYz8OFK8f
         YJLAvpHiYZovN2TM3wXAWCPt26HCK4Mj0O/U8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QwYlAEJA38ty4gowbam5lx9HHKMfxJKivQbX8UxdcuFCYAWRjjr6W3C0TSzJzulrSX
         a8it/2FfsvNZtM1jbY2jxMVmylRMGfwHafoJGa5s0NGDUYbcx8s6/odb08jqdQdeGTrc
         evZZvkI13mhOAU9+7efjMBKFCB8KbxWNfcTW0=
Received: by 10.231.119.229 with SMTP id a37mr605172ibr.169.1281661268822;
 Thu, 12 Aug 2010 18:01:08 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Thu, 12 Aug 2010 18:01:08 -0700 (PDT)
In-Reply-To: <4C647C85.2080109@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153449>

On Thu, Aug 12, 2010 at 22:58, Chris Packham <judge.packham@gmail.com> =
wrote:
> On 12/08/10 15:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Aug 12, 2010 at 22:19, Chris Packham <judge.packham@gmail.co=
m> wrote:
>>> I checked out Avar's (Aevar?)
>>
>> Whatever works :)
>>
>>
>>> branch One problem is that I don't have any of the perl TAP
>>> modules. It's complaining about TAP/Harness/Archive.pm. Any
>>> suggestions for installing additional perl modules under msysgit?
>>
>> I don't know what msysgit does for perl but if you can make it use
>> strawberry perl's perl + modules that'd be easiest:
>>
>> =C2=A0 =C2=A0 http://strawberryperl.com
>
> I'll see if I can get it to work. Msys comes with its own perl so may=
be
> there is another way.

If it comes with its own perl it should also have a cpan shell:

    perl -MCPAN -e 'install TAP::Harness::Archive'

That should be easier than installing strawberry in addition to the
mingw perl.
