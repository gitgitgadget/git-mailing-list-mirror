From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git clone operation
Date: Sun, 17 Aug 2008 21:38:33 +0200
Message-ID: <20080817193833.GA29469@atjola.homenet>
References: <20080817184443.GA11782@mg1.gantsfort.com> <m3wsifsawl.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Gant <mwgant@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 21:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUo6G-0001Th-BN
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 21:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYHQTih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2008 15:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYHQTih
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 15:38:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:34191 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751149AbYHQTig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 15:38:36 -0400
Received: (qmail invoked by alias); 17 Aug 2008 19:38:34 -0000
Received: from i577BAD8D.versanet.de (EHLO atjola.local) [87.123.173.141]
  by mail.gmx.net (mp005) with SMTP; 17 Aug 2008 21:38:34 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18pafYQ4f4pZVzHkNzf6t6nNGXUVEeb3tpD/mtX/6
	yqthpXqfCzNQHr
Content-Disposition: inline
In-Reply-To: <m3wsifsawl.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92621>

On 2008.08.17 12:23:57 -0700, Jakub Narebski wrote:
> Mike Gant <mwgant@gmail.com> writes:
> > I realize that I can create a new local branch that is based off th=
e
> > desired branch:
> >=20
> > $ git-checkout -b master origin/master
> >=20
> > Is this the accepted method for obtaining the desired branch?
>=20
> You can use (with new anough Git)
>=20
>   $ git checkout --track -b master origin/master
>=20
> to setup repository in such way that "git pull" on 'master'
> would know that it is meant to fetch from 'origin' and merge
> 'origin/master'.

branch.autosetupmerge is set to true by default, so for remote branches
--track is the default anyway (since 1.5.5 IIRC). So only an old enough
git would actually require --track, unless you changed the config ;-)

Bj=F6rn
