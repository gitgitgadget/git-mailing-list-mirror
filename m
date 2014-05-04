From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 04 May 2014 19:24:36 +0200
Message-ID: <877g618njf.fsf@igel.home>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu>
	<20140504160728.GN75770@vauxhall.crustytoothpaste.net>
	<87bnvd8p7h.fsf@igel.home> <87wqe1tqu3.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun May 04 19:24:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh09b-0004es-AO
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 19:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbaEDRYj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2014 13:24:39 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52862 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbaEDRYi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 13:24:38 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3gMDb91YxZz4KKx1;
	Sun,  4 May 2014 19:24:37 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3gMDb916DWzbbgP;
	Sun,  4 May 2014 19:24:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id Zu2qmkizTnnI; Sun,  4 May 2014 19:24:36 +0200 (CEST)
X-Auth-Info: PzywVFCKZe36qllN38XJHxnJeTTkKjBzbtIeOd79yIs=
Received: from igel.home (ppp-93-104-158-29.dynamic.mnet-online.de [93.104.158.29])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun,  4 May 2014 19:24:36 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 464DE2C411D; Sun,  4 May 2014 19:24:36 +0200 (CEST)
X-Yow: I HAVE to buy a new ``DODGE MISER'' and two dozen JORDACHE
 JEANS because my viewscreen is ``USER-FRIENDLY''!!
In-Reply-To: <87wqe1tqu3.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Sun, 04 May 2014 19:07:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248100>

David Kastrup <dak@gnu.org> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>>> I don't even plan to write the code assuming that offsetof(struct
>>> object_id, oid) is 0.
>>
>> This is guaranteed by the C standard, though.
>
> Any reference?

=C2=A76.7.2.1#15

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
