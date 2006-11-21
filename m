X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 18:16:34 +0100
Message-ID: <slrnem6d3i.7bn.Peter.B.Baumann@xp.machine.xx>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <ejv8pc$cig$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 21 Nov 2006 17:18:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 41
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32007>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmZGU-0001DO-Rk for gcvg-git@gmane.org; Tue, 21 Nov
 2006 18:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966535AbWKURSb convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006 12:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966798AbWKURSb
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 12:18:31 -0500
Received: from main.gmane.org ([80.91.229.2]:45490 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966535AbWKURSa (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 12:18:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmZFM-0000yV-44 for git@vger.kernel.org; Tue, 21 Nov 2006 18:17:24 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 18:17:24 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Tue, 21 Nov 2006 18:17:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 2006-11-21, Jakub Narebski <jnareb@gmail.com> wrote:
> Peter Baumann wrote:
>
>> On 2006-11-21, Santi B=E9jar <sbejar@gmail.com> wrote:
>>> On 11/21/06, Andy Parkins <andyparkins@gmail.com> wrote:
>>>> Hello,
>>>>
>>>> I'm sure this one will be known about already.  git-show --stat on=
 the the
>>>> first commit doesn't show anything.  I assume it's because git-dif=
f-tree has
>>>> nothing to diff against (although shouldn't that be an everything-=
new diff?).
>>>>
>>>> Given the above; does anyone have a suggestion for what I could us=
e as a
>>>> replacement?  Even just a list of the new files would be useful.
>
> You can always use git-ls-tree
>
>>> $ git show --stat --root
>>>
>>> In general the initial commit diff (or stat) is hidden, but perhaps=
 it
>>> make sense to show it in "git show", you asked fo this specifically=
=2E
>>=20
>> Why not make --root the default? I also stumbled over this behaviour=
 and
>> even asked on this list.
>>=20
>> In my opinion this will help new users which are supprised that they
>> can't get the diff of the inital commit (which is totaly non-intuiti=
v behavior).
>>=20
>> And one less "wart" to clean, which another thread is all about. :-)
>
> Because for projects imported into git first commit diff is huge,
> and not very interesting. By the way, git show by default doesn't sho=
w
> diff for merges (you need --cc for that), nor rename detection (you n=
eed
> -M for that).
>
> But you can always set default diff-tree options, including --root, -=
-cc
> and -M in the show.difftree configuration variable (either in repo co=
nfig,
> or in user config). It is IMHO better solution than changing defaults=
=2E

Ah. I wasn't aware of this. Thank for this nice tip.

Peter
