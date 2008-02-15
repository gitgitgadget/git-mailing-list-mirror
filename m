From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: another git rebase -i problem
Date: Fri, 15 Feb 2008 09:10:46 +0100
Message-ID: <20080215081046.GA12091@digi.com>
References: <20080214093730.GA20408@digi.com> <alpine.LSU.1.00.0802141232070.30505@racer.site> <20080214130228.GB28472@digi.com> <alpine.LSU.1.00.0802141537000.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 09:11:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPvfJ-0002YW-OX
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 09:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbYBOIKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2008 03:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbYBOIKv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 03:10:51 -0500
Received: from mail29.messagelabs.com ([216.82.249.147]:41251 "HELO
	mail29.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750896AbYBOIKu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 03:10:50 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-9.tower-29.messagelabs.com!1203063049!6057179!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 7614 invoked from network); 15 Feb 2008 08:10:49 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-9.tower-29.messagelabs.com with SMTP; 15 Feb 2008 08:10:49 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 Feb 2008 02:10:49 -0600
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 Feb 2008 02:10:48 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 Feb 2008 09:10:46 +0100
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id 233B91B27B; Fri, 15 Feb 2008 09:10:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802141537000.30505@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 15 Feb 2008 08:10:46.0362 (UTC) FILETIME=[4473C3A0:01C86FAA]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15730.003
X-TM-AS-Result: No--7.132400-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73942>

Hallo Johannes,

> Anyway, your "problem" is that you have to say "git rebase --skip",=20
> because the patch has been applied to upstream already (but looked=20
> differently enough that the patch id was different).
I just noticed that non-interactive rebase fails in that case, too.

In my eyes=20

	VISUAL=3D: git rebase -i ...

should behave exactly as

	git rebase ...

but as this is a corner case that I will probably never run into it's O=
K
for me that it doesn't.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
