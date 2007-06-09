From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Attributes for commits
Date: Sat, 9 Jun 2007 20:48:51 +0200
Message-ID: <200706092048.52142.robin.rosenberg.lists@dewire.com>
References: <466AA714.4050500@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Franz <thefranz@comcast.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 21:56:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx72i-000252-Vb
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 21:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758821AbXFIT4L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 9 Jun 2007 15:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758274AbXFIT4L
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 15:56:11 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12109 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755453AbXFIT4L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2007 15:56:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2CD8280264D;
	Sat,  9 Jun 2007 21:49:35 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20694-08; Sat,  9 Jun 2007 21:49:34 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B99ED800784;
	Sat,  9 Jun 2007 21:49:34 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <466AA714.4050500@comcast.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49609>

l=F6rdag 09 juni 2007 skrev Paul Franz:
>     I am a ClearCase administrator and one of the things that I love=20
> about it is the ability to assign attributes to versions of files. Is=
=20
> there anybody thinking of adding the ability to assign attributes to =
a=20
> commit? I ask because I was thinking about how I would move from=20
> ClearCase to git and part of our process is to assign the BugNum=20
> attribute to every checkin so that we can see what bugs have been fix=
ed.=20
> We also track the files checked in the bug tracking software to. Thus=
=20
> giving us a two way linkage between repository and the bug tracking=20
> system. This is VERY useful. And I was wondering if there are any=20
> thought to this for commits.
>=20
> Now, I will be honest it is possible that this has already been done =
(I=20
> have not read all the documentation yet) and I am justing wasting=20
> bandwidth. In which, please excuse my ignorance and tell me to just R=
TFM.
>=20
> Paul Franz
>=20

We use the convention of putting the bug number as the first work on th=
e first line of
the checkin, e.g. "3399 Add attributes for commits". The advantage over=
 other methods
is that it is always there, without the need to further investigations =
of assigned attributes.

This convention has nothing to do with Git though. It works with any ty=
pe of repo.

-- robin
