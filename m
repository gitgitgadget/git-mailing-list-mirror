From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git push won't push to a local branch
Date: Sun, 4 May 2008 21:19:36 +0200
Message-ID: <20080504191936.GA3119@atjola.homenet>
References: <7f9d599f0805041149w1955138crf269853196391e51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Sun May 04 21:20:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsjl7-0007OV-PR
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 21:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbYEDTTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 15:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754858AbYEDTTm
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 15:19:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:36006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754279AbYEDTTl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 15:19:41 -0400
Received: (qmail invoked by alias); 04 May 2008 19:19:38 -0000
Received: from i577B991F.versanet.de (EHLO atjola.local) [87.123.153.31]
  by mail.gmx.net (mp018) with SMTP; 04 May 2008 21:19:38 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19rnVl8MTBrtcncHcoKiACq+TnjAZACmT1Xy/nP0f
	hNhdX3EhmcJluP
Content-Disposition: inline
In-Reply-To: <7f9d599f0805041149w1955138crf269853196391e51@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81191>

On 2008.05.04 11:49:38 -0700, Geoffrey Irving wrote:
> Hello,
>=20
> There's an asymmetry between push and pull that seems unnecessary:
> pull can pull from local branches, but push can't push to them.  Is
> there a reason for this asymmetry?
>=20
> In more detail, if I have a working copy with two branches, local and
> master, I can use git pull to pull changes from master to local:
>=20
> % git checkout local
> % git pull . master
> ... pulls changes from master to local branch
>=20
> If I make a change in local and try to do the reverse with git push,
> it gives a confusing non-error message and doesn't do anything:
>=20
> % git checkout local
> % git rm scratch/pcomm.h
> % git commit
> % git push . master
> Everything up-to-date

You're pushing master to master ;-) Try "git push . local:master".

Bj=F6rn
