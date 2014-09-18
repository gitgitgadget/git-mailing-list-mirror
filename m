From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 08/35] lock_file(): always add lock_file object to
 lock_file_list
Date: Thu, 18 Sep 2014 09:47:18 +0200
Message-ID: <541A8E06.8080609@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-9-git-send-email-mhagger@alum.mit.edu> <541A6047.6000707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 09:54:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUWXt-0002mL-DK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 09:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbaIRHyZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2014 03:54:25 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:45854 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750834AbaIRHyZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Sep 2014 03:54:25 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Sep 2014 03:54:24 EDT
X-AuditID: 1207440d-f797f6d000000a4a-43-541a8e0acb17
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id ED.C0.02634.A0E8A145; Thu, 18 Sep 2014 03:47:22 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB07BC.dip0.t-ipconnect.de [93.219.7.188])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8I7lIaS000319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 18 Sep 2014 03:47:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <541A6047.6000707@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsUixO6iqMvVJxVicPWskUXXlW4mi4beK8wW
	T+beZbb40dLDbPFvQo1FZ8dXRgc2jwWbSj0evupi93jWu4fR4+IlZY/Pm+Q8bj/bxhLAFsVt
	k5RYUhacmZ6nb5fAnXH12w3Wgll8FR/vTmJrYFzJ3cXIySEhYCKxcOMLNghbTOLCvfVANheH
	kMBlRomupVtZIZxzTBKP9j1gBqniFdCW2PPkKguIzSKgKtE7uxnMZhPQlVjU08wEYosKBEh8
	6HzACFEvKHFy5hMWkEEiAh2MEi//fwRKcHAwCyRJfO7IBqkRFoiSmHTwNhPEsumMEg2Nd5lA
	ajgF1CSWt6qA1DAL6EnsuP6LFcKWl2jeOpt5AqPALCQrZiEpm4WkbAEj8ypGucSc0lzd3MTM
	nOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MkKDn3cH4f53MIUYBDkYlHt4DvFIhQqyJZcWVuYcY
	JTmYlER5KxqAQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR483yBcrwpiZVVqUX5MClpDhYlcV61
	Jep+QgLpiSWp2ampBalFMFkZDg4lCd7rPUCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJ
	pSUZ8aBYjS8GRitIigdor0ovyN7igsRcoChE6ylGXY51nd/6mYRY8vLzUqXEebNBdgiAFGWU
	5sGtgKW4V4ziQB8L8zKDjOIBpke4Sa+AljABLTHpBltSkoiQkmpgdDvBPO3ISq/nQaH7lu4M
	WrIpZOOeSqM9wt9XnT2T1WQZd1EpWYfd7Llj2vvNb+U3/ZxzV8PDIVlBxNj1d5Kd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257255>

On 09/18/2014 06:32 AM, Torsten B=F6gershausen wrote:
> On 09/16/2014 09:33 PM, Michael Haggerty wrote:
> []
>>
>> diff --git a/lockfile.c b/lockfile.c
>> index 983c3ec..00c972c 100644
>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -129,6 +129,22 @@ static int lock_file(struct lock_file *lk, cons=
t char *path, int flags)
>>  	 */
>>  	static const size_t max_path_len =3D sizeof(lk->filename) - 5;
>> =20
>> +	if (!lock_file_list) {
>> +		/* One-time initialization */
>> +		sigchain_push_common(remove_lock_file_on_signal);
>> +		atexit(remove_lock_file);
>> +	}
>> +
>> +	if (!lk->on_list) {
>> +		/* Initialize *lk and add it to lock_file_list: */
>> +		lk->fd =3D -1;
>> +		lk->owner =3D 0;
>> +		lk->on_list =3D 1;
>> +		lk->filename[0] =3D 0;
> Does it makes sense to change the order here:
>=20
> Do the full initialization, and once that is completed, set on_list =3D=
 1
> +		lk->filename[0] =3D 0;
> +		lk->on_list =3D 1;

=46rom a functional standpoint, it doesn't matter. This function is the
only place that uses on_list, and it is basically only used to make sur=
e
that each lock_file structure is initialized and registered in
lock_file_list exactly once. In particular, the signal handling code
doesn't care about the on_list field.

So the only important timing requirement WRT on_list is that it be set
before this function is called again with the same lock_file object. Bu=
t
any code that would call this function twice, simultaneously, with the
same lock_file argument would be broken far more seriously than could b=
e
fixed by changing the order that the fields are initialized.

But I guess you are right that it looks more natural to set this field
only after all of the initialization is done. I will make the change.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
