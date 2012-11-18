From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t5801-remote-helpers.sh fails
Date: Sun, 18 Nov 2012 16:52:27 +0100
Message-ID: <50A9043B.6070904@web.de>
References: <509E5B27.5080808@web.de> <CAMP44s0HtMRaQ91z95cZS73W7tnqYwyKV_2guWJ6u6UP4p5JNw@mail.gmail.com> <509EA8EE.1030908@web.de> <CAMP44s2yenQKSgdUXfZP+yDJJ+bdveyms=SQ+3ptPvpT6D0hsg@mail.gmail.com> <50A87718.4030806@web.de> <CAMP44s22kuXqUjY2Oy2YtBfj1+kF2rHnRKcovV8sPkhu1oR+2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 16:52:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta7B0-0003A9-9O
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 16:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab2KRPwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 10:52:31 -0500
Received: from mout.web.de ([212.227.15.3]:60380 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091Ab2KRPwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 10:52:30 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LmLK6-1T1bhJ476I-00ZloF; Sun, 18 Nov 2012 16:52:28 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <CAMP44s22kuXqUjY2Oy2YtBfj1+kF2rHnRKcovV8sPkhu1oR+2A@mail.gmail.com>
X-Provags-ID: V02:K0:ALzGctkypM/e9nCmHTtyA49Ih0Y84ra5UTFlRTAj2Dv
 bOHEd8+JluRlea12DTmgmMEq4eVIJOnytAUwX8TuF375Q9OwJY
 F5VJvDrxVHjfE9pTU+ualolQXLw6exXzfxELdrkdNvKLbTGeO5
 K766vEq4FwyVSGuXXL0clx3ixV6SGb/k2/fxRViXT3FYbnufAc
 gJ21hm25loGVJNGoPBDwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210026>

On 18.11.12 09:23, Felipe Contreras wrote:
> Hi,
>=20
> On Sun, Nov 18, 2012 at 6:50 AM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>=20
>> I managed to have a working solution for
>> "d) add a check for the bash version to the top of the test in t/"
>> Please see diff below.
>>
>> This unbreaks the test suite here.
>> Is this a good way forward?
>>
>> Filipe, does the code line you mention above work for you?
>>
>> If yes: I can test it here, if you send it as a patch.
>=20
> It's already sent:
> http://article.gmane.org/gmane.comp.version-control.git/209364
>=20
Thanks for working on it, and sorry that you need to remind me:
I had the V5 series already on my harddisk, but forgot to test it.
It applied on v.1.8.0 with the following results:

ok 1 - setup repository
ok 2 - cloning from local repo
ok 3 - create new commit on remote
ok 4 - pulling from local repo
ok 5 - pushing to local repo
ok 6 - fetch new branch
ok 7 - fetch multiple branches
ok 8 - push when remote has extra refs
ok 9 - push new branch by name
not ok 10 - push new branch with old:new refspec # TODO known breakage
ok 11 - cloning without refspec
ok 12 - pulling without refspecs
not ok 13 - pushing without refspecs # TODO known breakage
not ok 14 - pulling with straight refspec # TODO known breakage
not ok 15 - pushing with straight refspec # TODO known breakage
not ok 16 - pulling without marks # TODO known breakage
not ok 17 - pushing without marks # TODO known breakage
ok 18 - push ref with existing object
# still have 6 known breakage(s)
/Torsten
