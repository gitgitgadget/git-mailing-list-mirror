From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Rename case insensitive
Date: Fri, 8 Apr 2016 13:45:32 +0200
Message-ID: <570799DC.9000700@web.de>
References: <16238819-B46A-40C7-943A-EBD22EAACEF6@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: chenjinlei <chenjinlei456@sina.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 13:45:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoUrN-0003Kr-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 13:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655AbcDHLpx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2016 07:45:53 -0400
Received: from mout.web.de ([212.227.17.12]:51331 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633AbcDHLpw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 07:45:52 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MLgQp-1anfm640TT-000qOx; Fri, 08 Apr 2016 13:45:38
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <16238819-B46A-40C7-943A-EBD22EAACEF6@sina.com>
X-Provags-ID: V03:K0:a9SKbEFt15oHQ5fA0/YTuhlG3irbHHj+hYfD4Og9bj4qx5NtnoV
 MBZTCsP4NlPDLgIiF4OUkWRbe+FxG9ZY30KdYqB0/T5d0euvBGG29nX3RWsp7uJOOzqavAh
 Z7YOPF3P0WtrkiQTrtegeZ1MVQFgsm/WsUAtvh8FVjzD34m5nUhDTH8VADxpYcQboKuAsWQ
 xG/sXkmYAKhjMdXVMlO+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BSPs66GCpQ4=:O6I6HSr5d8/CydN58cvcVA
 rhzXkqMGevQufjPGKkrH/djFqNDLy8dx0i/oN6HRotFdjpF57kLMxv3d2xZdkOZL+dGwvpNnK
 atZ8iNVKFyKlJBlpgTqLvr7TqXJuiQGcjqXC48gJlvj1qgufc+UlTFcBgi7FtxzEG9RfslvEW
 F2amYu3GpVCzoxbhgiXZwEb3uolMUgOhJAMVfjk8YgMPWG8ezVLsdqdeoCCIZoswubgBfDqjI
 gqd7k4lTn/w/t0GZ0VqZBymuhNKiTWN9kMvhtTCDBNK3k+Oco4sfm/+uc9rsAwewRqgyD8LMu
 /rIucivjQS13LNduLev44HSC6UBr2RMlfynSMSNvemfL5iyQBl5/LxEGc3O/FvrfFMBnYh+Ex
 nTAZxdKWAMR0SvrfGXvc+xdlPCLcq485Inllij0bzqeJOGv8vX0H8utAC7zaKtPkgsNqqbl+5
 m+yWXapcdoalvGKLsbs0ADYAoQwkuDYbrAjMfc2+CfvU+hUjMHc/Y3jLgjKgUenO09RiySfYR
 89eNJVfNvIgJD/k7uVHQZ/kfwR+EHt4i5TGSr6hIq1j/DaG5v3K4rEAaA/tgSHyIBmY/M+OGd
 E5Ols2GuEFRHtNK2NmMUztnBTWu5xyAyRdpjswSnSkzODUSsEhK8WjzpfqsUldz+IbeqA6ctU
 4Fh2wJgRg3PkYbSH0ovu326xI4Qu8THc0oGny8I7wbRygVjz4SiOyruiY29XHMTsFfPhoIkEe
 riETZAV64J3k6Z32WX08R8uCqqzUOsmFctFUKQMU1z0yFFj4VpWo66lwgmn7OSYrbEQVjgL5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291028>

On 08.04.16 12:01, chenjinlei wrote:
>=20
> I=E2=80=99m encounter a problem due to my own stupidity=E2=80=A6
> #1 I pushed a project named Android to my repository.
> #2 I `mv Android android`, cause I think it=E2=80=99s no good to use =
the uppercase as my project name.
> #3 I pushed it to my repository again=E2=80=A6
>=20
> I found that there `Adnroid` and `android` exist in my repository, an=
d I want to delete the former one.
> So I tried to `git pull && git rm Android`, but guess what? I can=E2=80=
=99t pull the `Android`=E2=80=A6=E2=80=A6
>=20
> I found that OS X is case-insensitive, while github repository is cas=
e-sensitive, thus I can=E2=80=99t `rm Android` any more. It becomes a g=
osht in my repository and I can never delete it!
>
Correct.

#make a fresh clone of your repo to the local disc:
git clone "repo_your_repo_name" temp_repo

# go into that repo
cd temp_repo

# Tell Git to rename the folder in the Git repo:
git mv Android android

#Commit
git commit -m "mv Android android"

#Push back
git push origin

HTH
