From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/3] refs: use strings directly in find_containing_dir()
Date: Thu, 24 May 2012 06:34:01 +0200
Message-ID: <4FBDBA39.5020101@alum.mit.edu>
References: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu> <4FBBE012.6090702@lsrfire.ath.cx> <7vlikj3nzc.fsf@alter.siamese.dyndns.org> <4FBC0F12.2000001@lsrfire.ath.cx> <7vhav73lnl.fsf@alter.siamese.dyndns.org> <4FBD0E33.4060309@lsrfire.ath.cx> <7v4nr625vf.fsf@alter.siamese.dyndns.org> <4FBD1B36.5060404@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 24 06:41:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXPrR-0005nj-4F
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 06:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260Ab2EXElJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 00:41:09 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:51782 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750883Ab2EXElH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 00:41:07 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2012 00:41:07 EDT
X-AuditID: 12074413-b7f886d0000008a0-02-4fbdba3cc064
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 6D.DF.02208.C3ABDBF4; Thu, 24 May 2012 00:34:04 -0400 (EDT)
Received: from [192.168.69.140] (p4FC0D6A9.dip.t-dialin.net [79.192.214.169])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4O4Y1HE003280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 May 2012 00:34:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <4FBD1B36.5060404@lsrfire.ath.cx>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqGuza6+/wY8+C4uuK91MFg29V5gt
	frT0MFu8mnGNyYHF4/qNZ2wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xquFX5gL
	jolVXO3oZm5gfCXYxcjJISFgIrH382kmCFtM4sK99WwgtpDAZUaJ/49Cuhi5gOyzTBLbF7Sy
	gyR4BbQlnvQ0MYLYLAKqEnsbJoPZbAK6Eot6moEGcXCICoRJrH6gAVEuKHFy5hMWkLCIgJPE
	9A1FIGFmgXiJTZMnMIOEhQV8JH5u5YLYdJJJ4uq/rWwgcU4BPYmOGdkQ5WYSXVu7GCFseYnm
	rbOZJzAKzEKyYBaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3E
	CAlk4R2Mu07KHWIU4GBU4uHtEtjrL8SaWFZcmXuIUZKDSUmU12w7UIgvKT+lMiOxOCO+qDQn
	tfgQowQHs5IIr1cxUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMHr
	sxOoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4Uo/HFwCgFSfEA7ZUHaectLkjM
	BYpCtJ5itOT49nLidUaOh69A5JXfQFKIJS8/L1VKnDcFpEEApCGjNA9uHSydvWIUB/pemNca
	pIoHmArhpr4CWsgEtDDoxU6QhSWJCCmpBsaQw3t+CWUsEPe/zRDLe2XvJiGHPMvT57gEtTJb
	L1/IPjj79fvAiODOximJK6uc1lZPDzu+f3O53tvCTBteE797E0NbLi2tWvlfeoZA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198348>

On 05/23/2012 07:15 PM, Ren=C3=A9 Scharfe wrote:
> Am 23.05.2012 18:56, schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>   writes:
>>
>>> Am 23.05.2012 00:18, schrieb Junio C Hamano:
>>>> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>    writes:
>>>>
>>>>> What has git grep to do with refs?  It checks if the path in the =
command
>>>>> above is a ref, which makes it iterate over all of them..
>>>>
>>>> Do you mean:
>>>>
>>>> 	/* Is it a rev? */
>>>>            get_sha1()
>>>>            ->    ...
>>>>              ->    get_sha1_basic()
>>>>                ->    dwim_ref()
>>>>
>>>> callpath?
>>>
>>> Yes, indeed.  Hmm, this is done even if the paths come after a
>>> double-dash.  Anyway, I don't consider the check to be a performanc=
e
>>> issue, just a quick way to test the allocation count that i stumble=
d
>>> upon while working on the recent grep patches.
>>
>> I was merely reacting "iterate over all of them"; dwim_ref() only ch=
ecks
>> if .git/blah, .git/refs/heads/blah, .git/refs/tags/blah, etc.  exist=
s and
>> the number of checks do not depend on the number of refs you have, s=
o I
>> was wondering if I overlooked something that does for_each_ref() of
>> everything.
>
> Yeah, for loose refs that's true. However, I have 470 packed refs, an=
d
> this command:
>
> 	$ valgrind --tool=3Dexp-dhat ./git grep guess xdiff/xutils.c
>
> reports (among other findings):
>
> =3D=3D28255=3D=3D max-live:    30,334 in 470 blocks
> =3D=3D28255=3D=3D tot-alloc:   30,334 in 470 blocks (avg size 64.54)
> =3D=3D28255=3D=3D deaths:      none (none of these blocks were freed)
> =3D=3D28255=3D=3D acc-ratios:  7.76 rd, 0.95 wr  (235,582 b-read, 28,=
924 b-written)
> =3D=3D28255=3D=3D    at 0x402AEE8: malloc (in /usr/lib/valgrind/vgpre=
load_exp-dhat-x86-linux.so)
> =3D=3D28255=3D=3D    by 0x813691D: xmalloc (wrapper.c:50)
> =3D=3D28255=3D=3D    by 0x8106B1A: create_ref_entry.constprop.8 (refs=
=2Ec:250)
> =3D=3D28255=3D=3D    by 0x8107761: read_packed_refs (refs.c:817)
> =3D=3D28255=3D=3D    by 0x810785F: get_packed_refs (refs.c:843)
> =3D=3D28255=3D=3D    by 0x8107BE7: resolve_ref_unsafe (refs.c:1028)
> =3D=3D28255=3D=3D    by 0x81090AA: dwim_ref (refs.c:1549)
> =3D=3D28255=3D=3D    by 0x8122E06: get_sha1_1 (sha1_name.c:304)
> =3D=3D28255=3D=3D    by 0x81237EF: get_sha1_with_context_1 (sha1_name=
=2Ec:1044)
> =3D=3D28255=3D=3D    by 0x8124016: get_sha1 (cache.h:795)
> =3D=3D28255=3D=3D    by 0x75782F65: ???

You are seeing all of the packed refs being *read*, which is triggered=20
in this case by resolve_ref_unsafe() -> get_packed_refs().  This stack=20
trace does not imply that all references are being iterated through as=20
part of a search.  IOW, if dwim_ref() were called again, there would no=
t=20
be another 470 allocations.

This is similar to the old code, which also read all of the packed refs=
=20
whenever any of them were accessed.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
