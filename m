From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: use case: keep the output of a markup (TeX) file under revision
 control
Date: Thu, 17 Feb 2011 13:03:46 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4D5D0EA2.4000805@atlas-elektronik.com>
References: <1297939020.3959.12.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Paul Menzel <paulepanter@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:03:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq2aP-0003wy-7P
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab1BQMDs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 07:03:48 -0500
Received: from mail96.atlas.de ([194.156.172.86]:24330 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020Ab1BQMDr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 07:03:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 2736E10075;
	Thu, 17 Feb 2011 13:03:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id tnVd6XUCXl2l; Thu, 17 Feb 2011 13:03:45 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 17 Feb 2011 13:03:45 +0100 (CET)
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 8A0D82716A;
	Thu, 17 Feb 2011 13:03:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <1297939020.3959.12.camel@mattotaupa>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167069>

On 2/17/2011 11:37 AM, Paul Menzel wrote:
> Dear Git folks,
>=20
>=20
> (Please CC me when replying since I am not subscribed.)
>=20
> I have the following use case and need an advise from you professiona=
ls.
>=20
> A friend and I are writing a paper using TeX=C2=B9 and keep the files=
 under
> revision control using Git. This works fine so far. But I want to als=
o
> have the output (PDF) of the markup file under revision control to be
> able to access the PDF files even if for example no TeX installation =
is
> available on a system.
>=20
> The problem now is, since the output is no plain text file, that
> merging/rebasing always shows conflicts which Git, of course, cannot
> solve.
>=20
> Is there a way to set that up so that there are no conflicts? Would a
> pre-commit hook work which generates the PDF file prior to committing=
?
> And if no TeX installation is available it would just ignore the PDF
> files?
>=20
> I could not find anything on the Web because having PDF as search str=
ing
> would just show up how to generate documentation about Git.

Why don't you keep the PDF files in a separate branch ? Look at git's
git repository (http://git.kernel.org/?p=3Dgit/git.git) in the html=20
and man branches.

Regards,
  Stefan
--=20
----------------------------------------------------------------
/dev/random says: If at first you don't succeed, work for Microsoft.
