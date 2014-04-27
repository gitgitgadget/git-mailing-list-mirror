From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Recording the current branch on each commit?
Date: Sun, 27 Apr 2014 10:51:00 +0200 (CEST)
Message-ID: <1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com>
References: <535C47BF.2070805@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 10:57:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeKuD-00055h-Vz
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 10:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbaD0I5j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Apr 2014 04:57:39 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:50091 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbaD0I5B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2014 04:57:01 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Apr 2014 04:57:01 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 91C1F81567;
	Sun, 27 Apr 2014 10:51:04 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 2WGEYYDP3z2I; Sun, 27 Apr 2014 10:51:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 8621581585;
	Sun, 27 Apr 2014 10:51:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oafh1xcYJLkZ; Sun, 27 Apr 2014 10:51:00 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 65B6481567;
	Sun, 27 Apr 2014 10:51:00 +0200 (CEST)
In-Reply-To: <535C47BF.2070805@game-point.net>
X-Originating-IP: [78.69.107.197]
X-Mailer: Zimbra 8.0.7_GA_6020 (ZimbraWebClient - FF28 (Mac)/8.0.7_GA_6020)
Thread-Topic: Recording the current branch on each commit?
Thread-Index: OMKlHWiV/0Fa73QOtclPwCCxgZiGaw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247196>



----- Ursprungligt meddelande -----
> Fr=C3=A5n: "Jeremy Morton" <admin@game-point.net>
> Till: git@vger.kernel.org
> Skickat: s=C3=B6ndag, 27 apr 2014 1:56:47
> =C3=84mne: Recording the current branch on each commit?
>=20
> Currently, git records a checksum, author, commit date/time, and comm=
it
> message with every commit (as get be seen from 'git log').  I think i=
t
> would be useful if, along with the Author and Date, git recorded the
> name of the current branch on each commit.  The branch name can provi=
de
> useful contextual information.  For instance, let's say I'm developin=
g a
> suite of games.  If the commit message says "Added basic options
> dialog", it might be useful to see that the branch name is
> "pacman-minigame" indicating that the commit pertains to the options
> dialog in the Pacman minigame.  Basically, I'm saying that well-named
> branches can and do carry useful contextual information that oughtn't=
 to
> be thrown away.  Currently, when you delete that branch, you lose the
> branch name altogether.
>=20
> So what do you think?  Would it be good to have a patch to add this f=
eature?

Branch names are usually poorly named, so often you don't lose much. On=
e way
some people to is to always merge with --no-ff, that way you see the br=
anch
name in the merge commit.=20

A very popular way of tracking context is to add some id, such as a bug=
zilla issue
number, to the header or footer of the commit message. Often a branch c=
ontains many
issues, but the branch itself isn't very interesting. Tools like gitbli=
t, gitweb,
gerrit etc can easily be configured to link to the issue using a regula=
r expression.

-- robin
