From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [msysGit] Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Mon, 21 Jan 2013 06:20:23 +0100
Message-ID: <50FCD017.6060607@web.de>
References: <50E9F7C2.1000603@gmail.com> <FBDECCA565D94DF9838DD81FE2E2543A@black> <7v1udxladc.fsf@alter.siamese.dyndns.org> <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com> <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk> <20130120101007.GD16339@elie.Belkin> <50FBCB95.6020201@web.de> <20130120110618.GF16339@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Stephen & Linda Smith <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>,
	msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 06:20:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx9oO-0003Nn-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 06:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757Ab3AUFU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 00:20:27 -0500
Received: from mout.web.de ([212.227.17.11]:64805 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699Ab3AUFU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 00:20:27 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0Lu4q2-1SwqYY1M2Q-011Lmc; Mon, 21 Jan 2013 06:20:25
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130120110618.GF16339@elie.Belkin>
X-Provags-ID: V02:K0:15XF1aVDVi5XgFYkkevgv7ykU7eSqoya5EYUFs3B/+O
 whrMF39yxJ2dymH7gFjwactEvYYB1cnGaR07wgA3TBDQImW3MQ
 G15U4oiMfRYGzbbnbFRbUD8/5nMUg+9UvyitSBxObxlyA23PKQ
 jh3DBH633QLqPVXSG04u87ObTNtxrbt/g+11XzPsFK+df/9J3d
 LUzO6RcfGvxLUnOImOMjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214080>

On 20.01.13 12:06, Jonathan Nieder wrote:
> Torsten B=F6gershausen wrote:
>=20
>> I wonder, if if we can go one step further:
>>
>> Replace
>> #ifdef WIN32 /* Both MinGW and MSVC */
> [...]
>> with
>> #if defined(_MSC_VER)
>=20
> I thought Git for Windows was built using mingw, which doesn't define
> _MSC_VER?
>=20
> Puzzled,
> Jonathan
>=20
Yes,
After removing these lines in the git-compat-util.h of msysgit
v1.8.1 it still compiled.
So I start to speculate if the comment is still valid for mingw,
or if that was true in the old days and not now any more.

More investigation is needed, sorry for confusion.
/Torsten
