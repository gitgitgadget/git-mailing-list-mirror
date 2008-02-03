From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH] Comment private modifier to improve performace.
Date: Sun, 3 Feb 2008 23:14:32 +0100
Message-ID: <200802032314.34005.robin.rosenberg@dewire.com>
References: <1201919018-10782-1-git-send-email-rogersoares@intelinet.com.br> <200802030326.40446.robin.rosenberg@dewire.com> <47A61E17.7060303@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:15:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLn7J-00084R-5O
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 23:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbYBCWOd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 17:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbYBCWOd
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 17:14:33 -0500
Received: from [83.140.172.130] ([83.140.172.130]:4313 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbYBCWOc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 17:14:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BD55E800685;
	Sun,  3 Feb 2008 23:14:30 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IsjTXPtLEQTr; Sun,  3 Feb 2008 23:14:30 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 44161800681;
	Sun,  3 Feb 2008 23:14:30 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <47A61E17.7060303@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72410>

s=F6ndagen den 3 februari 2008 skrev Roger C. Soares:
> With the else warnings patch I'm ok.
>=20
> About the discouraged access, I read those warnings as: we are using=20
> methods that are not part of the eclipse public API and they can chan=
ge=20
> in the future. Not depending on internal eclipse API will make egit l=
ess=20
> likely to break with a future eclipse version, which sounds like a go=
od=20
> thing to me. So, I would keep those.

The thing with that one is that by default the warning is on, so removi=
ng
the setting doesn't remvoe the warning unless one disables it at the wo=
rkspace
level. I'll hold it back for the moment anyway and push the "else" and =
"synthetic"
patches. Thanks for your opinions on the subject matter.

-- robin
