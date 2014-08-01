From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 19:57:04 +0100
Organization: OPDS
Message-ID: <4EA0D79811C348C6893039D315E6E190@PhilipOakley>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	<git@vger.kernel.org>
To: "Mike Stump" <mikestump@comcast.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 20:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDI0u-00089Y-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 20:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbaHAS5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 14:57:08 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:46397 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750851AbaHAS5H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 14:57:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuAvAFfi21MCYJjrPGdsb2JhbABbgw1jAUWCeIQ3gQTLKAECAQEMfxcFAQEBATg2g34FAQEFCAEBGQ8BBR4BASELAgMFAgEDFQMCAgUMFQICFAEECBIGBwMUBgESCAIBAgMBiB0DFbEahn+JSggFhyaBLIhTgyCCLREkgks2gRwFhgWLToggkA4tiXA8L4EFJA
X-IPAS-Result: AuAvAFfi21MCYJjrPGdsb2JhbABbgw1jAUWCeIQ3gQTLKAECAQEMfxcFAQEBATg2g34FAQEFCAEBGQ8BBR4BASELAgMFAgEDFQMCAgUMFQICFAEECBIGBwMUBgESCAIBAgMBiB0DFbEahn+JSggFhyaBLIhTgyCCLREkgks2gRwFhgWLToggkA4tiXA8L4EFJA
X-IronPort-AV: E=Sophos;i="5.01,781,1400022000"; 
   d="scan'208";a="563144714"
Received: from host-2-96-152-235.as13285.net (HELO PhilipOakley) ([2.96.152.235])
  by out1.ip05ir2.opaltelecom.net with SMTP; 01 Aug 2014 19:57:04 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254647>

=46rom: "Mike Stump" <mikestump@comcast.net>
> On Aug 1, 2014, at 9:27 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wr=
ote:
>>
>> Note that you should try to avoid cherry-picking, as they do not
>> leave trace in the graph of revisions.
>
> Fine, then I want a new command to merge in a change into my branch=20
> from another branch and I want merge to account for the motion and no=
t=20
> duplicate it when I merge that branch back into master.  Funny thing=20
> is, cherry and merge seem to be documented mostly to do exactly what =
I=20
> want.
>
>> For example if you are creating a bugfix, instead of putting it
>> directly on maint, and then cherry-picking to master, it is better
>> to create a separate feature branch for this fix
>
> You=E2=80=99re assuming that I=E2=80=99m the author of master, I=E2=80=
=99m not, I=E2=80=99m merely a=20
> contributor.  This tail doesn=E2=80=99t wag that dog.  What that mean=
s is that=20
> I cannot change the world to work around a simple bug in git.
>
>> There is also git-imerge, third party tool that is intended to help
>> merging changes (and make it possible to do it in incremental way).
>
> Then remove git merge and replace it with git-imerge.  :-)  Anyway, I=
=20
> read that, and I can see some beauty of that that might be nice in=20
> complex merges.  The problem is, I want git merge to work.
>
>
> I was curious if svn handles this better the same or worse, and it di=
d=20
> it just fine.  I know that a while ago, svn could not handle this, it=
=20
> would do what git does currently.  Apparently they figured out it was=
=20
> a bug and fixed it.  Have you guys figured out it is a bug yet?  The=20
> first step in solving a problem, is admitting you have a problem.
--
But that goes both ways, and is a philosophical issue about what is to=20
be expected in various cases. For some central control use styles, the=20
ideas behind _distributed_ version control are anathema and (Git) just=20
grinds away at the policies that are expected.

That said, Git doesn't claim to be perfect (and can't because of the=20
'relativity' that comes with being distributed - truth has to give way=20
to a web of trust). Also the artefacts that Git validates are at a=20
different level of abstraction i.e. the whole project as a commit,=20
rather than just a few/one file at a time.

In your example (when generalised) the problem is deciding when, in the=
=20
change sequence, the cherry pick is to be backed out, especially if=20
there are conflicts in the change sequence that would need fixing=20
anyway, and in a long change sequence that would be a lot of conflict=20
fix-ups, hence the current choice of getting the merge conflicts all=20
resolved in the one go.

The alternate case, mentioned/implied by Brian, is to use a rebase=20
(probably after duplicating the branch so as to retain the original if=20
required) so as to see each patch/changeset being applied, and doing=20
any/many conflit resolutions as they appear, before finally doing any=20
merge of the new line of development back into the mainline (which agai=
n=20
presumes your earlier resolutions don't cause more conflicts on that=20
merge). But do note that I've hidden the problem of deciding where the=20
rebase start point should be, relative to the merge point, because=20
that's actually where the original problem is hidden (which bits merge=20
with what!)

git-imerge is a visual tool to show which bits merge cleanly with what=20
between two change sequences.

Selecting a compatible workflow is a problem of usage, rather than a=20
problem in Git. If Git has a problem, it's that it has too many ways of=
=20
doing things, leaving most of us with too much rope entangled round our=
=20
neck.
--
Philip
