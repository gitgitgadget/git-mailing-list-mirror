From: =?utf-8?B?QW5kcsOpIFouIEQuIEEu?= <andrezda10@yandex.com>
Subject: Re: Anonymous commit (empty Author and Committer)
Date: Sat, 31 Oct 2015 10:12:10 -0200
Message-ID: <863961446293530@web5m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: savannah-users@gnu.org, git@vger.kernel.org,
	The development of GNU GRUB <grub-devel@gnu.org>
X-From: savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org Sat Oct 31 13:12:28 2015
Return-path: <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>
Envelope-to: gcgsu-savannah-users@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>)
	id 1ZsV1H-0001Yx-3q
	for gcgsu-savannah-users@m.gmane.org; Sat, 31 Oct 2015 13:12:27 +0100
Received: from localhost ([::1]:55428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>)
	id 1ZsV1G-0001dX-BM
	for gcgsu-savannah-users@m.gmane.org; Sat, 31 Oct 2015 08:12:26 -0400
Received: from eggs.gnu.org ([2001:4830:134:3::10]:55137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrezda10@yandex.com>) id 1ZsV1C-0001d0-DG
	for savannah-users@gnu.org; Sat, 31 Oct 2015 08:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrezda10@yandex.com>) id 1ZsV1B-00070Y-Fi
	for savannah-users@gnu.org; Sat, 31 Oct 2015 08:12:22 -0400
Received: from forward18m.cmail.yandex.net ([5.255.216.149]:35728)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrezda10@yandex.com>)
	id 1ZsV16-0006zR-TB; Sat, 31 Oct 2015 08:12:17 -0400
Received: from web5m.yandex.ru (web5m.yandex.ru [IPv6:2a02:6b8:0:2519::205])
	by forward18m.cmail.yandex.net (Yandex) with ESMTP id 6A94A21356;
	Sat, 31 Oct 2015 15:12:13 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web5m.yandex.ru (Yandex) with ESMTP id 1FC582C607CC;
	Sat, 31 Oct 2015 15:12:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1446293532; bh=WfM7YaQaydk33PTPwlzobd6UNavHY/RDxRVxgmkXwMg=;
	h=From:To:Subject:Date;
	b=PowcGVgjOCqs4u6N+6+xfHcjkCZx+RC+haCqs/zpQMYm0kHT7qV84kFYFiuQCR3AZ
	pOF47cQC3eT7Pmz4O9I9EqgJNvvaA7CEfofjtNhX75TaG5/3fN3d4oPR3A+ucWz5ga
	ie6C8PbddtJ4z+P4NG+kZAeX0Vk5beThJLMzAgHM=
Received: by web5m.yandex.ru with HTTP;
	Sat, 31 Oct 2015 15:12:10 +0300
X-Mailer: Yamail [ http://yandex.ru ] 5.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 5.255.216.149
X-BeenThere: savannah-users@gnu.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Discussion of savannah-announce and any user-oriented topic
	<savannah-users.gnu.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/savannah-users>,
	<mailto:savannah-users-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/savannah-users>
List-Post: <mailto:savannah-users@gnu.org>
List-Help: <mailto:savannah-users-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/savannah-users>,
	<mailto:savannah-users-request@gnu.org?subject=subscribe>
Errors-To: savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org
Sender: savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280577>

> 30.10.2015 23:59, Lennart Sorensen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>> On Fri, Oct 30, 2015 at 09:19:19PM +0100, Vladimir '=CF=86-coder/phcod=
er' Serbinenko wrote:
>>
>>> On 30.10.2015 21:09, Vladimir '=CF=86-coder/phcoder' Serbinenko wrote=
:
>>>
>>>> On 30.10.2015 21:06, Vladimir '=CF=86-coder/phcoder' Serbinenko wrot=
e:
>>>>
>>>>> On 30.10.2015 15:26, Andrei Borzenkov wrote:
>>>>>
>>>>>> See
>>>>>> http://git.savannah.gnu.org/cgit/grub.git/commit/?id=3D206676601eb=
853fc319df14cd3398fbdfde665ac
>>>>>>
>>>>>> I was not even aware that this is possible. Is there anything on s=
erver
>>>>>> side that can prevent it?
>>>>>>
>>>>>> Would be good if commit were amended and force pushed to fix it.
>>>>>
>>>>> It is a bug in SGit. I'll investigate how it happened
>>>
>>> I don't have non-fast-forward rights. Does someone from savannah-user=
s
>>> have them? Could he just delete this commit?
>>
>> If you do that, then anyone that already did a pull after it went in
>> will have a broken tree. Rather annoying.
>=20
> If we decide to fix this commit it is better done now, while it is the
> last one. It is annoying but do you have suggestion how it can be done
> differently?

+1 to undo it now

Indeed. The faster it is fixed smaller the number of potential unintentio=
nal repeats for it, if any.
