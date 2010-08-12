From: Chris Packham <judge.packham@gmail.com>
Subject: windows smoke tester (was Re: What's cooking in git.git (Aug 2010,
 #02; Wed, 11))
Date: Thu, 12 Aug 2010 15:19:12 -0700
Message-ID: <4C647360.50304@gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>	<4C63BD9B.6000608@viscovery.net>	<AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>	<AANLkTi=N-fA9r-Akm3_=ucFYew8BhcsQoWM-Z9S8+58C@mail.gmail.com>	<AANLkTina+62MczLNhXC6VCtz_kQZ_t0+uZ8fH=vTV=XO@mail.gmail.com>	<4C64308D.8030000@gmail.com> <AANLkTikh14FVmE6E78FNRvSG0B_5ZmNcOLSwye4ExNVx@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Aug 13 00:19:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojg7V-0004Vk-Me
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab0HLWTP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 18:19:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52475 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab0HLWTN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 18:19:13 -0400
Received: by pzk26 with SMTP id 26so600331pzk.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=haQCGNDBa7ALDBwd7RZ7ssIwMMfrMUqMRx3bthx5Wq0=;
        b=uf/k7kftw1WF/Hw5ZO2YcSwarM1/4K3TK/bp8Q6l2HwCNuykJhZpY0Zy5o7sXG73aB
         DzBLiIy58Nzoq9dSUPE6+Ho8wHZecP5+dHTE2VmR91NWKzMRHHp33LwHM6E76wZfbPKb
         HiCxs7MeO+zldkFo3V7oUaOhNsX/z8Xyc2P7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=X0CQDhWr6jDkqksKHTD2fAVTneaJEiTAoZc/hjAmQOEIHFZBbLjvu8IFa6bnhKWcd7
         bzb78y0AFsBV0G9mb88x5D5dMPoigsrPJvhLvOmkCXLWtk3T/s7OrCMU8Dsb0Hrf6G3t
         b16x+EIDbYU4dISjbWBDSlQuL75KWrj8oAR+Q=
Received: by 10.114.24.3 with SMTP id 3mr769803wax.177.1281651553004;
        Thu, 12 Aug 2010 15:19:13 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id 33sm3159648wad.18.2010.08.12.15.19.11
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 15:19:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <AANLkTikh14FVmE6E78FNRvSG0B_5ZmNcOLSwye4ExNVx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153431>

On 12/08/10 11:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Aug 12, 2010 at 17:34, Chris Packham <judge.packham@gmail.com=
> wrote:
>=20
>> I've got a spare windows box at work I could set something up on it.
>> I've never used msysgit or MinGW so I might need some instructions/l=
inks
>> on that in addition to the smoker stuff.
>=20
> I won't be able to help you there, sorry. I know Windows about as wel=
l
> as IBM z/OS, which is to say not at all :)

I've got msysgit installed now via the net installer. I checked out
Avar's (Aevar?) branch One problem is that I don't have any of the perl
TAP modules. It's complaining about TAP/Harness/Archive.pm. Any
suggestions for installing additional perl modules under msysgit?

Another problem is that the mingw sh.exe is _really_ slow (the box is a=
n
oldish Dell Latitude). It took a while for the net installer to run and
compile the devel branch but it got there eventually. It's not a huge
issue for me as the box is sitting idle but any suggestions for making
it run a bit smoother are welcome.
