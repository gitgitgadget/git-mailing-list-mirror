From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: problem with git rebase -i
Date: Mon, 11 Feb 2008 14:44:48 +0100
Message-ID: <20080211134448.GA17588@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 14:46:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOYyq-000750-TJ
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 14:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbYBKNoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 08:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbYBKNoy
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 08:44:54 -0500
Received: from mail164.messagelabs.com ([216.82.253.131]:61427 "HELO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753287AbYBKNox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 08:44:53 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-11.tower-164.messagelabs.com!1202737491!26942198!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 27132 invoked from network); 11 Feb 2008 13:44:52 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-11.tower-164.messagelabs.com with SMTP; 11 Feb 2008 13:44:52 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 Feb 2008 07:44:51 -0600
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 Feb 2008 07:44:51 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 Feb 2008 14:44:48 +0100
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id BBB7C1B23F; Mon, 11 Feb 2008 14:44:48 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 11 Feb 2008 13:44:48.0982 (UTC) FILETIME=[4521DF60:01C86CB4]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15724.000
X-TM-AS-Result: No--4.719900-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73534>

Hello,

I tried to rebase my work (on the Linux kernel) to current Linus'
master.  As I have two branches I merged them and ran:

	git rebase -i -p v2.6.25-rc1

But then the list I got in my editor didn't include the merge and so th=
e
result was broken.

If I add

	pick 913183f

(with 913183f being my HEAD) to the list, the result is correct.

The reason that my merge is missing is that git rev-list thinks my
merge is the same as 249d621 and so skips that as it uses --cherry-pick=
=2E

Currently I cannot reproduce that with a simple testcase.
I don't want to publish my tree now, but I can provide a bundle if
someone wants to look into that.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
