From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Documentation: git-svn: fix example for centralized SVN clone
Date: Sun, 9 Nov 2008 17:12:32 -0800
Message-ID: <20081110011232.GA11666@hand.yhbt.net>
References: <20081109230012.47adbb32@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: aroben@hand.yhbt.net, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Nov 10 02:14:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzLMU-00024g-9b
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 02:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757016AbYKJBMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2008 20:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756976AbYKJBMh
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 20:12:37 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43599 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756909AbYKJBMg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 20:12:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id ED6722DC01A;
	Mon, 10 Nov 2008 01:12:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081109230012.47adbb32@perceptron>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100484>

Jan Kr=FCger <jk@jk.gs> wrote:
> The example that tells users how to centralize the effort of the init=
ial
> git svn clone operation doesn't work properly. It uses rebase but tha=
t
> only works if HEAD exists. This adds one extra command to create a
> somewhat sensible HEAD that should work in all cases.
>=20
> Signed-off-by: Jan Kr=FCger <jk@jk.gs>
> ---
> I have a feeling this looks a bit ugly, but I can't think of a simple=
r
> solution (especially since we're not fetching the central repo's HEAD=
).
> Still, it's certainly better than a broken example.

*shrug*  Seems alright with me.

Adam wrote the original example, maybe he knows better.

>  Documentation/git-svn.txt |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 84c8f3c..ba94cd1 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -544,6 +544,8 @@ have each person clone that repository with 'git-=
clone':
>         git remote add origin server:/pub/project
>         git config --add remote.origin.fetch '+refs/remotes/*:refs/re=
motes/*'
>         git fetch
> +# Create a local branch from one of the branches just fetched
> +       git checkout -b master FETCH_HEAD
>  # Initialize git-svn locally (be sure to use the same URL and -T/-b/=
-t options as were used on server)
>         git svn init http://svn.example.com/project
>  # Pull the latest changes from Subversion
> --
> 1.6.0.3.578.g6a50

--=20
Eric Wong
