From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: Re: [PATCHv3] Documentation: triangular workflow
Date: Wed, 8 Jun 2016 10:37:17 +0200
Message-ID: <CDB4510C-64D4-4357-A175-18D9B5681BD2@grenoble-inp.org>
References: <1465206518-1780-1-git-send-email-jordan.de-gea@grenoble-inp.org> <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org> <xmqqr3c8q0d5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 10:38:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAZ0M-00041E-9M
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 10:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422940AbcFHIh2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2016 04:37:28 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:56318 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161797AbcFHIhW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2016 04:37:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1835320BA;
	Wed,  8 Jun 2016 10:37:19 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kTSfq-gxyRAf; Wed,  8 Jun 2016 10:37:19 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id F2C6820B4;
	Wed,  8 Jun 2016 10:37:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id EB2082066;
	Wed,  8 Jun 2016 10:37:18 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XAPGmLGLNeJn; Wed,  8 Jun 2016 10:37:18 +0200 (CEST)
Received: from eduroam-032082.grenet.fr (eduroam-032082.grenet.fr [130.190.32.82])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 8CA462064;
	Wed,  8 Jun 2016 10:37:18 +0200 (CEST)
In-Reply-To: <xmqqr3c8q0d5.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296773>

> Le 7 juin 2016 =C3=A0 21:12, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:
>=20
>> +
>> +- Taking the last version of the project by fetching (e.g.
>> +  **UPSTREAM**)
>=20
> "by fetching (e.g. UPSTREAM)" does not finish the sentence nicely.
>=20
> "... by fetching from **UPSTREAM**" would work better.  So would
> "Fetching the latest version from the project (e.g. UPSTREAM) =C2=BB.

Ok. Changed for the next iteration.=20

>> +- Writing modifications and push them to a fork (e.g. **PUBLISH**)
>> +- Opening a pull request
>> +- Checking of changes by the maintainer and, merging them into the
>> +  **UPSTREAM** repository if accepted
>=20
> You'd want to end these sentences with full-stop, by the way
>=20

OK too.=20

>> +........................................
>> +------------------               -----------------
>> +| UPSTREAM       |  maintainer   | PUBLISH       |
>> +|  git/git       |- - - - - - - -|  me/remote    |
>> +------------------       =E2=86=90       -----------------
>> +              \                     /
>> +               \                   /
>> +          fetch=E2=86=93\                 /=E2=86=91push
>> +                 \               /
>> +                  \             /
>> +                   -------------
>> +                   |   LOCAL   |
>> +                   -------------
>> +........................................
>> +
>> +Git options to use:
>> +~~~~~~~~~~~~~~~~~~~
>> + - `branch.<branch>.remote`
>> + - `branch.<branch>.pushRemote`
>> + - `remote.pushDefault`
>> + - `push.default`
>> +
>> +See linkgit:git-config[1].
>=20
> The title says "options" but listed are configuration variables and
> the referred document is also about git-config.  Perhaps retitle it t=
o
>=20
> 	Useful configuration variables
>        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20

Ok too.=20


> or something like that?
>=20
> One thing after reading the above lines that immediately came to my
> mind was this:
>=20
>    After listing these four and telling the reader to "See ...", is
>    there anything else the reader needs to learn from below?
>=20
> It may make the result a lot more useful document if this gives an
> impression to the reader as if you are saying (you do not have to
> actually say it) "We will guide you how to set up your workflow in
> triangular way, and here are the key configuration variables you
> will end up using; don't worry about the details of them, we'll
> teach you all about them soon in the following paragraphs."
>=20
> And I found that "See linkgit:git-config[1]" go directly against
> that line of narrative.

A link is already added at the end of the document. So I delete this on=
e.=20

>=20
>> +Push behaviour
>> +~~~~~~~~~~~~~~
>> + ...
>> +
>> +Case 2: LOCAL is a clone of **UPSTREAM**
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +'In this case, the remote named `origin` corresponds to **UPSTREAM*=
*.'
>> +
>> +Adding **PUBLISH** remote:
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +* `git remote add publish <PUBLISH_url>`
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> It may perhaps be only me, but these blind instructions puts me off,
> and what I find lacking is "Why should I do this?"  "What benefit do
> I get by doing this".  Start it perhaps like this?
>=20
> 	Because you will be pushing into the publish repository
> 	often, instead of having to type its URL every time, you
> 	want a short name you can use to call it.
>=20
> and then give that "remote add".

Ok. Similar text added for the next iteration.=20

>> +
>> +**Method 1: One option for all branches**
>> +
>> +Setting `remote.pushDefault` in order to push to **PUBLISH** withou=
t
>> +argument for push.
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +* `git config remote.pushDefault publish`
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This is not too bad, but I'd say
>=20
> 	With the "remote add" above, you can say "git push publish"
> 	to push there, instead of saying its URL.  But you may want
> 	to be even lazier and say just "git push".  To do so:
>=20

Ok too. Similar text added for the next iteration.=20

> As a document that is geared toward being a tutorial, I personally
> think it is better to stick to one arrangement rather than
> presenting case 1/2 as two equivalently valid arrangements and
> describe them to equal degree of detail.  Otherwise, after finishing
> reading Case 1 and immediately reading Case 2 heading, the reader
> would start wondering "Which one should I pick?  What are the pros
> and cons?".
>=20
> A typical reader of this document would have an upstream in mind,
> perhaps a clone of it locally, and may or may not yet have a publish
> repository, so one valid choice could be to use Case 2.
>=20
> Whichever one you choose, the description should not begin with
> "pushing".  A reader who is the target of this document (i.e. who
> owns the LOCAL and PUBLISH repository) begins by cloning and/or
> fetching, followed by working on her own change while staying up to
> date, and pushing is the last thing she does in the flow.
>=20
> So I'd recommend reordering the description to
>=20
>    * Introduction.  As a summary, here are the four configuration
>      variables you'll be using to make it easier to arrange.
>=20
>    * "Preparation".  Clone from the upstream, create an empty
>      publish repository and set it as a secondary remote, with
>      pushdefault pointing at it.
>=20
>    * "Staying up-to-date".  You do not have to describe "git fetch"
>      or "git pull" from the upstream aka origin with too much
>      detail, as having or not having a publish repository does not
>      change anything on this side.
>=20
>    * "Making your work available".  You would want to reiterate the
>      fact that "git push" does not go to the upstream but to your
>      publishing place thanks to the earlier pushdefault
>      configuration.
>=20
>    * "Alternatively...".  In this section, you could mention
>      possible other arrangements.  One could be to set pushdefault
>      for each and every branch (aka your Case 2/Method 2), which
>      shouldn't be necesssary because at the beginning of the
>      document we made it clear that we assume that the reader
>      cannot push to upstream--the normal place she would be pushing
>      is to her own publishing place, and configuring "usually all
>      of them go to my publishing place, but this one alone will go
>      someplace else" (1) is an advanced workflow element, and more
>      importantly (2) is not specific to triangular workflow.
>=20
>      Another altenative arrangement worth mentioning may be your
>      Case 1, i.e. to point at your publish place and a secondary
>      "upstream" pointing at where your upstream publishes their
>      work.  You can describe what needs to be changed compared to
>      the above three sections.

Yes, that clearer like that. I reorganize and send a new patch.=20
