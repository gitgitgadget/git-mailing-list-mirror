From: Chris Packham <judge.packham@gmail.com>
Subject: Re: windows smoke tester (was Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Thu, 12 Aug 2010 15:58:13 -0700
Message-ID: <4C647C85.2080109@gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>	<4C63BD9B.6000608@viscovery.net>	<AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>	<AANLkTi=N-fA9r-Akm3_=ucFYew8BhcsQoWM-Z9S8+58C@mail.gmail.com>	<AANLkTina+62MczLNhXC6VCtz_kQZ_t0+uZ8fH=vTV=XO@mail.gmail.com>	<4C64308D.8030000@gmail.com>	<AANLkTikh14FVmE6E78FNRvSG0B_5ZmNcOLSwye4ExNVx@mail.gmail.com>	<4C647360.50304@gmail.com> <AANLkTimp5TSvjcmZG-pGtG6ep3axertqWuooS7e+A3Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	kusmabite@gmail.com
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:58:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojgj9-0003qu-RE
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760990Ab0HLW6R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 18:58:17 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:39951 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760947Ab0HLW6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 18:58:16 -0400
Received: by pxi10 with SMTP id 10so612634pxi.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=xtea4S1VNdp6C5B4Sp9gh+67jYSabek5Fe7nQO5w+dU=;
        b=VNMk4+gokyRobOB6nXIzn0DHD46P5sFWad1/irX9slp55cgDpe8u+QqeZOC5bmgjDf
         5OSpzKRqGEki3ZrTLphpk7+Lj6+Cwy9wjJxj4YFQRdsVqdX3B5qf2pWidFfKjXzbx/qK
         c9B41Rxexpbf58geq3eDn3fRSYo4c18t6u00c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KBYTQfgfm62sD8Hrd/el1I1EHlyajq8xisJ5855Uaaf21iUTHkaO94oJtnA6l4hv/w
         AAmg2Qu9ohWO80laRk2NBIKSxH/WjvA3JbYlTIMspWoivhR6xy33ke0AOyKEsiKo2h22
         6mT/1JHIzAAq70VPI2+ORqSA5dQhlIO5wp30U=
Received: by 10.114.58.11 with SMTP id g11mr868278waa.14.1281653895483;
        Thu, 12 Aug 2010 15:58:15 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d39sm3220986wam.16.2010.08.12.15.58.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 15:58:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <AANLkTimp5TSvjcmZG-pGtG6ep3axertqWuooS7e+A3Ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153440>

On 12/08/10 15:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Aug 12, 2010 at 22:19, Chris Packham <judge.packham@gmail.com=
> wrote:
>> I checked out Avar's (Aevar?)
>=20
> Whatever works :)
>=20
>=20
>> branch One problem is that I don't have any of the perl TAP
>> modules. It's complaining about TAP/Harness/Archive.pm. Any
>> suggestions for installing additional perl modules under msysgit?
>=20
> I don't know what msysgit does for perl but if you can make it use
> strawberry perl's perl + modules that'd be easiest:
>=20
>     http://strawberryperl.com

I'll see if I can get it to work. Msys comes with its own perl so maybe
there is another way.

> It comes with an easy-to use CPAN shell out of the box.
>=20
>> Another problem is that the mingw sh.exe is _really_ slow (the box i=
s an
>> oldish Dell Latitude).
>=20
> Odd that sh.exe is the slowest bit.

I'm probably pointing the finger at sh.exe but it is more that somethin=
g
else it is doing is slowing things down (probably the fancy PS1 setting=
).

> One thing (as the t/README notes) that'll make the tests much faster
> is using a ramdisk for the trash directory, but I don't know if
> Windows can do that.

I doubt windows has the capability (heck they've only had 3 file system=
s
in the last 20 years).
