From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Added sub get_owner_file which checks if there's a file with project owner name
Date: Fri, 1 Feb 2008 20:10:39 +0100
Message-ID: <200802012010.40739.robin.rosenberg.lists@dewire.com>
References: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br> <200802011418.59862.jnareb@gmail.com> <47A3449E.6070102@iksz.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Nagy =?utf-8?q?Bal=C3=A1zs?= <js@iksz.hu>
X-From: git-owner@vger.kernel.org Fri Feb 01 21:01:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL24O-0000OP-3e
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 21:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbYBAUAb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Feb 2008 15:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbYBAUAb
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 15:00:31 -0500
Received: from [83.140.172.130] ([83.140.172.130]:16624 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754335AbYBAUAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 15:00:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 16350802868;
	Fri,  1 Feb 2008 21:00:29 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u53R4mLGhCyc; Fri,  1 Feb 2008 21:00:27 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id D623A802662;
	Fri,  1 Feb 2008 21:00:27 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <47A3449E.6070102@iksz.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72183>

fredagen den 1 februari 2008 skrev Nagy Bal=C3=A1zs:
> Well, I came from ClearCase world, were registry service holds all=20
> vob/view (repo) stuff.  What if we implement more or less the same=20
> here?  I mean if you have a lot of public git repos, or at least comm=
on=20
> for a couple of people, we could store all the fundamental data (loca=
l=20
> storage path, share URL) of a group of repos in a single database.  W=
e=20
> could call them depots.  Moreover, we could use this as the source of=
=20
> git clone, God forbid, even remotely (some kind of git config=20
> depot.url=3Dhttps://user:pass@git.example.org/depot.cgi/depotname).  =
I=20
> could continue but I'm afraid I'll run out of oxygen :)

I'll fill in: LDAP.

-- robin
