From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Why is --pretty=format: so slow?
Date: Sun, 04 Nov 2007 14:53:39 +0100
Message-ID: <472DCEE3.501@lsrfire.ath.cx>
References: <18221.16318.785162.44769@cargo.ozlabs.ibm.com>	<7vmytuvdvq.fsf@gitster.siamese.dyndns.org>	<472D9F6E.8070609@lsrfire.ath.cx> <7vhck2s02z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 14:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iofva-0007Lt-1h
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 14:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbXKDNx7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 08:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756008AbXKDNx7
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 08:53:59 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:38319
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755614AbXKDNx6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 08:53:58 -0500
Received: from [10.0.1.201] (p57B7F8A7.dip.t-dialin.net [87.183.248.167])
	by neapel230.server4you.de (Postfix) with ESMTP id 7805C873BA;
	Sun,  4 Nov 2007 14:53:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vhck2s02z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63403>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Incidentally, I'm finishing a patch series to add git-describe
>> style placeholders.  It needs such an optimization even more badly
>> (and has it).  Speeding up other slow placeholder expansions falls
>> out quite naturally.  Please wait just a few minutes..
>=20
> Thanks, and take your time, as I am just going to bed, dreaming for a
> perfect series from one of the few people on this list whose patches
> I do not have to read to reject crap, but I do read to get impressed
> and admire ;-)

*blushes*

Well, it's certainly not perfect -- I just noticed I've sent the patche=
s
to your old address.  Would you like me to resend them?

And, of course, I found a conceptual bug (which is impossible to trigge=
r
with the current code, fortunately), while looking over the changes a
last time.  *sigh*.  I'll send a fix right away.

Ren=C3=A9
