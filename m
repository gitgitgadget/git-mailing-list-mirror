From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Sat, 16 Mar 2013 08:21:50 +0100
Message-ID: <51441D8E.7090303@web.de>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com> <1363179556-4144-1-git-send-email-pclouds@gmail.com> <7vehfj46mu.fsf@alter.siamese.dyndns.org> <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com> <7vmwu6yqbd.fsf@alter.siamese.dyndns.org> <CACsJy8BruzR=EGnwA5nc_aCJ5pO4FHyQKxd-9_36U48Ci_FFew@mail.gmail.com> <514343BA.3030405@web.de> <7vvc8svc2r.fsf@alter.siamese.dyndns.org> <51435D49.6040005@web.de> <7v4ngcv35l.fsf@alter.siamese.dyndns.org> <51438F33.3080607@web.de> <7vzjy4tjd5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	artagnon@gmail.com, robert.allan.zeh@gmail.com, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 16 08:22:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGlRj-0005MN-VV
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 08:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab3CPHV5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Mar 2013 03:21:57 -0400
Received: from mout.web.de ([212.227.17.11]:62379 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab3CPHV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 03:21:56 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MFL64-1USsOp1BGm-00EzF5; Sat, 16 Mar 2013 08:21:52
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7vzjy4tjd5.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:ArTIC3x/0c/eKrfeNYFzuhLt8fbiUC0kdKJvUPHka0F
 f1zsx1tkIYMCzEWCGOBi1fmigXMB5zJWOdXJ6Fke+XjCHybq6r
 jV9/8lQwVUDUkLPp3LLSNaw8AN0yvaakkkho7EUM0xtmfcitJq
 QRkxdj9/r9NtkcpD/zw0ISRqL5XFQrXOdGtVV+r2f0+Xjl4NSf
 snbxT5UZmf++uG9N7w+JA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218286>

On 15.03.13 22:59, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Thanks, that looks good to me:
>>
>> # It took 2.58 seconds to enumerate untracked files.
>> # Consider the -u option for a possible speed-up?
>>
>> But:
>> If I follow the advice as is given and use "git status -u", the resu=
lt is the same.
>=20
> Yeah, that was taken from
>=20
>     http://thread.gmane.org/gmane.comp.version-control.git/215820/foc=
us=3D218125
>=20
> to which I said something about "more levels of indirections".  This
> episode shows that even a user who was very well aware of the issue
> did not follow a single level of indirection.
>=20
>> If I think loud, would it be better to say:
>>
>> # It took 2.58 seconds to search for untracked files.
>> # Consider the -uno option for a possible speed-up?
>>
>> or
>>
>> # It took 2.58 seconds to search for untracked files.
>> # Consider the -u option for a possible speed-up?
>> # Please see git help status
>=20
> The former actively hurts the users, but the latter would be good,
> given that your documentation updates clarifies the trade off.
>=20
> Or we can be more explicit and say
>=20
> # It took 2.58 seconds to search for untracked files.  'status -uno'
> # may speed it up, but you have to be careful not to forget to add
> # new files yourself (see 'git help status').
>=20
Thanks, that looks good for me
