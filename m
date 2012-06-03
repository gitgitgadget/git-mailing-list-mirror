From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] fix many comment typos
Date: Sun, 03 Jun 2012 14:58:20 +0200
Message-ID: <87wr3od02b.fsf@rho.meyering.net>
References: <8762baf8do.fsf@rho.meyering.net>
	<7vmx4lz5bm.fsf@alter.siamese.dyndns.org>
	<87396ceuoy.fsf@rho.meyering.net> <4FCB4E0A.5080107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 03 14:58:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbAO9-0002Kb-M9
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 14:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab2FCM6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 08:58:30 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:53424 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078Ab2FCM63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2012 08:58:29 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 3695CD480B5
	for <git@vger.kernel.org>; Sun,  3 Jun 2012 14:58:21 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 940C5600AE;
	Sun,  3 Jun 2012 14:58:20 +0200 (CEST)
In-Reply-To: <4FCB4E0A.5080107@lsrfire.ath.cx> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of
	"Sun, 03 Jun 2012 13:44:10 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199086>

Ren=E9 Scharfe wrote:
> Am 03.06.2012 09:11, schrieb Jim Meyering:
>> Perhaps a more palatable change, here and in the other two places:
>> s/seeked/cg-seek'd/, i.e.,
>>
>> - * "git bisect" showed mysterious "won't bisect on seeked tree" err=
or message.
>> + * "git bisect" showed mysterious "won't bisect on cg-seek'd tree"
>> error message.
>>
>> Then, if someone does this again, it will be more obvious that
>> it is not a typo.
>
> This change is only valid if the command "git bisect" at some point
> printed "won't bisect on cg-seek'd tree" instead of "won't bisect on
> seeked tree".  And even then, it doesn't make now sense to change
> already published release notes (Documentation/RelNotes/1.5.4.4.txt),
> after the fact.

You're right.  Changing the RelNotes that way would not be useful.
However, changing git-bisect.sh should make it easier for non-native
English speakers to understand that obscure diagnostic.
