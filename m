From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Minor bug in bash completion
Date: Wed, 30 Dec 2009 18:59:38 +0100
Message-ID: <1262195978.3552.4.camel@kheops>
References: <4B3A140A.60302@steek.com>  <20091230112222.GA493@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 19:10:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ2zw-000685-Rg
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 19:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbZL3SKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 13:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbZL3SKJ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 13:10:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:41817 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbZL3SKI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 13:10:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NQ2zk-00062i-Pd
	for git@vger.kernel.org; Wed, 30 Dec 2009 19:10:04 +0100
Received: from smj33-1-82-233-66-33.fbx.proxad.net ([82.233.66.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 19:10:04 +0100
Received: from sylvain by smj33-1-82-233-66-33.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 19:10:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: smj33-1-82-233-66-33.fbx.proxad.net
In-Reply-To: <20091230112222.GA493@neumann>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135913>

On Wed, 2009-12-30 at 12:22 +0100, SZEDER G=C3=A1bor wrote:
> Hi Sylvain,
>=20
>=20
> On Tue, Dec 29, 2009 at 03:36:58PM +0100, Sylvain RABOT wrote:
> > I found a bug in the git bash completion.
> > It occurs when I press tab to complete branch name when I want to p=
ull =20
> > from the origin.
> > Instead of completing the branch name it prompts me directly for my=
 =20
> > password on the origin remote.
>=20
> I don't think it's a bug.  The completion script should offer the
> currently available refs in the remote repository after a 'git pull
> <remote> <TAB>'.  In order to do that it contacts the remote
> repository for the list of refs available there.  Depending on the
> access method, it might need to authenticate, in your case via ssh.
> To silence the password prompts you should change your ssh
> configuration to use key-based authentication when logging in to the
> remote repository's server (just google for 'ssh login without
> password').
>=20
>=20
> Best,
> G=C3=A1bor

Haaa,

I understand now, tough, I thought that the list of origin's branches
where stored somewhere in my local repository and that I needed to do a
"git remote update origin" to get the current origin branches list.

Thanks for your answer.

Regards.

--=20
Sylvain Rabot <sylvain@abstraction.fr>
