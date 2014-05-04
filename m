From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 04 May 2014 19:44:52 +0200
Message-ID: <87ppjttp4b.fsf@fencepost.gnu.org>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu>
	<20140504160728.GN75770@vauxhall.crustytoothpaste.net>
	<87bnvd8p7h.fsf@igel.home> <87wqe1tqu3.fsf@fencepost.gnu.org>
	<877g618njf.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun May 04 19:45:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh0TX-0007Il-Gu
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 19:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbaEDRpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2014 13:45:14 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:42059 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbaEDRpN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2014 13:45:13 -0400
Received: from localhost ([127.0.0.1]:41100 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wh0TP-0008J7-PV; Sun, 04 May 2014 13:45:12 -0400
Received: by lola (Postfix, from userid 1000)
	id 66B82E08BB; Sun,  4 May 2014 19:44:52 +0200 (CEST)
In-Reply-To: <877g618njf.fsf@igel.home> (Andreas Schwab's message of "Sun, 04
	May 2014 19:24:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248101>

Andreas Schwab <schwab@linux-m68k.org> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>
>>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>>
>>>> I don't even plan to write the code assuming that offsetof(struct
>>>> object_id, oid) is 0.
>>>
>>> This is guaranteed by the C standard, though.
>>
>> Any reference?
>
> =A76.7.2.1#15

More like #13.  I am pretty sure, however, that this has not always bee=
n
the case.

--=20
David Kastrup
