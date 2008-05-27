From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: cvsimport in cron
Date: Tue, 27 May 2008 13:08:45 +0200
Message-ID: <g1gq3u$jb$1@ger.gmane.org>
References: <17476529.post@talk.nabble.com>	 <46a038f90805261613v4ad72ddcxe6ee78fa0b54f89e@mail.gmail.com> <ce7555260805270345x353cfc76ja3f7ec83a0ab5c61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 13:09:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0x3w-0008R4-SD
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 13:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784AbYE0LJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2008 07:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756375AbYE0LJA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 07:09:00 -0400
Received: from main.gmane.org ([80.91.229.2]:35797 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756115AbYE0LJA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 07:09:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K0x30-0004Yp-VB
	for git@vger.kernel.org; Tue, 27 May 2008 11:08:54 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 May 2008 11:08:54 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 May 2008 11:08:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <ce7555260805270345x353cfc76ja3f7ec83a0ab5c61@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83005>

Barra Mac Math=FAna venit, vidit, dixit 27.05.2008 12:45:
> Thanks Martin,
>=20
> Nice to know how to log the progress! Good tip to try normal cvs over
> ssh, which works fine.
>=20
> I wish it was possible to get more verbose output from the git
> cvsimport command. The connection refused error seems to me to be
> misleading. I would expect at least some output from cvsps but it
> doesn't even get to the first step.
>=20
> So if everything works at the command line, what significant things
> can be different in a cron job?

The environment! Put "env" in your cron job and compare the output to=20
"env" on the command line. cvs or cvsps may be in $PATH on the command=20
line but not in cron, or $PERL5LIB might be different.

Cheers,
Michael
