From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 17:22:42 +0100
Organization: Organization?!?
Message-ID: <87d2jlqp7x.fsf@fencepost.gnu.org>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 21 17:23:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5e6U-000116-8L
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 17:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbaAUQXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jan 2014 11:23:00 -0500
Received: from plane.gmane.org ([80.91.229.3]:58632 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755133AbaAUQW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 11:22:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W5e6K-0000v8-1F
	for git@vger.kernel.org; Tue, 21 Jan 2014 17:22:56 +0100
Received: from x2f444fe.dyn.telefonica.de ([2.244.68.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 17:22:56 +0100
Received: from dak by x2f444fe.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 17:22:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f444fe.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:o9A4FPKTK92cZAsTaJmY98N4E6A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240753>

David Kastrup <dak@gnu.org> writes:

> This is more a warmup than anything else: I'm actually doing a quite
> more involved rewrite of git-blame right now.  But it's been a long
> time since I=A0sent patches for Git, so I'm starting out with somethi=
ng
> reasonably uncontroversial.

Ping?

Now I might have sent at an unopportune time: blame.c is mostly
attributed to Junio who seems to have been a few days absent now.

I also have seen quite a few mails and patch submissions on the list go
basically unanswered in the last few days.

So it might just be that this is business as usual.  However, since
I=A0have not been on this list for quite a while, I would want to avoid
causing large delays by some oversight.

I have not so far signed off on the patches: it would appear that this
is required.  The submission guidelines in
Documentation/SubmittingPatches state for signing off:

        (a) The contribution was created in whole or in part by me and =
I
            have the right to submit it under the open source license
            indicated in the file; or

[...]

        (d) I understand and agree that this project and the contributi=
on
            are public and that a record of the contribution (including=
 all
            personal information I submit with it, including my sign-of=
f) is
            maintained indefinitely and may be redistributed consistent=
 with
            this project or the open source license(s) involved.

Now the file involved (builtin/blame.c) itself does not state _any_
license.  Instead it states

    /*
     * Blame
     *
     * Copyright (c) 2006, Junio C Hamano
     */

I do not intend my contribution to constitute a copyright assignment
(and it hardly could be one).  The top file COPYING in Git states

     Note that the only valid version of the GPL as far as this project
     is concerned is _this_ particular version of the license (ie v2, n=
ot
     v2.2 or v3.x or whatever), unless explicitly otherwise stated.

     HOWEVER, in order to allow a migration to GPLv3 if that seems like
     a good idea, I also ask that people involved with the project make
     their preferences known. In particular, if you trust me to make th=
at
     decision, you might note so in your copyright message, ie somethin=
g
     like

            This file is licensed under the GPL v2, or a later version
            at the discretion of Linus.

      might avoid issues. But we can also just decide to synchronize an=
d
      contact all copyright holders on record if/when the occasion aris=
es.

As far as I am concerned, I am willing to license my work under the
GPLv2 or any later version at the discretion of whoever wants to work
with it.  I think that should be compatible with the project goals.

Now the above passage states "you might note so in your copyright
message", but my patches do not even contain a copyright message and it
is not clear to me that they should, or that there is a sensible place
to place such "copyright messages".

So any guidance about that?

--=20
David Kastrup
