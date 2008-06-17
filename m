From: Galder Zamarreno <galder.zamarreno@redhat.com>
Subject: [egit-jgit] excluded patterns are decorated as being untracked
Date: Tue, 17 Jun 2008 18:43:12 +0200
Message-ID: <4857E9A0.7070408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 18:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8eHz-0007hC-Ly
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 18:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbYFQQnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2008 12:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753763AbYFQQnR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 12:43:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54240 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666AbYFQQnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 12:43:16 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5HGhFjg002365
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 12:43:15 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5HGhFAe011053
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 12:43:15 -0400
Received: from dhcp-144-245.gva.redhat.com (dhcp-144-245.gva.redhat.com [10.33.144.245])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5HGhDuZ032235
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 12:43:14 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85313>

Hi,

I've been using egit for a few weeks and firstly, I'd like to thank the=
=20
people involved in the project for the work done so far.

There's one thing that has been bugging me about egit though which is=20
related to the decoration of untracked files. Egit/JGit does not seem t=
o=20
pay attention to .git/info/exclude that I have configured so that=20
anything under output folder is excluded.

Egit/JGit does seem to have decorations working fine for patterns=20
specified in "Team/Ignored Resources" but it only applies it to files=20
not folders, hence, adding "output" as pattern does not work and=20
instead, I have to specify any pattern that would match a file within=20
the output folder which is not practical. Folders are taken into accoun=
t=20
as ignored resources in subeclipse (subversion eclipse plugin)

I can see two ways of implementing this that I'm happy to have a look=20
into but I wanted to get some advice from the experts of egit/jgit to=20
indicate which would be the preferred solution going forward.

1.- Implement .git/info/exclude functionality in egit/jgit

2.- Improve the decoration handling in jgit/egit so that it can check=20
whether the file is under a pattern that should be excluded. I tried to=
=20
implement this but requires using API that eclipse considers internal.

What do people think? Should I bother with 2 or is it better to=20
implement decorations for patterns in .git/info/exclude correctly?

Thanks!
--=20
Galder Zamarre=F1o
Sr. Software Maintenance Engineer
JBoss, a division of Red Hat
