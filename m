From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch
 head'
Date: Tue, 27 Sep 2011 17:49:20 +0200
Message-ID: <4E81F080.7010905@drmicha.warpmail.net>
References: <1316960136073-6829212.post@n2.nabble.com>            <1316961212.4388.5.camel@centaur.lab.cmartin.tk>            <7vaa9r2jii.fsf@alter.siamese.dyndns.org>            <1317073309.5579.9.camel@centaur.lab.cmartin.tk> <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmll?= =?UTF-8?B?dG8=?= 
	<cmn@elego.de>, vra5107 <venkatram.akkineni@gmail.com>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 17:49:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ZuS-000461-VY
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 17:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997Ab1I0PtY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 11:49:24 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36103 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750741Ab1I0PtX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 11:49:23 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 35076250DA;
	Tue, 27 Sep 2011 11:49:23 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 27 Sep 2011 11:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=LKIMAamHh6m4sO+rQpHqZY
	jkKDg=; b=JHwl0L/nNbipwRtc/y82DlLiI374m+O391LTvbI0vL+pQYB6XuIafs
	dxIbzjW+mNqaQozmyes8kP7Itk7giH2x07ASXWUCX+0Dof60bbiPxc0NMecZeYSF
	85AZw+gHd62VcVNMcHFYQVsFYXXXPQTjMW/8sxdPdKk8XjBpXeZNE=
X-Sasl-enc: XROR7qbr+myB2pYLtCdOcIlRkBpwHLNv7vmIzXsKTHo1 1317138562
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0D15C6C0195;
	Tue, 27 Sep 2011 11:49:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182244>

Michael Witten venit, vidit, dixit 27.09.2011 16:43:
> See:
>=20
>   Re: Can a git changeset be created with no parent
>   Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>   Message-ID: <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
>   http://article.gmane.org/gmane.comp.version-control.git/182170
>=20
> and:
>=20
>   git help glossary
>=20
> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
>  Documentation/git-checkout.txt |   13 +++++--------
>  1 files changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index c0a96e6..c963a0f 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -125,19 +125,16 @@ explicitly give a name with '-b' in such a case=
=2E
>  	below for details.
> =20
>  --orphan::
> -	Create a new 'orphan' branch, named <new_branch>, started from
> -	<start_point> and switch to it.  The first commit made on this
> -	new branch will have no parents and it will be the root of a new
> -	history totally disconnected from all the other branches and
> -	commits.
> +	Tell git to make the next commit you make a root commit referenced =
by
> +	the branch head <new_branch>.

I recall objecting to the name "--orphan" (to no avail) because the
first commit is the root commit and there is no "orphan branch nor
"parent branch"...

In any case, I think the above is indeed an improvement, but I would
keep at least something which connects to the misnamed option, e.g.

=2E..root commit (i.e. without parents) referenced by...

>  +
>  The index and the working tree are adjusted as if you had previously=
 run
>  "git checkout <start_point>".  This allows you to start a new histor=
y
> -that records a set of paths similar to <start_point> by easily runni=
ng
> +that records a set of paths similar to <start_point> by just running
>  "git commit -a" to make the root commit.

"similar" is an understatement here, maybe "as in"?

>  +
> -This can be useful when you want to publish the tree from a commit
> -without exposing its full history. You might want to do this to publ=
ish
> +This can be useful when you want to publish a tree without exposing =
its
> +full history; for instance, you might want to do this to publish
>  an open source branch of a project whose current tree is "clean", bu=
t
>  whose full history contains proprietary or otherwise encumbered bits=
 of
>  code.

+1 ;)

Michael
