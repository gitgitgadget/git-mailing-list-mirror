From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git svn rebase does not follow new svn tags and branches
Date: Tue, 1 Apr 2008 23:05:21 +0200
Message-ID: <20080401210521.GA20422@atjola.homenet>
References: <m28wzx5me4.fsf@rallydevelopment.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bob Cotton <bob.cotton@rallydev.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 23:08:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgnhp-0000tF-NH
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 23:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760234AbYDAVF2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Apr 2008 17:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761934AbYDAVF1
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 17:05:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:56397 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760872AbYDAVFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 17:05:25 -0400
Received: (qmail invoked by alias); 01 Apr 2008 21:05:22 -0000
Received: from i577B991D.versanet.de (EHLO atjola.local) [87.123.153.29]
  by mail.gmx.net (mp005) with SMTP; 01 Apr 2008 23:05:22 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/7ryxRGQb7k6i3sGVCUg/E19lOmZladRwoFtwtxo
	Vt+xRCf8sb+y9L
Content-Disposition: inline
In-Reply-To: <m28wzx5me4.fsf@rallydevelopment.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78665>

On 2008.04.01 14:51:47 -0600, Bob Cotton wrote:
>=20
> I've been using git-svn for several weeks. After replaying svn using
> git-svn clone and git-svn fetch, all branches and tags were replicate=
d
> in the git repo.
>=20
> Now, after a workflow that includes git-svn rebase, but no git-svn
> fetch(s), the new svn tags and branches are not being replicated.

git svn rebase only fetches the revisions that are required to do the
rebase, which speeds the process up quite a bit. Imagine you're working
on branch "foo" and trunk is quite active. If git svn rebase would
always fetch all the new revisions for trunk as well (which you might
not need right now), that could become quite annoying.

If you want all remote branches/tags (incl. trunk) to be updated, use
git svn fetch.

Bj=F6rn
