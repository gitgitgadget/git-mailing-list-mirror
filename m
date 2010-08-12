From: Chris Packham <judge.packham@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 10:34:05 -0700
Message-ID: <4C64308D.8030000@gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>	<4C63BD9B.6000608@viscovery.net>	<AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>	<AANLkTi=N-fA9r-Akm3_=ucFYew8BhcsQoWM-Z9S8+58C@mail.gmail.com> <AANLkTina+62MczLNhXC6VCtz_kQZ_t0+uZ8fH=vTV=XO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 19:34:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjbfR-0007zp-Us
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 19:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757527Ab0HLReJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 13:34:09 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39981 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0HLReH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 13:34:07 -0400
Received: by pzk26 with SMTP id 26so522350pzk.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=EyI0SIML0QGt0YyfgmuGVo8B0mTzd84BxwIKhpihxyU=;
        b=AdXa9W0O5anr7yGxHFoSlDxaCQisRBoMw2E3u3A6HSnLCpVV6l2X/Yus0Byta/oeN9
         IPF/hPyy58fetARRMl32bb3O+yKMRRaX+FGspxrWZ8kDbgmqughYiSuMVECeaZP1itnF
         dDfb3Ui2KPHAwjdakeTM3+WCTibAJuDTOTJmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=BY8rjnCdW8R6QHzTnuXxjj1ATuubvWVYb6auvTg7iaSmtoEtaORADt0vBKwGolxfso
         uGZhQk/3K2v9R+1CB2YLbdvbwVLlxukcRoyjuW5MP2sZ9hkUejIBhlCPasH3NzVCIJl9
         UXIN7A52aQ7IjNu9TQIHojpphYzMTqDZlagbM=
Received: by 10.114.136.18 with SMTP id j18mr445745wad.99.1281634447130;
        Thu, 12 Aug 2010 10:34:07 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id n32sm2737411wag.11.2010.08.12.10.34.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 10:34:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <AANLkTina+62MczLNhXC6VCtz_kQZ_t0+uZ8fH=vTV=XO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153395>

On 12/08/10 09:50, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Aug 12, 2010 at 11:35, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>> On Thu, Aug 12, 2010 at 12:20 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason
>> <avarab@gmail.com> wrote:
>>> On Thu, Aug 12, 2010 at 09:23, Johannes Sixt <j.sixt@viscovery.net>=
 wrote:
>>>> [Sorry for the Cc spam; I lack the time to conduct individual mess=
ages.]
>>>>
>>>> I compiled many topics in pu and ran the test suite on Windows,
>>>
>>> A Windows smoker would be useful :)
>>>
>>
>> I guess I could look into setting one up. Where would I look for the
>> most up-to-date instructions on doing this?
>=20
> The smoke testing section in t/README in pu.
>=20
> Here's a small script I use to automate my smoke reports:
> http://github.com/avar/linode-etc/blob/master/bin/cron/build-and-inst=
all-git
>=20
> But it's crappy and incomplete, we/I still need to write something
> easy to set up that does automatic bisecting etc. on errors, tests
> multiple branches and all that good stuff.
>=20
> In the meantime smoking pu daily in cron should do.
>

I've got a spare windows box at work I could set something up on it.
I've never used msysgit or MinGW so I might need some instructions/link=
s
on that in addition to the smoker stuff.
