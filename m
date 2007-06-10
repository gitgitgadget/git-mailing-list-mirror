From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Sun, 10 Jun 2007 14:36:24 -0700
Message-ID: <7vlker7aqv.fsf@assigned-by-dhcp.cox.net>
References: <11813427591137-git-send-email-krh@redhat.com>
	<7v7iqdf0gn.fsf@assigned-by-dhcp.cox.net>
	<466B376D.8040303@redhat.com>
	<200706101437.50441.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 23:36:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxV5N-00064g-Mw
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 23:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbXFJVg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jun 2007 17:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbXFJVg1
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 17:36:27 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56679 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbXFJVg0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2007 17:36:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610213625.XPBQ18396.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 17:36:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9xcR1X00K1kojtg0000000; Sun, 10 Jun 2007 17:36:26 -0400
In-Reply-To: <200706101437.50441.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Sun, 10 Jun 2007 14:37:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49771>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> s=C3=B6ndag 10 juni 2007 skrev Kristian H=C3=B8gsberg:
>> Junio C Hamano wrote:
>> > Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>> > ...
>> > I think your name in your commit message is in UTF-8 but munged yo=
ur
>> > mail was mismarked as iso-8859-1.
>>=20
>> That's odd both the email I cc'ed to my redhat.com address and the o=
ne I got=20
>> on gmail.com through the list have
>>=20
>>    Content-Type: text/plain; charset=3Dutf-8
>>=20
>> and saving the raw message and asking /usr/bin/file, it tells me its
>>=20
>>    /home/krh/Desktop/hep: UTF-8 Unicode mail text
>
> Maybe Junio's mail server has a problem with the impliction of this h=
eader line?=20
>
> "Content-Transfer-Encoding: 8bit" ?

The copy of Kristian's message gmane has says:

	Content-Type: TEXT/PLAIN; charset=3DISO-8859-1

I do not think it is just me.
