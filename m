From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCHv2] Documentation: triangular workflow
Date: Mon, 6 Jun 2016 23:21:14 +0100
Organization: OPDS
Message-ID: <12C5A5F1276946DC99A03F30FEE49559@PhilipOakley>
References: <1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org><1465206518-1780-1-git-send-email-jordan.de-gea@grenoble-inp.org> <xmqqk2i2w288.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <mhagger@alum.mit.edu>,
	<erwan.mathoniere@grenoble-inp.org>,
	<samuel.groot@grenoble-inp.org>, <tom.russello@grenoble-inp.org>,
	<Matthieu.Moy@grenoble-inp.fr>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 00:21:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA2te-0006zm-Iv
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 00:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbcFFWVS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 18:21:18 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:25866 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbcFFWVS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 18:21:18 -0400
Received: from PhilipOakley ([92.22.6.31])
	by smtp.talktalk.net with SMTP
	id A2tWbuVeVXCEWA2tWb5a7R; Mon, 06 Jun 2016 23:21:15 +0100
X-Originating-IP: [92.22.6.31]
X-Spam: 0
X-OAuthority: v=2.2 cv=cszZqBwi c=1 sm=1 tr=0 a=6rKLwjNE5rx67PMj20oCSw==:117
 a=6rKLwjNE5rx67PMj20oCSw==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=aSBN74SrAAAA:8 a=OaAhOT0jWcYLDQVWbSMA:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=QLKLDn6n7aLR3e0nYJH2:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfPCsbtQHfPDcyyZxO5a0uE2tmDOTcK+TLjCBeiA40TJP0/sSpmQsJI5mnsTZgJUEPz0IBBo4e+Clr7EDwRukzoxyunflUNzXnCqcA8xjV7HFmvMrMMz6
 6WGh4YmNvo+iLu88NHfzelYAhQm4S7H4SH+uNZO/78lpFfe/sphzj0sMYG3RCAnq82NMAW7Up/P48voMsvvrhgL1SO3Ekya3ZSWy7+APCIv05oSZI1lKdufm
 zhgyXy6zj8efAAkoME0ADHFKICcWjQ0QcojeMOsmqxrOtEI3nmvJ2Kl46zWyw3HPjkJ7VcORrbG9oEInIkw9dXLGCl6G/XdKUyy30WgRGrdIEVc/HdU2mXIb
 l301AQsWulSxvbvOn1NyF0iwGCjUbxd76SdXOyYTzCbf5CrIVDdCRqnZxJiad/nCjcvHtcY0WqVJ6VXSQA9yGMpBRyqOaw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296568>

=46rom: "Junio C Hamano" <gitster@pobox.com>
> Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:
>
>> +TRIANGULAR WORKFLOW
>> +-------------------
>> +
>> +In some projects, you cannot push directly to the project but have =
to
>> +suggest your commits to the maintainer (e.g. pull requests).
>> +For these projects, it's common to use what's called a *triangular
>> +workflow*:
>> +
>> +- Taking the last version of the project by fetching (e.g.
>> +  **UPSTREAM**)
>> +- Writing modifications and push them to a fork (e.g. **PUBLIC-FORK=
**)
>> +- Opening a pull request
>> +- Checking of changes by the maintainer and, merging them into the
>> +  **UPSTREAM** repository if accepted
>> +
>> +
>> +........................................
>> +------------------               -----------------
>> +| UPSTREAM       |  maintainer   | PUBLIC-FORK   |
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
>
> I agree with other commenters that "PUBLIC-FORK" is a name that does
> not capture the essense of the triangular being the next step
> forward, compared to the "central shared repository" workflow, to
> take advantage of the distributed nature of Git.
>
> "Where you push so that somebody else can fetch from there" does not
> have to be public.  You may be submitting a course assignment there,
> only to be seen by your professor but not by others in the class.
> Also, you do not your call "LOCAL" a "LOCAL-FORK" and that is a good
> thing.  In a distributed world, everything is a fork, so adding
> "-FORK" to a name is pretty much meaningless.
>
> So neither "PUBLIC" nor "FORK" in "PUBLIC-FORK" is a good word to
> describe this thing.
>
> The only reason you are pushing there is because your "LOCAL" is
> either not accessible from outside world, and/or you do not want to
> give a direct access to it (otherwise you could have allowed an
> access to whoever is going to fetch from you direct access to
> "LOCAL" and be done with it without creating "PUBLIC-FORK").
>
> That is why I reminded that we earlier in the design phase called
> this "publish"; it is a place you give access to others a selected
> work of yours that you choose to give them access to.

Given that clarification I'd be happier to go with it being one's 'Publ=
ish'=20
repo.

My initial reticence was because of the association of "publish" with v=
anity=20
publishing and other forms of over-sharing and self promotion.

A clarification/explanation that calling it a 'publish' repo is about=20
granting access, and possible open access, would make it more acceptabl=
e.

> Whether you
> are a leaf contributor, a student who got stuck and wants to ask
> suggestions from your friends after looking your code over, or an
> integrator of a big public project, I would view the act to push
> into such a place you give selective visibility to your work to
> others as publishing your work.

Agreed, in that context.

--
Philip=20
