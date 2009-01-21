From: =?UTF-8?B?S251dCBPbGF2IELDuGhtZXI=?= <knut-olav.bohmer@telenor.com>
Subject: Re: how to keeping track of cherry-pick?
Date: Wed, 21 Jan 2009 09:44:09 +0100
Message-ID: <4976E059.6000404@telenor.com>
References: <497663E4.4000302@telenor.com> <7vfxjdjvk8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 09:45:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPYiV-0008UN-6N
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 09:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757181AbZAUIoS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 03:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755757AbZAUIoS
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 03:44:18 -0500
Received: from mail46.e.nsc.no ([193.213.115.46]:46351 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754947AbZAUIoR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 03:44:17 -0500
Received: from [10.0.0.1] (ti100710a080-2364.bb.online.no [85.165.9.64])
	(authenticated bits=0)
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id n0L8iATI012940;
	Wed, 21 Jan 2009 09:44:10 +0100 (MET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7vfxjdjvk8.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106579>

Junio C Hamano wrote:
> Knut Olav B=C3=B8hmer <knut-olav.bohmer@telenor.com> writes:
>=20
>> svnmerge.py can give us a list of revisions available for merging. T=
he
>> result is similar to "git log --chery-pick master..dev" The differen=
ce
>> is that svnmerge.py operates on revision-numbers, and --chery-pick l=
ooks
>> at the diffs. The result of that is that when we get a conflict when=
 a
>> patch is cherry-picked, it will still show up as "available" when I =
run
>> "git log --cherry-pick master..dev"
>=20
> I think you are looking at it a wrong way.
>=20
> Because subversion (at least the older one) does not keep track of me=
rges,
> you had to track cherry-picks.  But cherry-pick is not how you usuall=
y do
> things in git.  You keep many topic branches with different doneness,=
 and
> you merge well-cooked ones to the more stable integration branch whil=
e
> leaving others still cooking.  So what you want to know is not cherry=
-pick
> status, but merge status.


I was afraid I would get this answer. I know that you change your
workflow when you migrate to git, but I was looking for a way to resolv=
e
the situation we are in, due to our old vcs.

--=20
Knut Olav B=C3=B8hmer
