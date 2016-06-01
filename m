From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Wed, 1 Jun 2016 11:32:19 +0200
Message-ID: <2254CE50-8B7C-4FFF-BAA3-26EF1932AAD4@grenoble-inp.org>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org> <1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org> <vpqy46qs3f3.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 01 11:32:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b82WC-0005iz-V5
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 11:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757905AbcFAJco convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 05:32:44 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:36091 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028AbcFAJcY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 05:32:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7829C2136;
	Wed,  1 Jun 2016 11:32:20 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X0JSFUexhooh; Wed,  1 Jun 2016 11:32:20 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 5EF662135;
	Wed,  1 Jun 2016 11:32:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 5847A2077;
	Wed,  1 Jun 2016 11:32:20 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0G1Lq5is2n3J; Wed,  1 Jun 2016 11:32:20 +0200 (CEST)
Received: from eduroam-033124.grenet.fr (eduroam-033124.grenet.fr [130.190.33.124])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 0C9A32064;
	Wed,  1 Jun 2016 11:32:20 +0200 (CEST)
In-Reply-To: <vpqy46qs3f3.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296069>

> Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:
>> Currently, Triangular Workflow can be configured, but there is no
>> Documentation about it. A documentation is useful to keep
>> configuration possibilities up-to-date.
>=20
> You're using capitalization in a strange way. I don't think Triangula=
r
> Workflow deserves to be capitalized, and Documentation certainly
> doesn't.
>=20
> Also, you're wrapping your text in a strange way. You did see the
> exchange with Antoine about this, right?

Yes, thank you. I will fix that.=20

> A question about your final goal: I had understood that you wanted to
> improve the UI, and to design a proper UI you wanted to write a tutor=
ial
> about the future UI, and then implement it. Did I mis-understand? Wha=
t
> are the next steps in your plan?

The first goal is to write a documentation on "how to set up a triangul=
ar
workflow" with the current options. After that, we can discuss about th=
e
UI improvement.=20

>> Documentation/Makefile                  |   1 +
>> Documentation/gittriangularworkflow.txt | 120 ++++++++++++++++++++++=
++++++++++
> [...]
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -34,6 +34,7 @@ MAN7_TXT +=3D gitrevisions.txt
>> MAN7_TXT +=3D gittutorial-2.txt
>> MAN7_TXT +=3D gittutorial.txt
>> MAN7_TXT +=3D gitworkflows.txt
>> +MAN7_TXT +=3D gittriangularworkflow.txt
>=20
> Adding documentation is one thing, but it needs to be discoverable. N=
o
> one is going to type "man gittriangularworkflow" or open
> https://git-scm.com/docs/gittriangularworkflow without being told to.
>=20
> Two obvious questions/suggestions seeing the above:
>=20
> * Why not add the new documentation as a subsection of gitworkflows.t=
xt?
>=20
> * If not, then at the very least a link to gittriangularworkflow shou=
ld
>  appear in the SEE ALSO section of gitworkflows.txt.

Yes, adding a subsection in gitworkflows seems to be a better choice.

>=20
>> +DESCRIPTION
>> +-----------
>> +
>> +Triangular Workflow (or Asymmetric Workflow) is a workflow which gi=
ves
>> +the possibility to:
>> +
>> +- fetch (or pull) from a repository
>> +- push to another repository
>=20
> I wouldn't say "gives the possibility to": you already have this
> possibility all the time when using Git.
>=20
> I find Michael Haggerty's definition of triangular workflow much
> clearer:
>=20
> https://github.com/blog/2042-git-2-5-including-multiple-worktrees-and=
-triangular-workflows#improved-support-for-triangular-workflows
>=20
> I don't see a licence on the GitHub blog, so I don't think it's legal=
 to
> copy-past directly to our docs, but Michael might allow us to do so?

You=E2=80=99re right. Can Michael Taggerty allow us to use his text ?

>=20
>> +In some projects, you don't have to push directly
>=20
> s/don't have to/cannot/

Done

> ?
>=20
>> +Here is an example of configuration:
>> +
>> +........................................
>> +------------               -----------
>> +| UPSTREAM |  maintainer   | ORIGIN  |
>> +|  git/git |- - - - - - - -|  me/git |
>> +------------       =E2=86=90       -----------
>> +         \                   /
>> +          \                 /
>> +     fetch=E2=86=93\               /=E2=86=91push
>> +            \             /
>> +             \           /
>> +             -------------
>> +             |   LOCAL   |
>> +             -------------
>> +........................................
>=20
> The most important is missing: what is the role of each repo? which o=
ne
> is public and which one is private?
>=20
> I'd rather avoid using "ORIGIN" here, as the name is used for the
> default remote when cloning, and it's a valid workflow to "git clone"
> from UPSTREAM and then "git remote add" your public fork. Perhaps
> PUBLIC-FORK?

With Michael Taggerty=E2=80=99s text, it will be more understandable.=20

>=20
>> +CREATE YOUR REPOSITORY
>> +----------------------
>> +The first step is to create your own repository. To do that you can=
:
>> +
>> +- a. fork (e.g. GitHub) the main project (e.g git/git), or
>> +- b. create an empty repository
>> +
>> +a. Fork the project
>> +~~~~~~~~~~~~~~~~~~~
>> +Go to the repository of the project (e.g. git/git) you want
>> +and fork it.
>> +
>> +b. Create from scratch
>> +~~~~~~~~~~~~~~~~~~~~~~
>> +Create a repository on your prefered Git repository hosting service=
=2E
>> +
>> +Clone it
>> +~~~~~~~~
>> +Clone your repository on your machine.
>=20
> I don't think this section helps much. If the user knows that he or s=
he
> wants to "fork (e.g. GitHub) the main project (e.g git/git),", then
> saying
>=20
>  +a. Fork the project
>  +~~~~~~~~~~~~~~~~~~~
>  +Go to the repository of the project (e.g. git/git) you want
>  +and fork it.
>=20
> does not help at all, it just says the same thing in a more verbose w=
ay.

I will shorten for the next iteration.=20

>> +CONFIGURE BRANCHES
>> +------------------
>> +In many projects, the branch `master` have to be pulled from
>> +the main repository(e.g. git/git) and pushed to your repository
>> +(e.g. me/git).
>=20
> Be precise: you just named 3 repositories UPSTREAM, ORIGIN and LOCAL,
> and now you're writting "the main repository" (not 100% clear) and "y=
our
> repository" (100% not clear, you have two repos).
>=20
> Actually, most of the time, you'd pull from UPSTREAM/master and push =
to
> PUBLIC-FORK/<topic-branch>, not PUBLIC-FORK/master.
>=20
>> +Adding the main project remote
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +Add a new remote (e.g. upstream):
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +`git remote add upstream <main_project_url>`
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Pull from upstream by default
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +`git config branch.master.remote upstream`
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +
>> +Push to origin by default
>> +~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +`git config branch.master.pushRemote origin`
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> "by default" probably needs to be clarified ("when push/pull is calle=
d
> without argument =C2=BB?)

Yes, that is too verbose.=20

>=20
>> +GET YOUR PROJECT UP TO DATE
>> +---------------------------
>> +
>> +Now that `branch.master.remote` and `branch.master.pushRemote` are
>> +set, you can use the following commands to be up to date:
>=20
> What does "be up to date" mean?

OK.=20


I'll work on these issues and send a new RFC soon.=20
