From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] git-checkout.txt: Document "git checkout <pathspec>"
 better
Date: Wed, 10 Jun 2015 20:27:28 +0200
Message-ID: <55788190.80106@web.de>
References: <5575F948.4060400@web.de> <xmqqioavob7n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, eda@waniasset.com,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 20:27:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2kj9-0001bb-R0
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 20:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbbFJS1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2015 14:27:48 -0400
Received: from mout.web.de ([212.227.15.4]:52639 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbbFJS1q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 14:27:46 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LzbAA-1Z7gem2dtK-014kLG; Wed, 10 Jun 2015 20:27:30
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqioavob7n.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:j9ps/NPFp9ggzVfurkolSOf6opk+LWUgVelASHZ3Q8YBddOc5JK
 ojyJ7h8mgMnE2sCkwBPTGbewnqfCEfKXY7tt6TEcR4KyEt3DYcAPmhVwPUqPD86Vml2d6Qq
 YGJjs3n0/ydSjIP3m9Gq7EQczNO+OK7cpaKlW8qNE3KxFGxSNeizXV+AhCiWJxCb/i1Irqs
 eVujDIj+alGgOsYKmMzzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g9+5Bo+RBZc=:ovvsPHBXUxYafjXSTyv90h
 tV9P14qLIy7gQg09FOtKIJlGKCagZ1jEU7auL0RAVPcGi8VcHgsUxK9eNFayoRKfzMGGnZOaf
 iG4OTuOz5NcmtGCr44S5/aDyt++S4w+nJJqj1I0Sim2vrLz3P19hTLBd/j5WDNCIs8sr3zW7c
 LhVOtlnsBgWrqWmcQU08Pm8N5i0EWgeljuRtBkyn2riCW9znEbGQw748uyO5G7tq7EzL844S8
 QLATRJWZSEBhBt9Kz5xIFbLyByMvhaGUY4nQ07o4CuWODxS9zMpZQfvqc6qYcbtFm7oMINhuB
 0RqVzwKpy73r9gStPCG2LyalPI/JuZ3w1dEMpxE3MCtbihPFKOawdrNL0ZTXJ72AZIm62j3ye
 fcn1m7fovBtgCoONM0hDbA70PmNnQ4Hxn62MLfpKqyCb5rb7LouvOPaJkz9kBdR+UGvSbutjj
 Rpox7vBuGW/BDKlmWqhqj+iuwgJlu+EgmR9WvK++RqGMEbUnRAT5Vn9zV8leZsGKfubi49CLP
 ej//uYGAn6apTVTFLGzxEixzojOJQdHz9r+aMVg6xwLbJVkCEXkYL8GH3Qc4qj7esFO//OH9M
 mgpwnLjRsiKqD9T04VDyNV90SZ4LYrlOhkmEsrvrSSoZXZKmsxh7mtbe169jXTE+otML8DySY
 9jOFqacOe+XzHjw+7Xi7epos3+5M7kNFCLo8IMlnj1QUve9No66c9QS+qYSacd64pTvE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271338>

On 2015-06-10 17.05, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
(Need to drop Eric from CC-list(=20
>> git checkout <pathspec> can be used to revert changes in the working=
 tree.
>=20
> I somehow thought that concensus in the recent thread was that
> "restore", not "revert", is the more appropriate wording?
>=20
> And I think that is indeed sensible because "revert" (or "reset")
> already means something else in Git (and in other systems), while
> "restore" does not have a confusing connotation.  It can only mean
> "overwrite with a pristine copy", which is what the command is
> about.
>=20
>> -git-checkout - Checkout a branch or paths to the working tree
>> +git-checkout - Switch branches or reverts changes in the working tr=
ee
>=20
> Two verbs in different moods; either "switch branches or restore
> changes" or "switches branches or restores changes" would fix that,
> and judging from "git help" output, I think we want to go with the
> former, i.e. "switch branches or restore changes".
OK for me
>=20
>> =20
>>  SYNOPSIS
>>  --------
>> @@ -83,7 +83,8 @@ Omitting <branch> detaches HEAD at the tip of the =
current branch.
>>  	When <paths> or `--patch` are given, 'git checkout' does *not*
>>  	switch branches.  It updates the named paths in the working tree
>>  	from the index file or from a named <tree-ish> (most often a
>> -	commit).  In this case, the `-b` and `--track` options are
>> +	commit).  Changes in files are discarded and deleted files are
>> +	restored.
>=20
[]
> How about this?
>=20
>   	'git checkout' with <paths> or `--patch` is used to restore
>         modified or deleted paths to their original contents from
>         the index file or from a named <tree-ish> (most often a
>         commit) without switching branches.
OK for me.
