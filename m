From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git-cvsexportcommit and commit date
Date: Sun, 10 Feb 2008 14:15:00 +0100
Message-ID: <200802101415.00726.robin.rosenberg.lists@dewire.com>
References: <OFFF18703C.5539A99A-ON852573E7.00699FE4-852573E7.006A0F3E@db.com> <5f4b18bf0802092201i24f7de39o3fea28823621fdd1@mail.gmail.com> <5f4b18bf0802092213r4bd1df2ap7d2649dd9251fbb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Derek Mahar" <derek.mahar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 14:16:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOC2K-0004Op-L0
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 14:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbYBJNPH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 08:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbYBJNPG
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 08:15:06 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12434 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbYBJNPF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 08:15:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 56C908006AB;
	Sun, 10 Feb 2008 14:15:03 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EIuGkzzDdX9w; Sun, 10 Feb 2008 14:15:02 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id BBE40800687;
	Sun, 10 Feb 2008 14:15:02 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <5f4b18bf0802092213r4bd1df2ap7d2649dd9251fbb7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73352>

s=F6ndagen den 10 februari 2008 skrev Derek Mahar:
> On Feb 10, 2008 1:01 AM, Derek Mahar <derek.mahar@gmail.com> wrote:
> > On Feb 10, 2008 12:45 AM, Robin Rosenberg
> > <robin.rosenberg.lists@dewire.com> wrote:
> > > git rebase will drop those "empty" commits by default and you'll =
end up with the
> > > cvs-imported version.
> >
> > How do I perform this rebase if the empty commit is on the same
> > branch, say the master branch, as the original CVS landed commit?  =
I
> > attempted such a git-rebase using 1.5.4, but, iirc, git-rebase
> > responded that the branch was already up-to-date.
>=20
> On second thought, I don't recall with what message git-rebase
> responded, but I do recall that the commit was still on the master
> branch.

As I recall it (I'm using fromcvs, not git-cvsimport) cvs HEAD get impo=
rted
into origin which on initial import gets copied to master. So I think y=
ou
should git rebase origin

-- robin
