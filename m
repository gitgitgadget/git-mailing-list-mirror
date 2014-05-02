From: David Kastrup <dak@gnu.org>
Subject: Re: Pull is Evil
Date: Fri, 02 May 2014 21:10:31 +0200
Organization: Organization?!?
Message-ID: <87a9b0xahk.fsf@fencepost.gnu.org>
References: <53629da233345_76612eb2f075@nysa.notmuch>
	<20140501194846.GA6227@odin.tremily.us>
	<20140501200703.GB6227@odin.tremily.us>
	<5362d7dc7b12_12fe14dd31095@nysa.notmuch>
	<20140502000208.GB28634@odin.tremily.us>
	<5362e8b09aba1_429131b31038@nysa.notmuch>
	<20140502011004.GD28634@odin.tremily.us>
	<5362f1755f2a9_d1310572f0fa@nysa.notmuch>
	<20140502145433.GF28634@odin.tremily.us>
	<5363ea28d3c14_70ef0f30c94@nysa.notmuch>
	<20140502190746.GJ28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 21:10:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgIrD-0001hh-Dv
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbaEBTKr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2014 15:10:47 -0400
Received: from plane.gmane.org ([80.91.229.3]:36077 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbaEBTKq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 15:10:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WgIr6-0001PR-Ow
	for git@vger.kernel.org; Fri, 02 May 2014 21:10:44 +0200
Received: from x2f3bf8b.dyn.telefonica.de ([2.243.191.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 May 2014 21:10:44 +0200
Received: from dak by x2f3bf8b.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 May 2014 21:10:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f3bf8b.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Cancel-Lock: sha1:9tn+WCdg7zyIn7du14/DFgJpU5w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247954>

"W. Trevor King" <wking@tremily.us> writes:

> On Fri, May 02, 2014 at 01:55:36PM -0500, Felipe Contreras wrote:
>> W. Trevor King wrote:
>> > On Thu, May 01, 2014 at 08:14:29PM -0500, Felipe Contreras wrote:
>> > > W. Trevor King wrote:
>> > > > My proposed --prompt behavior is for folks who think =E2=80=9C=
I often run
>> > > > this command without thinking it through all the way.  I'm als=
o
>> > > > not used to reading Git's output and using 'reset --hard' with=
 the
>> > > > reflog to reverse changes.  Instead of trusting me to only say
>> > > > what I mean or leaving me to recover from mistakes, please tel=
l me
>> > > > what's about to change and let me opt out if I've changed my
>> > > > mind.=E2=80=9D
>> > >=20
>> > > Unfortunately those folks by definition wouldn't know about the
>> > > --prompt option.
>> >=20
>> > But once such folks are identified, you just have to convince them
>> > (once) to set the pull.prompt config.  That's a lot easier than
>> > convincing them (for every pull) to set the appropriate ff flag.
>>=20
>> It wouldn't matter if by the default non-fast-forward merges are
>> rejected.
>
> It would matter if you didn't want them making non-fast-forward merge=
s
> (e.g. for explicitly-merged topic branches).

s/didn't want/only wanted/

--=20
David Kastrup
