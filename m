From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Cannot run cmd command lines from GIT bash
Date: Mon, 18 Aug 2014 16:43:33 +0200 (CEST)
Message-ID: <1193308472.195844.1408373013669.JavaMail.zimbra@dewire.com>
References: <E41D1E6BD9F1DF48877C833FE120496FDDE1D2FD@EU-MBX-04.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Dickson <alex_dickson@mentor.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 16:53:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJOJL-0005hr-MT
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 16:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbaHROxX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2014 10:53:23 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:34897 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbaHROxX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Aug 2014 10:53:23 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Aug 2014 10:53:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id B40D281565;
	Mon, 18 Aug 2014 16:43:37 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 92-K1PO9qnDN; Mon, 18 Aug 2014 16:43:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id DDFE98158A;
	Mon, 18 Aug 2014 16:43:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KxJDLGh_9IKl; Mon, 18 Aug 2014 16:43:33 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id C4E4681565;
	Mon, 18 Aug 2014 16:43:33 +0200 (CEST)
In-Reply-To: <E41D1E6BD9F1DF48877C833FE120496FDDE1D2FD@EU-MBX-04.mgc.mentorg.com>
X-Originating-IP: [80.252.171.62]
X-Mailer: Zimbra 8.0.7_GA_6020 (ZimbraWebClient - FF31 (Mac)/8.0.7_GA_6020)
Thread-Topic: Cannot run cmd command lines from GIT bash
Thread-Index: Ac+61DagxPOXr1ytShaxC21qQgOaGgAAFjSgl4rXcCw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255389>



----- Ursprungligt meddelande -----
> Fr=C3=A5n: "Alex Dickson" <alex_dickson@mentor.com>
> Till: git@vger.kernel.org
> Skickat: m=C3=A5ndag, 18 aug 2014 13:07:46
> =C3=84mne: Cannot run cmd command lines from GIT bash
>=20
> HI,
> I have just installed GIT from Git-1.9.4-preview20140815.exe having
> previously been using Git-1.9.2-preview20140411.exe I now
> find that some scripts I have been using for some time are no longer =
working
> correctly.
>=20
> It seems that now I cannot pass parameters through to a DOS =C2=A0com=
mand e.g.
> =C2=A0=C2=A0=C2=A0=C2=A0net user <username> /DOMAIN
>=20
> used to return full information about the user, now it just returns u=
sername
> not found, which is the behaviour
> if it is invoked without the /DOMAIN switch. I have seen similar with=
 other
> commands, an even simpler example would be
> =C2=A0=C2=A0 cmd /c dir
>=20
> This should run the DOS dir command, but all it does is invoke cmd.ex=
e
> =C2=A0interactively

msys translates anything that looks like a unix path. try doubling all =
initial
slashes, i.e. cmd //c dir

You might have better luck with Windows specifie questions in one of th=
e
msysgit forums than here.

-- robin
