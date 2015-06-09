From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/13] delete_ref(): move declaration to refs.h
Date: Tue, 09 Jun 2015 12:10:57 +0200
Message-ID: <5576BBB1.5020903@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>	<2eea274d60e355e4944ca9ed400e6c2132b4ed32.1433763494.git.mhagger@alum.mit.edu> <CAGZ79kYy3zUezRzAG3Uo7bDbLgJ7srj3F1k-ama1C44ZdbHr=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 12:11:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2GV6-0006tx-F3
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 12:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbbFIKLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 06:11:16 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53558 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932184AbbFIKLO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 06:11:14 -0400
X-AuditID: 12074411-f796c6d000000bc9-7f-5576bbb30713
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 62.3F.03017.3BBB6755; Tue,  9 Jun 2015 06:10:59 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97525.dip0.t-ipconnect.de [79.201.117.37])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t59AAvM2015413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 9 Jun 2015 06:10:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <CAGZ79kYy3zUezRzAG3Uo7bDbLgJ7srj3F1k-ama1C44ZdbHr=Q@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqLt5d1mowdzDWhZdV7qZLBp6rzBb
	/GjpYbbYvLmdxYHFY8GmUo9nvXsYPS5eUvb4vEkugCWK2yYpsaQsODM9T98ugTtj39Jm9oJb
	4hXzz51nb2C8KtTFyMkhIWAi0XjjCDOELSZx4d56ti5GLg4hgcuMEgcnTWWCcM4xSdx90cAK
	UsUroC3x+9NvNhCbRUBVYuHSfkYQm01AV2JRTzNQAweHqECQxOuXuRDlghInZz5hAbFFBNQk
	Zq6aDdbKLFAu8efyInYQW1jAWeLD0h3sELtOM0ps/9nKBjKHUyBQYukSM4h6dYk/8y4xQ9jy
	Es1bZzNPYBSYhWTFLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6qXm1mil5pS
	uokREsyCOxhnnJQ7xCjAwajEw3tCoSxUiDWxrLgy9xCjJAeTkijv75VAIb6k/JTKjMTijPii
	0pzU4kOMEhzMSiK8LF1AOd6UxMqq1KJ8mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eS
	BO/BXUCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBIjS8GxipIigdo71yQdt7i
	gsRcoChE6ylGRSlx3n6QhABIIqM0D24sLEW9YhQH+lKYtw2kigeY3uC6XwENZgIa/P1rMcjg
	kkSElFQDo5R9eX4uO+ekY+bXClJO/f5ipfh5U0fO800b/h659VHFNnjRvb1Ffxe5xReUR3DF
	l9oWJqV/ybn9xMhhYurf7tzC6rmxJh9NZsdxVWw5Gd6u/orNW+DEGuVlbuWBz1ij 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271160>

On 06/08/2015 06:43 PM, Stefan Beller wrote:
> On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.ed=
u> wrote:
>> [...]
>> +/*
>> + * Delete the specified reference. If old_sha1 is non-NULL and not
>> + * NULL_SHA1, then verify that the current value of the reference i=
s
>> + * old_sha1 before deleting it.
>=20
> And here I wondered what the distinction between NULL and non-NULL,
> but NULL_SHA1
> is and digging into the code, there is none. (As you can also see in
> this patch above with
>     (old_sha1 && !is_null_sha1(old_sha1)) ? old_sha1 : NULL,
> but when digging deeper, the !is_null_sha1(old_sha1) is an arbitrary
> limitation (i.e.
> ref_transaction_delete and ref_transaction_update don't differ betwee=
n
> those two cases.)
>=20
> The distinction comes in at lock_ref_sha1_basic, where I think we may
> want to get rid of
> the is_null_sha1 check and depend on NULL/non-NULL as the difference
> for valid and invalid
> sha1's?

I'm having a little trouble understanding your comment.

The convention for ref_transaction_update() and friends is that

* old_sha1 =3D=3D NULL

  We don't care whether the reference existed prior to the
  update, nor what its value was.

* *old_sha1 is NULL_SHA1

  (by which I mean that old_sha1 points at 20 zero bytes; I hope
  that's clear even though NULL_SHA1 is not actually defined
  anywhere): The reference must *not* have existed prior to the
  update.

* old_sha1 has some other value

  The reference must have had that value prior to the update.

lock_ref_sha1_basic() distinguishes between { NULL vs. NULL_SHA1 vs.
other values } in the same way that ref_transaction_update() does.

The delete_ref() function doesn't follow the same convention. It treats
NULL and NULL_SHA1 identically, as "don't care".

It probably makes sense to change delete_ref() use the same convention
as ref_transaction_update(), but there are quite a few callers and I
didn't have the energy to review them all as part of this patch series.
So I left it unchanged and just documented the status quo better.

> That said, do we want to add another sentence to the doc here saying
> non-NULL and not
> NULL_SHA1 are treated the same or is it clear enough?
> With or without this question addressed:
> Reviewed-by: Stefan Beller <sbeller@google.com>

In set notation,

    "non-NULL" =3D
        "non-NULL and not NULL_SHA1" =E2=88=AA
        "non-NULL and equal to NULL_SHA1"

The latter two are *not* treated the same, so I don't see how we can
claim that "non-NULL" and "not NULL_SHA1" are treated the same. I must
be misunderstanding you.

Would it help if I changed the comment to

    Delete the specified reference. If old_sha1 is non-NULL and not
    NULL_SHA1, then verify that the current value of the reference is
    old_sha1 before deleting it. If old_sha1 is NULL or NULL_SHA1,
    delete the reference it it exists, regardless of its old value.

?

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
