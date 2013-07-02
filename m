From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: git clone -b
Date: Tue, 2 Jul 2013 08:35:22 +0200
Message-ID: <51D274AA.2050902@atlas-elektronik.com>
References: <51CD7AB7.3040409@atlas-elektronik.com> <51D12A0E.60709@atlas-elektronik.com> <7v61wui5xe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 08:35:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtuBU-0000QK-58
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 08:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab3GBGfQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jul 2013 02:35:16 -0400
Received: from mail96.atlas.de ([194.156.172.86]:32461 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857Ab3GBGfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 02:35:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id A92F410155;
	Tue,  2 Jul 2013 08:35:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2WYZAii4S9B1; Tue,  2 Jul 2013 08:35:13 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue,  2 Jul 2013 08:35:12 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id B570527169;
	Tue,  2 Jul 2013 08:35:12 +0200 (CEST)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.1; Tue, 2 Jul
 2013 08:35:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7v61wui5xe.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229368>

Am 01.07.2013 18:46, schrieb Junio C Hamano:
> Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:
>=20
>>> Is there any reason why 'git clone -b' only takes a branch (from re=
fs/heads/)
>>> or a tag (from refs/tags/) ?
>=20
> Because they are common enough, and doing the same for an arbitrary
> object is just as easy to do something like:
>=20
> 	git clone -n
>         git checkout $an_arbitrary_commit_object_name^0

OK. I wasn't aware of '-n' for 'git clone'. Thanks.

>=20
>>> Background: At $dayjob we're using some kind of 'hidden' refs (in r=
efs/releases/)
>>> to communicate between the 'branch integrator' (who creates the ref=
 in refs/releases/)
>>> and the 'build master' who wants to build that ref.=20
>=20
> While I wasn't paying much attention to this, I vaguely recall that
> people pointed out that using a fresh clone every time may not be
> what you want to do in the first place, and I happen to agree with
> them (and that is why I am not very much interested in this topic).
=20
As I said: We'd be using 'git archive --remote...' if that was
submodule-aware.

Thanks,
  Stefan
--=20
----------------------------------------------------------------
/dev/random says: Circular Definition: see Definition, Circular.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
