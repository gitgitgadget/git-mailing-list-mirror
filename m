From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: An interesting opinion on DVCS/git
Date: Tue, 3 Mar 2015 18:55:17 -0500
Message-ID: <003f01d0560d$80bd7d50$823877f0$@nexbridge.com>
References: <54F2CD12.8050609@gmail.com> <CAGZ79kZ8CrjwVh3+OHSV1tv+fRXaDZ_diOO5E7QnSLZ=HTFSfg@mail.gmail.com> <CAJo=hJuKL3akaG3Xh8mH5iij_dAdMkBW8fQgvreOsUHV517gpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "'Shawn Pearce'" <spearce@spearce.org>,
	"'Stefan Beller'" <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 00:55:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSwes-0008UC-J3
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 00:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757543AbbCCXzW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2015 18:55:22 -0500
Received: from elephants.elehost.com ([216.66.27.132]:21596 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757444AbbCCXzV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 18:55:21 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t23NtGEm041018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Mar 2015 18:55:17 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <CAJo=hJuKL3akaG3Xh8mH5iij_dAdMkBW8fQgvreOsUHV517gpw@mail.gmail.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQEXuc1gLzK22oSKO7FrARSnkZDBBQHFXeO1AgIlMIyeXmV+gA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264712>


> On 03 Mar 2015, Shawn Pearce Wrote:
>> On Sun, Mar 1, 2015 at 7:29 PM, Stefan Beller <sbeller@google.com> w=
rote:
> > bitquabit.com/post/unorthodocs-abandon-your-dvcs-and-return-to-sani=
ty
>=20
> Indeed, a DVCS like Git or Hg does not fit everyone. And neither do c=
entralized
> systems like Subversion. Choice is good.
>=20
> However... I found some passages troubling for Git, e.g.:
>=20
> ---snip---
> Git is so amazingly simple to use that APress, a single publisher, ne=
eds to have
> three different books on how to use it. It=E2=80=99s so simple that A=
tlassian and GitHub
> both felt a need to write their own online tutorials to try to clarif=
y the main Git
> tutorial on the actual Git website. It=E2=80=99s so transparent that =
developers routinely
> tell me that the easiest way to learn Git is to start with its file f=
ormats and work
> up to the commands.
> ---snap---
>=20
> We have heard this sort of feedback for years. But we have been unabl=
e to
> adequately write our own documentation or clean up our man pages to b=
e
> useful to the average person who doesn't know why the --no-frobbing o=
ption
> doesn't disable the --frobinator option to the --frobbing-subcommand =
of git
> frob.  :(

In real life, I do process automation, so I'm coming at this from a sli=
ghtly different point of view. What appeals to me about git is the rich=
ness of processes that can be implemented with it. You may want to cons=
ider it a complex process enabler engine that happens to do DVCS. Havin=
g built one of these also, and being saddled with huge numbers of requi=
rements, I can say from experience that complexity is a side effect of =
doing what you need to do. Like many complex products, git takes on a l=
ife of its own, and obviously chose completeness instead of simplicity =
as a goal. Personally, I am not complaining, but I hear the complaints =
too. The bigger complaints are when you cannot do your job because the =
engine is not rich enough (see anything derived from SCCS - yes saying =
that shows my hair colour), which forced my company *to* git.=20

When looking at git, I personally feel that it is important to deploy s=
imple-to-use scripts and instructions to implement the process you want=
 to use - and I hate to leave a footprint saying this, but, people are =
fundamentally lazy about non-goal activities. Thinking about mundane ta=
sks like committing and delivering is outside the typical work-instruct=
ion box, but if, as a repository manager, you need a rich engine, spend=
 the couple of days and script it. I think the objections in the articl=
e are essentially sound, from one point of view, but omit the core doma=
in-space of why git is around and necessary, as opposed to many other u=
nnamed RCS-like systems that are *not* sufficient.

> http://git-man-page-generator.lokaltog.net/ shouldn't exist and shoul=
dn't be
> funny. Yet it does. :(

Mockery is the not the kindest form of flattery, but it sure is the sin=
cerest. I've been the target of this too. Laugh, and suggest workflows.=
 And, for the record, the only way you will remove atomicity/immutabili=
ty of changes is out of my cold dead hands. :)

Cheers,
Randall
