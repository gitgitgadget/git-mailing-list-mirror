From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v4] Docs: git checkout --orphan: Copyedit,                          and s/root commit/orphan branch/
Date: Thu, 29 Sep 2011 21:05:49 +0100
Organization: OPDS
Message-ID: <D739CCF9818B4A22ACB654C33BCCB75F@PhilipOakley>
References: <1316960136073-6829212.post@n2.nabble.com>            <1316961212.4388.5.camel@centaur.lab.cmartin.tk>            <7vaa9r2jii.fsf@alter.siamese.dyndns.org>            <1317073309.5579.9.camel@centaur.lab.cmartin.tk>            <vpq39fi9gf5.fsf@bauges.imag.fr>            <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>            <vpqsjni6kkk.fsf@bauges.imag.fr>            <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>            <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com>            <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>    <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <3cba6bb85bde4f96903b2b617190a2b8-mfwitten@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	"vra5107" <venkatram.akkineni@gmail.com>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Eric Raible" <raible@nextest.com>, "Jeff King" <peff@peff.net>,
	"Jay Soffian" <jaysoffian@gmail.com>, <git@vger.kernel.org>
To: "Michael Witten" <mfwitten@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 22:05:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9MrA-00030c-JB
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 22:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757067Ab1I2UFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 16:05:12 -0400
Received: from out1.ip08ir2.opaltelecom.net ([62.24.128.244]:8481 "EHLO
	out1.ip08ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756958Ab1I2UFL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 16:05:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhQFAGLOhE5cHKfw/2dsb2JhbABBhGWFTZ1neIFOAQQBAQUIAQEZDwEFHgEBIQsCAwUCAQMOBwUCBRoHAgIUAQQIEgYHFwYBEggCAQIDAYdhCqh6kWyBLIRVMWEEnXGHIA
X-IronPort-AV: E=Sophos;i="4.68,463,1312153200"; 
   d="scan'208";a="503708168"
Received: from host-92-28-167-240.as13285.net (HELO PhilipOakley) ([92.28.167.240])
  by out1.ip08ir2.opaltelecom.net with SMTP; 29 Sep 2011 21:05:08 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182428>

=46rom: "Michael Witten" <mfwitten@gmail.com>
> It's copyediting; it's best just to read the damn patch, particularly=
 when
> there are no subtle details to be considered beyond the exhausting ga=
me of
> making everybody involved in the email thread feel like he or she has=
=20
> gotten
> a portion of the bikeshed painted a certain color.
>
> See:
>
>  Re: Can a git changeset be created with no parent
>  Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>  Message-ID: <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
>
> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
> Documentation/git-checkout.txt |   69=20
> ++++++++++++++++++++++++++++-----------
> 1 files changed, 49 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/git-checkout.txt=20
> b/Documentation/git-checkout.txt
> index c0a96e6..bf042c2 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -125,29 +125,58 @@ explicitly give a name with '-b' in such a case=
=2E
>  below for details.
>
> ---orphan::
> - Create a new 'orphan' branch, named <new_branch>, started from
> - <start_point> and switch to it.  The first commit made on this
> - new branch will have no parents and it will be the root of a new
> - history totally disconnected from all the other branches and
> - commits.
> -+
> -The index and the working tree are adjusted as if you had previously=
 run
> -"git checkout <start_point>".  This allows you to start a new histor=
y
> -that records a set of paths similar to <start_point> by easily runni=
ng
> -"git commit -a" to make the root commit.
> -+
> -This can be useful when you want to publish the tree from a commit
> -without exposing its full history. You might want to do this to publ=
ish
> -an open source branch of a project whose current tree is "clean", bu=
t
> -whose full history contains proprietary or otherwise encumbered bits=
 of
> -code.
> -+
> -If you want to start a disconnected history that records a set of pa=
ths
> -that is totally different from the one of <start_point>, then you sh=
ould
> -clear the index and the working tree right after creating the orphan
> -branch by running "git rm -rf ." from the top level of the working t=
ree.
> -Afterwards you will be ready to prepare your new files, repopulating=
 the
> -working tree, by copying them from elsewhere, extracting a tarball, =
etc.
> +--orphan::
> + Perform these two tasks:
> ++
> +--
> + * Adjust the working tree and index as if you ran
> +   "git checkout <start_point>".
> +
> + * Set up git to turn the next commit you create into a root commit
> +   (that is, a commit without any parent); creating the next commit
> +   is similar to creating the first commit after running "git init",
> +   except that the new commit will be referenced by <new_branch>
> +   rather than "master".
> +--
> ++
> +Then, by just running "git commit", you can create a root commit
> +with a tree that is exactly the same as the tree of <start_point>.
> +Alternatively, before creating the commit, you may manipulate the
> +index in any way you want; for example, to create a root commit with
> +a tree that is totally different from the tree of <start_point>,
> +just clear the working tree and index first: From the top level of
> +the working tree, run "git rm -rf .", and then prepare your new
> +working tree and index as desired.
> ++
> +There are two common uses for this option:
> ++
> +--
> + Separate history::

Can I suggest    "Distinct History::"    as this title.
'separate' is both a verb and a noun, and it is easy to misread the tit=
le as=20
if it is the verb, which would then be describing the action of creatin=
g the=20
hidden history (the second title), with resulting misunderstanding.=20
"Distinct" avoids the problem. The use of 'seperate' at the end is in=20
context,  so not an issue.

> + Suppose that for convenience, you want to maintain
> + in the same repository as your project some ancillary
> + material that is infrequently altered.  In such a case,
> + it may not make much sense to interleave the history of
> + that material with the history of your project; you can
> + use the "--orphan" option in order to create completely
> + separate histories.
> +
> + Hidden history::
> + Suppose you have a project that has proprietary
> + material that is never meant to be released to the
> + public, yet you now want to maintain an open source
> + history that may be published widely.
> ++
> +In this case, it would not be enough just to remove the proprietary
> +material from the working tree and then create a new commit, because
> +the proprietary material would still be accessible through the new
> +commit's ancestry; the proprietary history must be hidden from the n=
ew
> +commit, and the "--orphan" option allows you to do so by ensuring th=
at
> +the new commit has no parent.
> ++
> +However, when there are multiple commits that are already suitable f=
or
> +the open source history (or that you want to make suitable), you sho=
uld
> +instead consider working with linkgit:git-filter-branch[1] and possi=
bly
> +linkgit:git-rebase[1].
> +--
>
> -m::
> --merge::
> --=20
> 1.7.6.409.ge7a85
>
