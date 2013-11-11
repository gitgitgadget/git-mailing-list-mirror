From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] git-fetch-pack uses URLs like git-fetch
Date: Mon, 11 Nov 2013 20:56:01 +0100
Message-ID: <52813651.7000701@web.de>
References: <201311081854.06201.tboegi@web.de> <xmqqk3gen888.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 11 20:56:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfxb2-0004sZ-7X
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 20:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab3KKT4Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Nov 2013 14:56:25 -0500
Received: from mout.web.de ([212.227.17.12]:56965 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274Ab3KKT4X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 14:56:23 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LbImQ-1VIQD035dy-00kzJx for <git@vger.kernel.org>;
 Mon, 11 Nov 2013 20:56:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqk3gen888.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:53kiLqy7BpxMcAoyND3sdem+FDMG/77ovHNSlxaG+f92KqDIOtG
 93Wyy6bNdZ6qvIha/fox3enQKxbrrrogWiyxFlhqMzQE2vDF6UqD+MVne0j0sFyPET6TRBn
 VyvrVOLUgSpStpw7MRxSS/EO9NJZMTIsCm+Gb5T5gAMj9EriqO3YKydCBakIQ/8yYqE58f1
 /fjWkIVImG2/UsPOlaglw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237642>

On 2013-11-11 18.44, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> "git fetch-pack" allows [<host>:]<directory> to point out the source
>> repository.
>> Use the term <repository>, which is already used in "git fetch" or "=
git pull"
>> to describe URLs supported by Git.
>=20
> Sign-off?
Sorry, forgot -s.
If the patch makes sense otherwise, are you willing to squeeze this in:

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

>=20
>> ---
>>  Documentation/git-fetch-pack.txt | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fe=
tch-pack.txt
>> index 444b805..93b5067 100644
>> --- a/Documentation/git-fetch-pack.txt
>> +++ b/Documentation/git-fetch-pack.txt
>> @@ -12,7 +12,7 @@ SYNOPSIS
>>  'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--inclu=
de-tag]
>>  	[--upload-pack=3D<git-upload-pack>]
>>  	[--depth=3D<n>] [--no-progress]
>> -	[-v] [<host>:]<directory> [<refs>...]
>> +	[-v] <repository> [<refs>...]
>> =20
>>  DESCRIPTION
>>  -----------
>> @@ -97,19 +97,18 @@ be in a separate packet, and the list must end w=
ith a flush packet.
>>  -v::
>>  	Run verbosely.
>> =20
>> -<host>::
>> -	A remote host that houses the repository.  When this
>> -	part is specified, 'git-upload-pack' is invoked via
>> -	ssh.
>> -
>> -<directory>::
>> -	The repository to sync from.
>> +<repository>::
>> +	The URL to the remote repository.
>> =20
>>  <refs>...::
>>  	The remote heads to update from. This is relative to
>>  	$GIT_DIR (e.g. "HEAD", "refs/heads/master").  When
>>  	unspecified, update from all heads the remote side has.
>> =20
>> +SEE ALSO
>> +--------
>> +linkgit:git-fetch[1]
>> +
>>  GIT
>>  ---
>>  Part of the linkgit:git[1] suite
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
