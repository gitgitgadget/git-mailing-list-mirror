From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: problem with git rebase -i
Date: Wed, 13 Feb 2008 09:10:59 +0100
Message-ID: <20080213081059.GA18230@digi.com>
References: <20080211134448.GA17588@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 09:11:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPCiU-0002rN-L1
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 09:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbYBMILG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 03:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbYBMILF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 03:11:05 -0500
Received: from mail29.messagelabs.com ([216.82.249.147]:25638 "HELO
	mail29.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755571AbYBMILC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 03:11:02 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-10.tower-29.messagelabs.com!1202890262!5866199!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 6825 invoked from network); 13 Feb 2008 08:11:02 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-10.tower-29.messagelabs.com with SMTP; 13 Feb 2008 08:11:02 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Feb 2008 02:11:02 -0600
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Feb 2008 02:11:01 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Feb 2008 09:10:59 +0100
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id 873C91B23F; Wed, 13 Feb 2008 09:10:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080211134448.GA17588@digi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 13 Feb 2008 08:10:59.0774 (UTC) FILETIME=[F79EC5E0:01C86E17]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15726.002
X-TM-AS-Result: No--8.633400-8.000000-4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73750>

Hello,

Uwe Kleine-K=F6nig wrote:
> I tried to rebase my work (on the Linux kernel) to current Linus'
> master.  As I have two branches I merged them and ran:
>=20
> 	git rebase -i -p v2.6.25-rc1
>=20
> But then the list I got in my editor didn't include the merge and so =
the
> result was broken.
>=20
> If I add
>=20
> 	pick 913183f
>=20
> (with 913183f being my HEAD) to the list, the result is correct.
>=20
> The reason that my merge is missing is that git rev-list thinks my
> merge is the same as 249d621 and so skips that as it uses --cherry-pi=
ck.
I think the right thing to do here is to let --cherry-pick only kick ou=
t
revs that are no merges.  This should be save as git-rebase--interactiv=
e
is the only user of --cherry-pick.

Comments?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
