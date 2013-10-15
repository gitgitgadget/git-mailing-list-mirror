From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] clone: local URLs are not for ssh
Date: Tue, 15 Oct 2013 09:22:46 +0200
Message-ID: <525CED46.3050006@web.de>
References: <201309282137.21802.tboegi@web.de> <CACsJy8B-wA=bX6+E6O6UvX2vEtOwnR1PCMZNoi-q0x_jacB89Q@mail.gmail.com> <524C6885.8020602@web.de> <CACsJy8DjPiwpMvLe2p+dGBdpU6iTg2my7tddBsQwLnHiHdG8wQ@mail.gmail.com> <20131003013127.GA7917@sigill.intra.peff.net> <52506D15.9040206@web.de> <525AFBCC.4080303@web.de> <20131015001259.GB10415@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 15 09:23:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVyyA-0003NY-5j
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 09:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684Ab3JOHW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 03:22:56 -0400
Received: from mout-xforward.web.de ([82.165.159.4]:53117 "EHLO
	mout-xforward.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab3JOHWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 03:22:55 -0400
Received: from [192.168.209.20] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MGzWU-1VauvX1Jas-00DqRx for <git@vger.kernel.org>;
 Tue, 15 Oct 2013 09:22:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <20131015001259.GB10415@sigill.intra.peff.net>
X-Provags-ID: V03:K0:mjLhvjW1DGrOcDI2j3JKX6w6qoXCTRJqz2E0jM5jnT/jXsR4Fo1
 XurxPxNjJ2DA67hWAMdsqgHNPP6HKd9eM4NZplJhpCfVEQhLoMoqS59yeAOPsATx0VHRT3v
 956oJnWAePmaz04YuQYek3FVHEaeGtpdp2/YjPhalPjTCFrsYnp5FLSFaTCVWbMHK8qZWO5
 UtLZmwol+O18yQfwl1O8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236168>

On 15.10.13 02:12, Jeff King wrote:
> On Sun, Oct 13, 2013 at 10:00:12PM +0200, Torsten B=C3=B6gershausen w=
rote:
>=20
>> On 05.10.13 21:48, Torsten B=C3=B6gershausen wrote:
>>> On 2013-10-03 03.31, Jeff King wrote:
>>>>
>>>>   http://article.gmane.org/gmane.comp.version-control.git/235473
>> What do we think about extending the test a little bit:
>=20
> I never mind more tests, but note that my tests are now part of Duy's
> 8d3d28f, so you would want to build on top.
>=20
>> diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exe=
c.sh
>> index 3f353d9..790896f 100755
>> --- a/t/t5602-clone-remote-exec.sh
>> +++ b/t/t5602-clone-remote-exec.sh
>=20
> Mine were in t5601...should these go there, too, or is there a reason=
 to
> do it in t5602?
I confused 5601 with 5602, started from there, ended up in a mess.
Thanks for saving me.
Using the comments, I'll send a real patch on top of pu.
/Torsten
