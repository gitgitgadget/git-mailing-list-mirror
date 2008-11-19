From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: removing svn remotes
Date: Wed, 19 Nov 2008 09:32:19 +0100
Message-ID: <20081119083219.GB3538@atjola.homenet>
References: <1c5969370811181747i240ed22bk73ca62e09b3d0172@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 09:33:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2iVK-0002Nq-Nm
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 09:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbYKSIcW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Nov 2008 03:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbYKSIcW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 03:32:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:32982 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751867AbYKSIcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 03:32:22 -0500
Received: (qmail invoked by alias); 19 Nov 2008 08:32:20 -0000
Received: from i577BAED4.versanet.de (EHLO atjola.local) [87.123.174.212]
  by mail.gmx.net (mp007) with SMTP; 19 Nov 2008 09:32:20 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18sGvMsA0EsxuyfuOClT4QufUf1sDJ9fSgtJ4q/gd
	2owcvFB0XY6HbZ
Content-Disposition: inline
In-Reply-To: <1c5969370811181747i240ed22bk73ca62e09b3d0172@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101316>

On 2008.11.18 20:47:24 -0500, Matt Graham wrote:
> Hi,
> I have a svn repo cloned into a git repo.  There are several remote
> refs that are there that I don't care about and don't want to fetch.
>=20
> git svn fetch --fetch-all gets a bunch of stuff from branches I don't=
 want
> git svn fetch requires I checkout the branches I care about before fe=
tching
>=20
> git svn fetch doesn't accept a branch name
> git remote rm isn't able to see the svn remotes
>=20
> Is there a way to either:
> 1) get rid of the svn remotes that I don't want?
> 2) fetch only the remotes that I do want?

Uhm, are you talking about remote tracking branches (what "git branch
-r" shows), or svn-remotes (not sure if git-svn can list them, they're
in .git/config)?

The behaviour you describe doesn't match my experience with git-svn, so
maybe you could elaborate a bit on the exact problem?

Thanks,
Bj=F6rn
