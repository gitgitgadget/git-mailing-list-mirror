From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Tue, 31 May 2016 16:33:20 +0200
Message-ID: <vpqy46qs3f3.fsf@anie.imag.fr>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org>
	<1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: philipoakley@iee.org, gitster@pobox.com, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	tom.russello@grenoble-inp.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Tue May 31 16:34:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7kk3-0008A0-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 16:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbcEaOdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 10:33:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55164 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765AbcEaOde (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 10:33:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4VEXJ8N012240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 31 May 2016 16:33:19 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4VEXKHt032121;
	Tue, 31 May 2016 16:33:20 +0200
In-Reply-To: <1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	(Jordan DE's message of "Tue, 31 May 2016 14:28:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 31 May 2016 16:33:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4VEXJ8N012240
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465310003.59206@YSdJguQ8hRwI3no9WRYLEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295977>

[ +Cc Michael Haggerty ]

Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:

> Currently, Triangular Workflow can be configured, but there is no
> Documentation about it. A documentation is useful to keep
> configuration possibilities up-to-date.

You're using capitalization in a strange way. I don't think Triangular
Workflow deserves to be capitalized, and Documentation certainly
doesn't.

Also, you're wrapping your text in a strange way. You did see the
exchange with Antoine about this, right?

A question about your final goal: I had understood that you wanted to
improve the UI, and to design a proper UI you wanted to write a tutoria=
l
about the future UI, and then implement it. Did I mis-understand? What
are the next steps in your plan?

>  Documentation/Makefile                  |   1 +
>  Documentation/gittriangularworkflow.txt | 120 ++++++++++++++++++++++=
++++++++++
[...]
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -34,6 +34,7 @@ MAN7_TXT +=3D gitrevisions.txt
>  MAN7_TXT +=3D gittutorial-2.txt
>  MAN7_TXT +=3D gittutorial.txt
>  MAN7_TXT +=3D gitworkflows.txt
> +MAN7_TXT +=3D gittriangularworkflow.txt

Adding documentation is one thing, but it needs to be discoverable. No
one is going to type "man gittriangularworkflow" or open
https://git-scm.com/docs/gittriangularworkflow without being told to.

Two obvious questions/suggestions seeing the above:

* Why not add the new documentation as a subsection of gitworkflows.txt=
?

* If not, then at the very least a link to gittriangularworkflow should
  appear in the SEE ALSO section of gitworkflows.txt.

> +DESCRIPTION
> +-----------
> +
> +Triangular Workflow (or Asymmetric Workflow) is a workflow which giv=
es
> +the possibility to:
> +
> +- fetch (or pull) from a repository
> +- push to another repository

I wouldn't say "gives the possibility to": you already have this
possibility all the time when using Git.

I find Michael Haggerty's definition of triangular workflow much
clearer:

https://github.com/blog/2042-git-2-5-including-multiple-worktrees-and-t=
riangular-workflows#improved-support-for-triangular-workflows

I don't see a licence on the GitHub blog, so I don't think it's legal t=
o
copy-past directly to our docs, but Michael might allow us to do so?

> +In some projects, you don't have to push directly

s/don't have to/cannot/

?

> +Here is an example of configuration:
> +
> +........................................
> +------------               -----------
> +| UPSTREAM |  maintainer   | ORIGIN  |
> +|  git/git |- - - - - - - -|  me/git |
> +------------       =E2=86=90       -----------
> +         \                   /
> +          \                 /
> +     fetch=E2=86=93\               /=E2=86=91push
> +            \             /
> +             \           /
> +             -------------
> +             |   LOCAL   |
> +             -------------
> +........................................

The most important is missing: what is the role of each repo? which one
is public and which one is private?

I'd rather avoid using "ORIGIN" here, as the name is used for the
default remote when cloning, and it's a valid workflow to "git clone"
from UPSTREAM and then "git remote add" your public fork. Perhaps
PUBLIC-FORK?

> +CREATE YOUR REPOSITORY
> +----------------------
> +The first step is to create your own repository. To do that you can:
> +
> +- a. fork (e.g. GitHub) the main project (e.g git/git), or
> +- b. create an empty repository
> +
> +a. Fork the project
> +~~~~~~~~~~~~~~~~~~~
> +Go to the repository of the project (e.g. git/git) you want
> +and fork it.
> +
> +b. Create from scratch
> +~~~~~~~~~~~~~~~~~~~~~~
> +Create a repository on your prefered Git repository hosting service.
> +
> +Clone it
> +~~~~~~~~
> +Clone your repository on your machine.

I don't think this section helps much. If the user knows that he or she
wants to "fork (e.g. GitHub) the main project (e.g git/git),", then
saying

  +a. Fork the project
  +~~~~~~~~~~~~~~~~~~~
  +Go to the repository of the project (e.g. git/git) you want
  +and fork it.

does not help at all, it just says the same thing in a more verbose way=
=2E

> +CONFIGURE BRANCHES
> +------------------
> +In many projects, the branch `master` have to be pulled from
> +the main repository(e.g. git/git) and pushed to your repository
> +(e.g. me/git).

Be precise: you just named 3 repositories UPSTREAM, ORIGIN and LOCAL,
and now you're writting "the main repository" (not 100% clear) and "you=
r
repository" (100% not clear, you have two repos).

Actually, most of the time, you'd pull from UPSTREAM/master and push to
PUBLIC-FORK/<topic-branch>, not PUBLIC-FORK/master.

> +Adding the main project remote
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Add a new remote (e.g. upstream):
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git remote add upstream <main_project_url>`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Pull from upstream by default
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git config branch.master.remote upstream`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +Push to origin by default
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git config branch.master.pushRemote origin`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

"by default" probably needs to be clarified ("when push/pull is called
without argument"?)

> +GET YOUR PROJECT UP TO DATE
> +---------------------------
> +
> +Now that `branch.master.remote` and `branch.master.pushRemote` are
> +set, you can use the following commands to be up to date:

What does "be up to date" mean?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
