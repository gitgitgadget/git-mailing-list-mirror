From: David Kastrup <dak@gnu.org>
Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 05 Oct 2007 18:20:33 +0200
Message-ID: <86wsu1v8ha.fsf@lola.quinscape.zz>
References: <1191447902-27326-1-git-send-email-krh@redhat.com>
	<20071005142140.GK19879@artemis.corp>
	<20071005142507.GL19879@artemis.corp>
	<20071005143014.GA18176@glandium.org>
	<20071005144540.GM19879@artemis.corp>
	<598D5675D34BE349929AF5EDE9B03E2701624FD6@az33exm24.fsl.freescale.net>
	<20071005155647.GC20305@artemis.corp>
	<598D5675D34BE349929AF5EDE9B03E2701624FF2@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 18:24:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idpxc-0004JN-QG
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759161AbXJEQX0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 12:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759852AbXJEQX0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:23:26 -0400
Received: from main.gmane.org ([80.91.229.2]:37399 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757694AbXJEQXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 12:23:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Idpvk-0003f6-JV
	for git@vger.kernel.org; Fri, 05 Oct 2007 16:21:36 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 16:21:36 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 16:21:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:vNxn8qm3T2drps/6ye5F3WDAClc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60105>

"Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com> writes:

> Hi Pierre,
>
>> -----Original Message-----
>> From: Pierre Habouzit [mailto:madcoder@debian.org]=20
>> Sent: Friday, October 05, 2007 10:57 AM
>> To: Medve Emilian-EMMEDVE1
>> Cc: Mike Hommey; Kristian H=F8gsberg; git@vger.kernel.org;=20
>> Junio C Hamano
>> Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
>>=20
>> On ven, oct 05, 2007 at 03:45:36 +0000, Medve Emilian-EMMEDVE1 wrote=
:
>> > You probably already considered and rejected the GNU argp parser. =
I
>> > used it before and I'd like to know reasons I should stay away fro=
m
>> > it.
>>=20
>>   Because it's GNU and that it's a heavy dependency to begin with.
>
> So it's more of a political decision then a technical one?

Well, if it is GNU then it is likely to mean GPLv3 (or GPLv3+) at some
point of time, though it should certainly be possible for now to still
secure a v2-licensed version (either GPL or LGPL).

GNU also means a different coding and indentation style.

Personally, I couldn't care less about both points (I prefer the GNU
coding style anyway), but that's for the maintainer to decide, and one
also has to take into account the effect on developer motivation.

And the typical git developer AFAICT prefers to consider themselves as
unaligned with GNU and the FSF as much as possible.

--=20
David Kastrup
