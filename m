From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Fri, 3 Jun 2016 08:25:27 +0100
Organization: OPDS
Message-ID: <9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org> <1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <gitster@pobox.com>, <git@vger.kernel.org>,
	<erwan.mathoniere@grenoble-inp.org>,
	<samuel.groot@grenoble-inp.org>, <tom.russello@grenoble-inp.org>,
	<Matthieu.Moy@grenoble-inp.fr>,
	"Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>
To: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 09:25:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jU9-0000Hi-Is
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbcFCHZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 03:25:33 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:10621 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbcFCHZc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:25:32 -0400
Received: from PhilipOakley ([92.22.2.137])
	by smtp.talktalk.net with SMTP
	id 8jU1blJvnUnEI8jU1bW5iD; Fri, 03 Jun 2016 08:25:30 +0100
X-Originating-IP: [92.22.2.137]
X-Spam: 0
X-OAuthority: v=2.2 cv=btQOPwSi c=1 sm=1 tr=0 a=0ivS0Nd1YK2BeiW2qPa6pg==:117
 a=0ivS0Nd1YK2BeiW2qPa6pg==:17 a=IkcTkHD0fZMA:10 a=aSBN74SrAAAA:8
 a=UOnRpvVzqBAUKY-gW-UA:9 a=QLKLDn6n7aLR3e0nYJH2:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfNDzRcOO5khs+8Uducy8XuoBOBYqUT/zI3swfDr6Iqva+XlOMr+ykSNRa9+VN9W4SCLDWJx1AIvG+p9kfgl6i4GloR9bXj6ICDRWphf11pG5IqkDdKKN
 fv8iiI/xF3c3biWFidYKTl6Ll0Knh0oCcc2AvW9dLP+iggTcrn/scpMDfsgaCngZMESuj9IYsL3iRrAFf/mEjuxu7b84xpnvCAoLAGH5E46JO+jVNl0MCuwB
 p6dBCtoG+C2PWlT+etndyNNUBz7MJsgm7ztRI2g9IIwwNuZ9bPRMlpX864ByKVc6tfseGaErHNPJW1l6REcrDEa2kh36G5cTmN4jHbVnaito6VT6Yjrl3lHW
 9EUAj6RrRKVXrIpU0vdNYwll6Vy6Vyuksva6Ccv2dOu9qjtFqxCfHouOPeBYlAiMimHTYKaokQPGGKwopkGngjn9EiiZEBTW05B37giypaV/Z9bs5zk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296275>

[Just catching up with responses]

=46rom: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>
Sent: Tuesday, May 31, 2016 1:28 PM
> Currently, Triangular Workflow can be configured, but there is no
> Documentation about it. A documentation is useful to keep
> configuration possibilities up-to-date.
> The new documentation file gittriangularworkflow explains
> how to configure a triangular workflow.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
> ---
> Documentation/Makefile                  |   1 +
> Documentation/gittriangularworkflow.txt | 120=20
> ++++++++++++++++++++++++++++++++
> 2 files changed, 121 insertions(+)
> create mode 100644 Documentation/gittriangularworkflow.txt
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index f6e288b..e9f6c80 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -34,6 +34,7 @@ MAN7_TXT +=3D gitrevisions.txt
> MAN7_TXT +=3D gittutorial-2.txt
> MAN7_TXT +=3D gittutorial.txt
> MAN7_TXT +=3D gitworkflows.txt
> +MAN7_TXT +=3D gittriangularworkflow.txt
>
> MAN_TXT =3D $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
> MAN_XML =3D $(patsubst %.txt,%.xml,$(MAN_TXT))
> diff --git a/Documentation/gittriangularworkflow.txt=20
> b/Documentation/gittriangularworkflow.txt
> new file mode 100644
> index 0000000..803eee3
> --- /dev/null
> +++ b/Documentation/gittriangularworkflow.txt
> @@ -0,0 +1,120 @@
> +gittriangularworkflow(7)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +gittriangularworkflow - A tutorial about the configuration of a
> +Triangular Workflow
> +
> +SYNOPSIS
> +--------
> +[verse]
> +git fetch
> +git remote
> +git config
> +Options in git-config:
> +- `remote.pushDefault`
> +- `branch.<branch>.pushRemote`
> +- `branch.<branch>.origin`
> +
> +DESCRIPTION
> +-----------
> +
> +Triangular Workflow (or Asymmetric Workflow) is a workflow which giv=
es
> +the possibility to:
> +
> +- fetch (or pull) from a repository
> +- push to another repository
> +
> +In some projects, you don't have to push directly to the project but
> +have to suggest your commits to the maintainer (e.g. pull requests).
> +Using Triangular Workflow is a common way for these projects.
> +
> +This document attempts to help you configure a Triangular Workflow.
> +Here is an example of configuration:
> +
> +........................................
> +------------               -----------
> +| UPSTREAM |  maintainer   | ORIGIN  |

UPSTREAM and ORIGIN are two different types of description. Origin bein=
g a=20
too generic Git name that is used multiply elsewhere.

That said, trying to find a good name for that 'third place' is not eas=
y.=20
It's neither upstream, nor downstream (for Junio - the maintainer speci=
al=20
case - git.git would be his downstream). The me/git repo is like a=20
ferryman's landing across the other side of the river flow, a safe harb=
our=20
if you will.

=46inding a suitable name has all the same issues as deciding the gener=
ic=20
public name for the staging area / index. The ability to have a second=20
perfect copy is very new - historically all the dictionary names relate=
 to=20
copies or forgeries (you could only have one master - DVCS breaks that=20
mould). Perhaps (poorly) "MyFork", or "MyServer". There maybe a good Fr=
ench=20
word we can use.

> +|  git/git |- - - - - - - -|  me/git |

I think it is good to reference the use of "me" as a short remote name =
-=20
personally I ended up using "my"/remote, but having one in the document=
ation=20
will set a common trend.

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
> +
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

As I understand it one issue is to clearly suggest that it is best to f=
ork=20
and then clone from your me/fork project such that the origin and it's=20
fetch/push are set up the easiest way.

If the user clones the main project before forking and then tries to ad=
d the=20
me/fork there are more hoops to jump through to get all the fetch/push=20
settings re-arranged (this does depend on the Github fork method, but a=
t=20
least the issue of which repo is cloned should be noted)

> +
> +b. Create from scratch
> +~~~~~~~~~~~~~~~~~~~~~~
> +Create a repository on your prefered Git repository hosting service.
> +
> +Clone it
> +~~~~~~~~
> +Clone your repository on your machine.
> +
> +
> +CONFIGURE BRANCHES
> +------------------
> +In many projects, the branch `master` have to be pulled from
> +the main repository(e.g. git/git) and pushed to your repository
> +(e.g. me/git).
> +
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
> +
> +
> +GET YOUR PROJECT UP TO DATE
> +---------------------------
> +
> +Now that `branch.master.remote` and `branch.master.pushRemote` are
> +set, you can use the following commands to be up to date:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + * `git pull`
> + * `git push`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +SEE ALSO
> +--------
> +linkgit:git-config[1]
> +linkgit:git-remote[1]
> +linkgit:git-fetch[1]
> +
> +
> +
> --=20
> 2.7.4 (Apple Git-66)
>
>=20
