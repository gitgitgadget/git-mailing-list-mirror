From: Alfonso =?utf-8?b?TXXDsW96LVBvbWVy?= Fuentes 
	<alfonso.munozpomer@vti.bund.de>
Subject: Ubuntu: gitweb always looks for projects in /var/cache/git =?utf-8?b?KOKAnDQwNA==?= - no projects =?utf-8?b?Zm91bmTigJ0p?=
Date: Thu, 29 Nov 2012 13:55:57 +0000 (UTC)
Message-ID: <loom.20121129T145320-133@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 15:00:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te4ex-0006IW-L7
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 15:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab2K2N74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2012 08:59:56 -0500
Received: from plane.gmane.org ([80.91.229.3]:48968 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852Ab2K2N74 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 08:59:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Te4er-0006DT-0P
	for git@vger.kernel.org; Thu, 29 Nov 2012 15:00:05 +0100
Received: from 134.110.105.105 ([134.110.105.105])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 15:00:05 +0100
Received: from alfonso.munozpomer by 134.110.105.105 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 15:00:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.110.105.105 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:17.0) Gecko/17.0 Firefox/17.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210834>

I=E2=80=99ve discovered this weird behaviour in gitweb and documented a=
 workaround in
StackOverflow:
http://stackoverflow.com/questions/13609475/ubuntu-gitweb-always-looks-=
for-projects-in-var-cache-git-404-no-projects-f

Basically, the variable $projectroot in gitweb.cgi in the beginning is =
reset to
the system default value in git_get_projects_list, when it is declared =
again.

Is this a known bug? Or am I missing something?
