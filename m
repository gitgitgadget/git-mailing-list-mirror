From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: bash completion only provides revs, not paths
Date: Tue, 22 Apr 2008 13:21:29 +0200
Message-ID: <20080422112129.GA30923@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 13:22:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoGZx-0004Od-1I
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 13:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbYDVLVi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2008 07:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbYDVLVi
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 07:21:38 -0400
Received: from mail164.messagelabs.com ([216.82.253.131]:64171 "EHLO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbYDVLVh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 07:21:37 -0400
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-5.tower-164.messagelabs.com!1208863293!12815472!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.14]
Received: (qmail 11004 invoked from network); 22 Apr 2008 11:21:34 -0000
Received: from mail.mx2.digi.com (HELO mcl-sms-ns2.DIGI.COM) (66.77.174.14)
  by server-5.tower-164.messagelabs.com with RC4-SHA encrypted SMTP; 22 Apr 2008 11:21:34 -0000
Received: from mcl-sms-exch01.digi.com (10.5.8.50) by mail.mx2.digi.com
 (172.16.1.14) with Microsoft SMTP Server (TLS) id 8.1.263.0; Tue, 22 Apr 2008
 06:20:38 -0500
Received: from mtk-sms-mail01.digi.com (10.10.8.120) by
 mcl-sms-exch01.digi.com (10.5.8.50) with Microsoft SMTP Server id 8.1.263.0;
 Tue, 22 Apr 2008 06:21:32 -0500
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by
 mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);	 Tue, 22 Apr
 2008 06:21:32 -0500
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com
 with Microsoft SMTPSVC(6.0.3790.3959);	 Tue, 22 Apr 2008 13:21:29 +0200
Received: by zentaur.digi.com (Postfix, from userid 1080)	id 4E1F22AB07; Tue,
 22 Apr 2008 13:21:29 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 22 Apr 2008 11:21:29.0808 (UTC) FILETIME=[02F44D00:01C8A46B]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.500.1026-15864.006
X-TM-AS-Result: No--4.602000-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80103>

Hello,

currently autocompletion in=20

	ukleinek@zentaur:~/gsrc/linux-2.6 git log ar<tab>

only yields "armltd/" (i.e. the prefix of some remote tracking branches=
)
but most of the time I want it to complete to "arch/".

I don't understand that autocompletion stuff, but probably to fix that
several __git_complete_revlist should be replaced by a
__git_complete_revlist_or_path.  The harder part is to implement the
latter function.  An optimal implementation would only give back paths
if there is a "--" somewhere before the cursor.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
