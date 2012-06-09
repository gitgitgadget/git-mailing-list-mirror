From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sat, 9 Jun 2012 23:14:16 +0200
Message-ID: <877gvgrxw7.fsf@thomas.inf.ethz.ch>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
	<20120609221315.Horde.fN5FP3wdC4BP065b3FviijA@webmail.minatec.grenoble-inp.fr>
	<CAA3EhHJ9WnisF21iFfsjQKYFSY0t0jFvNV3aBjx0eGFPm8aoGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <konglu@minatec.inpg.fr>, <git@vger.kernel.org>
To: Leila <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:14:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdSzM-0004QR-4R
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 23:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab2FIVOV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jun 2012 17:14:21 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:26907 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112Ab2FIVOV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2012 17:14:21 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 9 Jun
 2012 23:14:15 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.211.205) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 9 Jun
 2012 23:14:17 +0200
In-Reply-To: <CAA3EhHJ9WnisF21iFfsjQKYFSY0t0jFvNV3aBjx0eGFPm8aoGg@mail.gmail.com>
	(Leila's message of "Sat, 9 Jun 2012 17:08:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.211.205]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199558>

Leila <muhtasib@gmail.com> writes:

>> The structure is
>> =C2=A0 =C2=A0 =C2=A0if (...) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*code*/
>> =C2=A0 =C2=A0 =C2=A0} else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*code*/
>> =C2=A0 =C2=A0 =C2=A0}
>>
>> Do not forget braces in the "else" part as the firt block needs it.
>
> I was under the impression that one liners didn't require parenthesis
> according to the style guidelines. I didn't realize that if the 'if'
> required it, then the else required it. I will make that change and
> remember it for the future. Thanks!

It's not required, there's plenty of precedent, even one case within
wt-status.c, of '} else'.  Try running

  git grep '} else$'

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
