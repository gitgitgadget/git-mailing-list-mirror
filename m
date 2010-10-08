From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Alternate .gitignore
Date: Fri, 8 Oct 2010 21:39:01 +0000 (UTC)
Message-ID: <loom.20101008T225637-152@post.gmane.org>
References: <loom.20101008T141929-221@post.gmane.org> <AANLkTimG188_8qg-DTtJtvX-wkpotgp7+f8Bu4b4ayMn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 23:39:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Ker-0004Gz-KI
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 23:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab0JHVjM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 17:39:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:40304 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729Ab0JHVjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 17:39:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P4Kek-0004Fb-Vs
	for git@vger.kernel.org; Fri, 08 Oct 2010 23:39:11 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 23:39:10 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 23:39:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.62)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158543>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab <at> gmail.com> writes:

> Have you looked into storing your binaries in a git-submodule(1) ?

I've look at it just now and it doesn't seem to be the thing I need. Ac=
cording=20
to my very basis understanding submodules seem to be useful for embeddi=
ng other=20
projects, but I'm working with a single project only. I'm speaking abou=
t a=20
single project and need to store it in different repositories at differ=
ent=20
"ignorance levels".

To make it clear, just imagine that compilation would be many thousand =
times=20
slower. In such a case you could prefer to store the history of the *.o=
 files as=20
well, but you'd still want to avoid the pollution of the source tree. S=
o you'd=20
maybe use .git for the sources as usually and .git2 (or whatever) for t=
he object=20
files (maybe together with the sources). This comes very close to my si=
tuation.

I could switch to using .git2 using $GIT_DIR, but with "*.o" in my .git=
ignore I=20
see no way how to include the ignored files. Maybe I could use $GIT_DIR=
/info/
exclude somehow instead of .gitignore, but this could be quite cumberso=
me.
