From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: ANNOUNCE: Git for Windows 1.7.9
Date: Thu, 09 Feb 2012 09:11:03 +0100
Message-ID: <4F337F97.8000903@atlas-elektronik.com>
References: <CABNJ2GJ-Jtpg=HsB9TmvLskmB9xXSeshHXz8V9koJfvMp5WNvA@mail.gmail.com> <4F33798F.2010908@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <blees@dcon.de>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 09:11:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvP5y-0003me-Rs
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 09:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab2BIILG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 03:11:06 -0500
Received: from mail96.atlas.de ([194.156.172.86]:10607 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268Ab2BIILF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 03:11:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 1FF2E10074;
	Thu,  9 Feb 2012 09:11:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id odmn26edUq0Z; Thu,  9 Feb 2012 09:11:02 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu,  9 Feb 2012 09:11:02 +0100 (CET)
Received: from [10.200.54.97] (as112671.atlas.de [10.200.54.97])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 51C6827180;
	Thu,  9 Feb 2012 09:11:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <4F33798F.2010908@atlas-elektronik.com>
X-Enigmail-Version: 1.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190278>

Am 09.02.2012 08:45, schrieb Stefan N=C3=A4we:
> Am 01.02.2012 12:23, schrieb Pat Thoyts:
>> This release brings the latest release of Git to Windows users.
>>
>> Pre-built installers are available from
>> http://code.google.com/p/msysgit/downloads/list
>>
>> Further details about the Git for Windows project are at
>> http://code.google.com/p/msysgit/
>=20
> I'm getting errors from 'git repack -Ad' with this version on Windows=
 XP:
>=20
> $ /bin/git repack -Ad
> Counting objects: 147960, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (35552/35552), done.
> Writing objects: 100% (147960/147960), done.
> Total 147960 (delta 110699), reused 147960 (delta 110699)
> Deletion of directory '.git/objects/01/' failed. Should I try again? =
(y/n)
> Deletion of directory '.git/objects/05/' failed. Should I try again? =
(y/n) n
> Deletion of directory '.git/objects/07/' failed. Should I try again? =
(y/n) n
> Deletion of directory '.git/objects/0c/' failed. Should I try again? =
(y/n) n
> Deletion of directory '.git/objects/10/' failed. Should I try again? =
(y/n)
> ....
>=20
>=20
> A bisection pointed me to this commit (https://github.com/msysgit/git=
/commit/19d1e75):
>=20
>  "Win32: Unicode file name support (except dirent)"
>=20
> When I reset "/git" to this commit and recompile, 'git gc' and 'git r=
epack -Ad'

  s/this commit/parent of this commit (c5d4ecfe)/

> don't raise this error anymore.
>=20
> Any ideas ?
>=20
>=20
> Thanks,
>   Stefan


--=20
----------------------------------------------------------------
/dev/random says: Take two crows and caw me in the morning
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
