From: Ivan Lyapunov <dront78@gmail.com>
Subject: Re: git log - crash and core dump
Date: Wed, 17 Apr 2013 06:50:36 +0400
Message-ID: <CANKwXW2h1+CGw2M3CmeXzXAX+wdCPgs5Ff_bGvTgYVpkwpijUw@mail.gmail.com>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx> <7v61zml0ow.fsf@alter.siamese.dyndns.org>
 <516DBE2E.4060201@lsrfire.ath.cx> <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 17 04:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USISy-00040g-Nx
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 04:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965651Ab3DQCvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 22:51:19 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:40103 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965647Ab3DQCvS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 22:51:18 -0400
Received: by mail-vc0-f173.google.com with SMTP id gf12so968856vcb.18
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 19:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=069LkKFEh2H1V8lEsfDYj7D8IUpuckp11X2uHV/s4Xo=;
        b=KnujA8yWyP8k6FM2X3LOW6HjqfPS2Enzf7gLxQ2es5hsxh/9//u+H6T9k/S1z1ab5b
         r/EexrcxznAaIYc6lP3mTZ6vaGIP+kOTq7sN8SlZM+CYOFqJJWRCMGbYwd6iXPVgpziN
         4FT3wmkBphXFZWtEt0hl1IUHBMtPR2uva/hsNfK9hzH9HCBTtES0L/aBEkcLQ4V+qD/4
         1IDOG0zc0Y67kW2bDRoJkpdO3MD6BrSWT/WC73Zt21NLwedVyWxQMV26IiADdGSgWH+K
         Ci+Rd7WAxpUdryF8Vbacyvx7jKLqFLBBn2YdzJmTLjA9j2TCHu5d/4ZnrmV0Fp687wx/
         Q/dw==
X-Received: by 10.59.3.9 with SMTP id bs9mr3528019ved.38.1366167077195; Tue,
 16 Apr 2013 19:51:17 -0700 (PDT)
Received: by 10.58.231.161 with HTTP; Tue, 16 Apr 2013 19:50:36 -0700 (PDT)
In-Reply-To: <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221498>

Looks like I missed a lot of fun I'm sleeping ;)

The current repo is a product of our core crossplatform team, working
on Linux/MacOSX/Win32 environment. The Linux environment also
separates on Ubuntu/ArchLinux distros, and probably most of repo bugs
coming from ArchLinux, since other environments are stable in time. I
can't say exact git verison the bugs was introduced, but we have a
commits, dated by 0 secs since the Epoch and invalid Author fields
also. Also git fsck --full got the following stats on repo

Checking object directories: 100% (256/256), done.
error in commit 7eeb541987af8a589c6ebee53346c48a13142233: invalid
author/committer line - missing space before date
error in commit c23b0a487143e5d5d96cdc5354975e95114241ee: invalid
author/committer line - missing space before date
error in commit c7fa421863e073996b5d1ba6beb6001b9d146cba: invalid
author/committer line - missing space before date
error in commit 131155bd75c588bcd251b719c483d1d5bcb78504: invalid
author/committer line - missing space before date
error in commit 0888e7ffe6ae0aaf1b6d1ba67d05715487f88a52: invalid
author/committer line - missing space before date
error in commit 3cdeddd15c251a13fb3e79844ed3ea0e02cb611a: invalid
author/committer line - missing space before date
error in commit 21f9fe1565d89da845fc7080495c922103bacf24: invalid
author/committer line - missing space before date
error in commit f557d3427ba1bb33a1c1fd2c7936efa7e7c70281: invalid
author/committer line - missing space before date
error in commit c625943779c72b41b08b41730e56126b89cbb7b4: invalid
author/committer line - missing space before date
error in commit a83fc863991aae2bdad148a5897ed4315792dd82: invalid
author/committer line - missing space before date
error in commit 207321f773e695b2ae88884c34620bc663383f90: invalid
author/committer line - missing space before date
error in commit 67368e9eda9892acd6c6ebf03dd6f22b6de2db8a: invalid
author/committer line - missing space before date
error in commit 525a5d508a7f466a1339752e921517f4db8c4af6: invalid
author/committer line - missing space before date
error in commit 38215e27f74caa342e3353c4cd548fcf8c1df3dc: invalid
author/committer line - missing space before date
error in commit 1ee0167194eb34caca2c20ce5c74d062fc898718: invalid
author/committer line - missing space before date
error in commit 3274c469b981285f9a4d0b0a62afbb8f4d3e93ae: invalid
author/committer line - missing space before date
error in commit f37ab83f71ca93f42256e05efdd4244eb321efaf: invalid
author/committer line - missing space before date
error in commit 9bb6f7d63bb5a37b8afc3ae090bd6f34deb68633: invalid
author/committer line - missing space before date
Checking objects: 100% (9576/9576), done.

And I haven't find a way to fix without loosing a commits history, so
we left them as it is. I will check the approved patches and writeback
a little bit later. Thanks a lot for looking this

Ivan

2013/4/17 Junio C Hamano <gitster@pobox.com>:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> How about making split_ident_line() a bit friendlier be letting it
>> provide the epoch as default time stamp instead of NULL?
>
> Two knee-jerk concerns I have without going back to the callers:
>
>  * Would that "0" ever be given to the approxidate parser, which
>    rejects ancient dates in numbers-since-epoch format without @
>    prefix?
>
>  * Does any existing caller use the NULL as a sign to see the input
>    was without date and act on that information?
>
>
>> -- >8 --
>> Subject: ident: let split_ident_line() provide a default time stamp
>>
>> If a commit has a broken time stamp, split_ident_line() sets
>> date_begin, date_end, tz_begin and tz_end to NULL.  Not all callers
>> are prepared to handle that case and segfault.
>>
>> Instead of fixing them and having to be careful while implementing
>> the next caller, provide a string consisting of the number zero as
>> default value, representing the UNIX epoch.  That's the value that
>> git log showed before it was converted to use split_ident_line().
>>
>> Reported-by: Ivan Lyapunov <dront78@gmail.com>
>> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
>> ---
>>  ident.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/ident.c b/ident.c
>> index 1c123e6..ee840f4 100644
>> --- a/ident.c
>> +++ b/ident.c
>> @@ -191,6 +191,8 @@ static void strbuf_addstr_without_crud(struct st=
rbuf *sb, const char *src)
>>       sb->buf[sb->len] =3D '\0';
>>  }
>>
>> +static const char zero_string[] =3D "0";
>> +
>>  /*
>>   * Reverse of fmt_ident(); given an ident line, split the fields
>>   * to allow the caller to parse it.
>> @@ -254,10 +256,10 @@ int split_ident_line(struct ident_split *split=
, const char *line, int len)
>>       return 0;
>>
>>  person_only:
>> -     split->date_begin =3D NULL;
>> -     split->date_end =3D NULL;
>> -     split->tz_begin =3D NULL;
>> -     split->tz_end =3D NULL;
>> +     split->date_begin =3D zero_string;
>> +     split->date_end =3D zero_string + strlen(zero_string);
>> +     split->tz_begin =3D zero_string;
>> +     split->tz_end =3D zero_string + strlen(zero_string);
>>       return 0;
>>  }
