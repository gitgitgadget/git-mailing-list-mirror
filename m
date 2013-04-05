From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] Documentation/git-commit: reword the --amend explanation
Date: Fri, 05 Apr 2013 10:50:05 +0200
Message-ID: <1365151805.2478.25.camel@flaca.cmartin.tk>
References: <1364994441-15961-1-git-send-email-cmn@elego.de>
	 <7v4nfn7j5i.fsf@alter.siamese.dyndns.org>
	 <7vtxnn4c02.fsf@alter.siamese.dyndns.org>
	 <50CA4F4141DD484D97CA8BA571529F65@PhilipOakley>
	 <1365094159.30466.60.camel@centaur.cmartin.tk>
	 <7va9pejkgt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 10:56:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UO2S9-0005cQ-6e
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 10:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161329Ab3DEI4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Apr 2013 04:56:22 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:39990 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab3DEI4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 04:56:20 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Apr 2013 04:56:20 EDT
Received: from [10.10.10.247] (i59F7870A.versanet.de [89.247.135.10])
	by hessy.dwim.me (Postfix) with ESMTPSA id 6CC16814C6;
	Fri,  5 Apr 2013 10:50:06 +0200 (CEST)
In-Reply-To: <7va9pejkgt.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220159>

On Thu, 2013-04-04 at 10:04 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > On Wed, 2013-04-03 at 23:25 +0100, Philip Oakley wrote:
> >
> >>  + Replace the tip of the current branch with a fresh commit.
> >> [or updated commit, or new commit, or ...]
> >
> > Ack, we should lead with the goal, I'd go for the
> >
> >     "Replace the tip of the current branch with a new commit"
> >
> > wording.
>=20
> We would want to be careful to make sure that the reader understands
> that the "new commit" is created by running this command (i.e. it is
> not like "git branch -f $current_branch $new_commit"), but other
> than that, sounds sensible.
>=20
> Perhaps like this?
>=20
>  Documentation/git-commit.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index bc919ac..61266d8 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -190,8 +190,8 @@ OPTIONS
>  	without changing its commit message.
> =20
>  --amend::
> -	Create a new commit and replace the tip of the current
> -	branch. The recorded tree is prepared as usual (including
> +	Replace the tip of the current branch by creating a new
> +	commit. The recorded tree is prepared as usual (including
>  	the effect of the `-i` and `-o` options and explicit
>  	pathspec), and the message from the original commit is used
>  	as the starting point, instead of an empty message, when no
>=20

Looks good, yeah. This should stop anybody thinking that they can
replace the tip with an arbitrary commit.

   cmn
