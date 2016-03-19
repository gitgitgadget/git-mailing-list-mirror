From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Sat, 19 Mar 2016 07:59:21 +0100
Message-ID: <56ECF8C9.7090604@web.de>
References: <20160208225806.GA3487@dcvr.yhbt.net>
 <1456597724-26497-1-git-send-email-tboegi@web.de>
 <20160228045945.GA14289@dcvr.yhbt.net> <56D333F1.9050905@web.de>
 <20160315015954.GB25295@dcvr.yhbt.net> <56E79C54.8000606@web.de>
 <20160315070930.GA24036@dcvr.yhbt.net> <56E999C3.4040802@f2.dion.ne.jp>
 <56EA3DBD.2070105@web.de> <56EA4230.7010501@web.de>
 <56EB64C2.4090405@f2.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Mar 19 07:59:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahArU-0003Vn-JJ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 07:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbcCSG7n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2016 02:59:43 -0400
Received: from mout.web.de ([212.227.17.11]:51568 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbcCSG7l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 02:59:41 -0400
Received: from macce.local ([93.222.58.143]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LqUXd-1aCUrp3Non-00e0ew; Sat, 19 Mar 2016 07:59:29
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <56EB64C2.4090405@f2.dion.ne.jp>
X-Provags-ID: V03:K0:PmJm41EGBYrrpY3ZOULt/rz329Hi3RG1xUvM8ixKLZzQXvCQbog
 9ZcpdarQn20WcLOAaC/JRD9ACKyOKdhenpoEVBkDV76e6Lw3O24wBDjZ+hlxZTPJ6RO6/Fm
 gwk3JeEzt0is4vM0MKWxvkdJrLnT1o+t2PGknMJw/xo3lMWGDhFOYFdyGf6OPTFmkTOkydF
 oD2YUq0gh+4/nHDe537vQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ONFxrPLIBL0=:t1wDDhu/9hw/6IfJEvz0VV
 hez63REZmW5DALnKV/reFzkOls7Tuf+CHb4XBd44knZGjzrTJ27hF2Zq21hbhJRxKR5GLvARt
 YQym7te7dajgrbmk4LwikZxfM+ZL1tCoZCGeqwjrg8oJ7q5xWoWMphZICak+r9Bb8RxqPY3yV
 1Px7DIpzMlE4DL7/Nc6xpLnoG2+4ja7WztiK0QSahki+26cCEWTjz2NN5bBAXRtLG8VUKjffu
 MayCW0F8ECOQqky6jq4X1jaSshhAyaYl1CqS4L6/np0NzUhGt2bvA8dzcpMLncDcUWDF2VVfu
 LhJFsXc6L4rIawihOqgJEe/HKjTH0SRq3u0L1avW3OOM7uVKb0Qgv3wTm6zD9wGqj5fUmNt2T
 ITjXKZ0tHUMb2Lauvn9H6JgC88FKVBh5KcoIoT6k8DY32JQH2xIAvVSeCMHQ9eUNMxFbEdvTa
 MHN3coZNjVkGnQ5AMPtO1bijmdJlc4NXHWcfPkg1Ff7JGV3LDMkzoKmgjtXAqDlCrzyCq/d/9
 JLZtkYnPd22SWaWq0Cw0MXY1vwuD9zh/efdCfCdsfO4ZJ03yDFsug+qFxJx9gmNmvNSndmdBt
 kzVNWcKYbSBFke3C7c9oL2XdT0JB4AGKOe36i5j84DiVoIFeqqR8iZAs32VRvbAVH0sdEWc7P
 pzkbGeZkUoAtMgGBcunoaS+EspguhLAYHT+mOmGkNzNnZtM6y8oQ+vaC5DpHEnCt0TMqWVUXu
 4qe5hpXNtnwxxt8QPHsxdXpoSogvoYPMXzplRlbpgYSjYctrf92Ff5CXbnSGJm6/vLnc2Emk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289288>

On 2016-03-18 03.15, Kazutoshi Satoda wrote:
> On 2016/03/17 14:35 +0900, Torsten B=C3=B6gershausen wrote:
>> On 2016-03-17 06.16, Torsten B=C3=B6gershausen wrote:
> ...
>> And the pathch is here:
>> <https://github.com/tboegi/git/commit/866dfc192a0d4428aebfc7242f5134=
899b6dafd4>
>>
>> Kazutoshi, could you re-test on your environment ?
>=20
> The test 11,12 was skipped on my environment, too:
>> $ ./t9115-git-svn-dcommit-funky-renames.sh
>> ok 1 - load repository with strange names
>> ...
>> ok 10 - git svn rebase works inside a fresh-cloned repository
>> ok 11 # skip svn.pathnameencoding=3Dcp932 new file on dcommit (missi=
ng FS_CP932 of UTF8,FS_CP932)
>> ok 12 # skip svn.pathnameencoding=3Dcp932 rename on dcommit (missing=
 FS_CP932 of UTF8,FS_CP932)
>> # passed all 12 test(s)
>> 1..12
>=20
> That's because the check for FS_CP932 runs under LC_ALL=3DC environme=
nt
> which affects how filenames are treated. See the comment on #11 for m=
ore
> details.
>=20
> Setting LC_ALL before the check works for me.
>=20
>  test_lazy_prereq FS_CP932 '
>         # check whether FS allows filenames from cp932
> +       prepare_a_utf8_locale
> +       LC_ALL=3D$a_utf8_locale &&
> +       export LC_ALL &&
>         neq=3D$(printf "\201\202")
>=20
> But it looks a bit strange to do "prepare_a_utf8_locale" here because=
 it
> is done just before #11 now, though I think it does no harm.
>=20
> I also don't understand the way of the check: Why don't you just touc=
h
> and test it, like this:
> 	touch "$neq" && test -e "$neq"
> ?
>=20
Thanks, I will re-send a new version in a couple of days or so.
