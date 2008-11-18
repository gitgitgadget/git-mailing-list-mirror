From: Francis Galiegue <fge@one2team.com>
Subject: Re: Git commit won't add an untracked file given on the command line
Date: Tue, 18 Nov 2008 22:27:19 +0100
Organization: One2team
Message-ID: <200811182227.20076.fge@one2team.com>
References: <20081118211237.234d8035@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:31:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2YA5-0008IZ-FO
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 22:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbYKRV3v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Nov 2008 16:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbYKRV3v
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 16:29:51 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:57681 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbYKRV3u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 16:29:50 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 71BBA92C002;
	Tue, 18 Nov 2008 22:29:37 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id 43F317001F;
	Tue, 18 Nov 2008 22:29:48 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081118211237.234d8035@crow>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101288>

Le Tuesday 18 November 2008 22:12:37 Mark Burton, vous avez =E9crit=A0:
> Hi,
>
> When I try:
>
> git commit -m "New file." .gitignore
>
> Where .gitignore is not yet tracked, I get:
>
> error: pathspec '.gitignore' did not match any file(s) known to git.
>
> Is that result by design, sloth or bug (or me being stupid)?
>

You must "git add .gitignore" first. And yes, this is by design.

You could also have done git commit -a -m "themessage".

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
