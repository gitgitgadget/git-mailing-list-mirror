From: Andreas Ericsson <ae@op5.se>
Subject: Re: linux-2.6 clone with CygWin git
Date: Sat, 10 Nov 2007 10:50:23 +0100
Message-ID: <47357EDF.2000708@op5.se>
References: <598D5675D34BE349929AF5EDE9B03E270174D8A2@az33exm24.fsl.freescale.net> <20071109150306.GA20531@old.davidb.org> <473495E1.3080305@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Medve Emilian <Emilian.Medve@freescale.com>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 10:50:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqmzE-0005BV-4k
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 10:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbXKJJu2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2007 04:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbXKJJu2
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 04:50:28 -0500
Received: from mail.op5.se ([193.201.96.20]:34887 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbXKJJu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 04:50:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EB1591F08735;
	Sat, 10 Nov 2007 10:50:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MZFs9Krqu62U; Sat, 10 Nov 2007 10:50:25 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id B30221F08733;
	Sat, 10 Nov 2007 10:50:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <473495E1.3080305@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64323>

Pascal Obry wrote:
> David Brown a =E9crit :
>> It's because of the case-insensitive nature of the filesystem.  The =
kernel
>> contains both an xt_connmark.h and an xt_CONNMARK.h file, that are
>> different.  But only one exists on Windows, so git sees the first on=
e it
>> wrote as having been modified.
>=20
> Probably not something for the list... but if you ask me this is just
> bad practice anyway. Casing has no semantic, it is nonsense to have t=
wo
> files with the same name with different casing!
>=20

You're right, it's not something for this list. Try arguing your case a=
t
the linux kernel mailing list.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
