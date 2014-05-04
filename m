From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 04 May 2014 20:01:53 +0200
Message-ID: <8738gp8lta.fsf@igel.home>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu>
	<20140504160728.GN75770@vauxhall.crustytoothpaste.net>
	<87bnvd8p7h.fsf@igel.home> <87wqe1tqu3.fsf@fencepost.gnu.org>
	<877g618njf.fsf@igel.home> <87ppjttp4b.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun May 04 20:02:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh0jz-00007X-1e
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 20:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbaEDSCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2014 14:02:00 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:37271 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbaEDSB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 14:01:57 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3gMFQB6YbJz3hjjY;
	Sun,  4 May 2014 20:01:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3gMFQB2fpQzbbg8;
	Sun,  4 May 2014 20:01:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 9-Y03xNlrspr; Sun,  4 May 2014 20:01:53 +0200 (CEST)
X-Auth-Info: rnVWI89VFQ1FHEMyNGYcdtA/GnuCY9TsSF5mY343Jm8=
Received: from igel.home (ppp-93-104-158-29.dynamic.mnet-online.de [93.104.158.29])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun,  4 May 2014 20:01:53 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 82B822C4143; Sun,  4 May 2014 20:01:53 +0200 (CEST)
X-Yow: Why don't you ever enter any CONTESTS, Marvin??
 Don't you know your own ZIPCODE?
In-Reply-To: <87ppjttp4b.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Sun, 04 May 2014 19:44:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248104>

David Kastrup <dak@gnu.org> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>>
>>>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>>>
>>>>> I don't even plan to write the code assuming that offsetof(struct
>>>>> object_id, oid) is 0.
>>>>
>>>> This is guaranteed by the C standard, though.
>>>
>>> Any reference?
>>
>> =C2=A76.7.2.1#15
>
> More like #13.

I don't know what you mean, but this is a C11 reference.

> I am pretty sure, however, that this has not always been the case.

You are wrong.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
