From: Peter Baumann <waste.manager@gmx.de>
Subject: git-gui messes up the diff view on non ASCII characters
Date: Fri, 9 Nov 2007 16:49:35 +0100
Message-ID: <20071109154935.GC28800@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:50:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqW7z-00080m-10
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 16:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104AbXKIPuX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 10:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760196AbXKIPuX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 10:50:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:51459 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753098AbXKIPuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 10:50:22 -0500
Received: (qmail invoked by alias); 09 Nov 2007 15:49:58 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp027) with SMTP; 09 Nov 2007 16:49:58 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19nvPVTPbpn3Ojhir92WgB2x3ik133ysOmu6yYayF
	5fOQ3OGH+uPHfB
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64203>

I'm managing some UTF-8 encoded LaTeX files in git, which include some
non ASCII characters like the german =E4,=F6 and =FC. If I view the dif=
f with
git-diff on an UTF8 enabled terminal, all looks nice. So does the diff
view in gitk after I commited my changes. Only git-gui shows some
"strange" characters, so I assume it is an encoding problem.

I have to admit that I'm totally unaware how this should work, but at
least I think my configuration is correct here, because otherwise git-d=
iff
or gitk would show the same behaviour. Is there anything which could be
done to make git-gui happy, too?

-Peter
