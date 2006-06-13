From: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
Subject: Re: cvsps wierdness
Date: Tue, 13 Jun 2006 08:06:20 +0200
Organization: Dewire
Message-ID: <200606130806.21395.robin.rosenberg.lists@dewire.com>
References: <200606122247.02727.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0606121406200.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 13 08:07:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq23H-0007lB-Mn
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 08:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWFMGGr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 02:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWFMGGr
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 02:06:47 -0400
Received: from [83.140.172.130] ([83.140.172.130]:61753 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S932481AbWFMGGq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 02:06:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 7DB11802654;
	Tue, 13 Jun 2006 08:05:24 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08689-10; Tue, 13 Jun 2006 08:05:17 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by torino.dewire.com (Postfix) with ESMTP id D4619802662;
	Tue, 13 Jun 2006 08:05:15 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0606121406200.5498@g5.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21768>

m=E5ndag 12 juni 2006 23:27 skrev Linus Torvalds:
[...]
> Does this patch fix it for you (untested - it could result in tons of
> other trouble, but it basically just says that time ordering is less
> important than member revision ordering).
Thanks, it worked on the simple case at least. We'll see about the orig=
inal=20
full repo later.=20

>
> I don't think this is strictly correct, btw. I suspect you can still =
get
> into strange situations where the changeset merging has resulted in o=
ne
> file ordering one way, and another file ordering the other way.

Doesn't cvsps's conflict handing simply break up those patches into sev=
eral=20
patches? More patches is ok. Suboptimal patches can be accepted

-- robin
