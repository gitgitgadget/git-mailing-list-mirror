From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: GIT Plug-in for PowerBuilder
Date: Fri, 20 Sep 2013 22:54:06 +0200 (CEST)
Message-ID: <1127527154.2077569.1379710446222.JavaMail.zimbra@dewire.com>
References: <9CF44A1E54713941B63069424C62AA1C07C07D@GBPB-EXM-PR02.emea.travelex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daren Scott <daren.scott@travelex.com>,
	Rajen Shah <Rajen.Shah@Travelex.com>,
	Sagar Keluskar <Sagar.Keluskar@travelex.com>
To: Ram Kunchur <Ram.Kunchur@travelex.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 23:04:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN7rw-0007u3-MH
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 23:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231Ab3ITVEA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Sep 2013 17:04:00 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:52784 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab3ITVD7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Sep 2013 17:03:59 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Sep 2013 17:03:59 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 56DEF81964;
	Fri, 20 Sep 2013 22:54:07 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fV7WxHbiT97S; Fri, 20 Sep 2013 22:54:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id E91CC8197F;
	Fri, 20 Sep 2013 22:54:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tD9SLB3ne5HZ; Fri, 20 Sep 2013 22:54:06 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id C8FE181964;
	Fri, 20 Sep 2013 22:54:06 +0200 (CEST)
In-Reply-To: <9CF44A1E54713941B63069424C62AA1C07C07D@GBPB-EXM-PR02.emea.travelex.net>
X-Originating-IP: [78.69.107.197]
X-Mailer: Zimbra 8.0.4_GA_5737 (ZimbraWebClient - FF23 (Mac)/8.0.4_GA_5737)
Thread-Topic: GIT Plug-in for PowerBuilder
Thread-Index: Ac62CWA05sqWJ89YRNOS4QOwijNqFQAArTrggXYfsUs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235080>


----- Ursprungligt meddelande -----
> Fr=C3=A5n: "Ram Kunchur" <Ram.Kunchur@travelex.com>
> Till: git@vger.kernel.org
> Kopia: "Daren Scott" <daren.scott@travelex.com>, "Rajen Shah" <Rajen.=
Shah@Travelex.com>, "Sagar Keluskar"
> <Sagar.Keluskar@travelex.com>
> Skickat: fredag, 20 sep 2013 16:17:38
> =C3=84mne: GIT Plug-in for PowerBuilder
>=20
> Hello Team,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 We wish to use=
 GITSCC plug-in with PowerBuilder for application
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 source-control=
 with GIT GUI,
> We downloaded GitScc.msi setup file from PushOK website, unfortunatel=
y when
> file was downloaded and before we could initialize installation
> Symantec Endpoint Protection reported the file to be infected was con=
sidered
> to be a potential security threat.
> Our company security team has denied us from using the above plug-in.
>=20
> We wish to know is there any alternative plug-in for PowerBuilder-GIT
> available which is secure & safe and also you can suggest us to use i=
t.
> Request you to kindly revert and please advise on this matter, Thanks=
=2E

That's the only one I know of. Fortunately, since Git does not lock fil=
es, you
really don't need a plugin. Just run git gui side by side with your IDE=
 and
you'll be fine.

I asked PushOK about that plugin a long time ago and they did not suppo=
rt it.
Now it seems they forgot they have the web site, hence the "extras" inc=
luded.

-- robin
