From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: git-gui messes up the diff view on non ASCII characters
Date: Fri, 9 Nov 2007 22:30:37 +0100
Message-ID: <200711092230.37905.barra_cuda@katamail.com>
References: <20071109154935.GC28800@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Baumann <waste.manager@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 22:25:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqbMP-0005fd-4P
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 22:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbXKIVZg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 16:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbXKIVZg
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 16:25:36 -0500
Received: from slim-3a.inet.it ([213.92.5.124]:36056 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754705AbXKIVZf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 16:25:35 -0500
Received: from host127-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.127]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.127+X8kdjdfwxao; Fri, 09 Nov 2007 22:25:32 +0100
User-Agent: KMail/1.9.7
In-Reply-To: <20071109154935.GC28800@xp.machine.xx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64262>

On Friday 09 November 2007, Peter Baumann wrote:
> I'm managing some UTF-8 encoded LaTeX files in git, which include som=
e
> non ASCII characters like the german =E4,=F6 and =FC. If I view the d=
iff with
> git-diff on an UTF8 enabled terminal, all looks nice. So does the dif=
f
> view in gitk after I commited my changes. Only git-gui shows some
> "strange" characters, so I assume it is an encoding problem.
>=20
> I have to admit that I'm totally unaware how this should work, but at
> least I think my configuration is correct here, because otherwise git=
-diff
> or gitk would show the same behaviour. Is there anything which could =
be
> done to make git-gui happy, too?

It's a known issue, and already on Shawn's ToDo list. I have to add tha=
t
viewing untracked UTF8 files in git-gui works just fine. Weird.
