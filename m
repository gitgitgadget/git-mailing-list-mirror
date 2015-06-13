From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/13] delete_ref(): move declaration to refs.h
Date: Sat, 13 Jun 2015 16:30:50 +0200
Message-ID: <557C3E9A.6090000@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>	<2eea274d60e355e4944ca9ed400e6c2132b4ed32.1433763494.git.mhagger@alum.mit.edu>	<CAGZ79kYy3zUezRzAG3Uo7bDbLgJ7srj3F1k-ama1C44ZdbHr=Q@mail.gmail.com>	<5576BBB1.5020903@alum.mit.edu> <CAGZ79kagxZLxFdf4QmiQr7qP6bPm_vZC8FbhmndC6O=AARrrNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 16:31:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3mSf-0002Xv-ID
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 16:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbbFMObA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jun 2015 10:31:00 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62193 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751394AbbFMOa6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 10:30:58 -0400
X-AuditID: 12074412-f79066d000000bc5-89-557c3e9d5d5c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.F8.03013.D9E3C755; Sat, 13 Jun 2015 10:30:53 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5DEUpk2025616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 10:30:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <CAGZ79kagxZLxFdf4QmiQr7qP6bPm_vZC8FbhmndC6O=AARrrNw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqDvXribU4MI5PouuK91MFg29V5gt
	frT0MFts3tzO4sDisWBTqcez3j2MHhcvKXt83iQXwBLFbZOUWFIWnJmep2+XwJ3R+vUoW8F2
	9oq7ZzcwNTCeY+1i5OSQEDCR+PRlAxuELSZx4d56MFtI4DKjxKPXTl2MXED2eSaJzes3MoEk
	eAW0JV7tvcMOYrMIqEp0T1wDNohNQFdiUU8zUA0Hh6hAkMTrl7kQ5YISJ2c+YQGxRQTUJGau
	mg02n1mgXOLP5UVgY4QFnCU+LN3BDrFrA5PEvIWTwGZyCgRKHLk7kQmiQV3iz7xLzBC2vETz
	1tnMExgFZiHZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5i
	hASz0A7G9SflDjEKcDAq8fBmxFaHCrEmlhVX5h5ilORgUhLljdwDFOJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCK6hdEyrEm5JYWZValA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgmK8PBoSTB
	22EL1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitT4YmCsgqR4gPYKgLTzFhck
	5gJFIVpPMepyLPhxey2TEEtefl6qlDhvI0iRAEhRRmke3ApY6nrFKA70sTDvBpAqHmDag5v0
	CmgJE9CS9p4qkCUliQgpqQZG5geC3/9P+Hbyh+CuaY92v5/pfIZV+Psxo12b5MMFmrRf3uiJ
	2tg+hyMifunkl9en3Fue0Ld1l1K9fO25vWXXlLdOZnVpmbYuR3m2ahvH4e1BLDuW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271545>

On 06/09/2015 06:42 PM, Stefan Beller wrote:
> On Tue, Jun 9, 2015 at 3:10 AM, Michael Haggerty <mhagger@alum.mit.ed=
u> wrote:
>> In set notation,
>>
>>     "non-NULL" =3D
>>         "non-NULL and not NULL_SHA1" =E2=88=AA
>>         "non-NULL and equal to NULL_SHA1"
>>
>> The latter two are *not* treated the same, so I don't see how we can
>> claim that "non-NULL" and "not NULL_SHA1" are treated the same. I mu=
st
>> be misunderstanding you.
>>
>> Would it help if I changed the comment to
>>
>>     Delete the specified reference. If old_sha1 is non-NULL and not
>>     NULL_SHA1, then verify that the current value of the reference i=
s
>>     old_sha1 before deleting it. If old_sha1 is NULL or NULL_SHA1,
>>     delete the reference it it exists, regardless of its old value.
>>
>> ?
>=20
> This is very clear to me.

OK, I will make the change in v2 (with s/it it/if it/).

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
