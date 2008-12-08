From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Can someone confirm what the contents of refs/heads/master
	means?
Date: Mon, 8 Dec 2008 22:26:36 +0100
Message-ID: <20081208212636.GA6061@atjola.homenet>
References: <f78b0fcc-6165-440a-b76b-b1b0a281b15c@k8g2000yqn.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 22:28:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9ne2-00037z-0C
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 22:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbYLHV0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2008 16:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbYLHV0l
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 16:26:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:40027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752128AbYLHV0k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 16:26:40 -0500
Received: (qmail invoked by alias); 08 Dec 2008 21:26:37 -0000
Received: from i577B9E20.versanet.de (EHLO atjola.local) [87.123.158.32]
  by mail.gmx.net (mp057) with SMTP; 08 Dec 2008 22:26:37 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19qYW5nEEJq+XIWvuuojcHLzwwkAuctNCoXymtme7
	nQ6Wkb82QHua6u
Content-Disposition: inline
In-Reply-To: <f78b0fcc-6165-440a-b76b-b1b0a281b15c@k8g2000yqn.googlegroups.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102583>

On 2008.12.08 11:23:46 -0800, davetron5000 wrote:
> I'm using git-svn to interact with an SVN repo that has branches.
>=20
> After my clone via:
>=20
> git svn clone $REPO/main -T trunk -b branches -t tags
>=20
> my 'master' branch pointed to one of the branches in svn and not to
> the main trunk. (my .git/config looked correct for svn interaction,
> i.e. trunk pointed to the right place).

Just to clear up that bit as well. when the "fetch" finishes (which is
part of the clone process), git-svn checks if there is a master branch,
and if not, it creates one from the last commit it created. So if your
last svn commit was to branch XYZ and not to trunk, master will
reference that commit on branch XYZ.

Bj=F6rn
