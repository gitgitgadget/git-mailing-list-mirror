From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 09 Dec 2009 12:48:24 +0100
Message-ID: <m2pr6ocqrb.fsf@igel.home>
References: <20091208144740.GA30830@redhat.com>
	<7vfx7lcj18.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
	<20091209093758.GA2977@redhat.com>
	<alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
	<20091209112237.GA27740@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 12:48:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIL23-0001nT-4C
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 12:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbZLILsX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 06:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755170AbZLILsW
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 06:48:22 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33650 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755082AbZLILsV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 06:48:21 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id AAE7C1C153A6;
	Wed,  9 Dec 2009 12:48:25 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 9B0CF9040A;
	Wed,  9 Dec 2009 12:48:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id kSUO9UdGPxe5; Wed,  9 Dec 2009 12:48:24 +0100 (CET)
Received: from igel.home (DSL01.83.171.156.136.ip-pool.NEFkom.net [83.171.156.136])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed,  9 Dec 2009 12:48:24 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 3CD58CA28F; Wed,  9 Dec 2009 12:48:24 +0100 (CET)
X-Yow: I just heard the SEVENTIES were over!!  And I was just getting in touch
 with my LEISURE SUIT!!
In-Reply-To: <20091209112237.GA27740@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s
	message of "Wed, 9 Dec 2009 12:22:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134960>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Err, no. "git merge --squash foo" merges all changes from the merge b=
ase
> of HEAD and foo up to foo. "git cherry-pick foo" takes just the chang=
es
> from foo^ to foo. For example:
>
> A---B---C (master)
>  \
>   D---E---F (foo)
>
> git cherry-pick foo # Tries to create a new commit with the changes f=
rom
>                     # "git diff D F"

Did you mean "git diff E F"?

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
