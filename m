From: David Kastrup <dak@gnu.org>
Subject: Re: Pull is Mostly Evil
Date: Sat, 03 May 2014 04:18:03 +0200
Organization: Organization?!?
Message-ID: <87wqe3wqp0.fsf@fencepost.gnu.org>
References: <5363BB9F.40102@xiplink.com>
	<xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
	<5363edc954f8e_70ef0f30c24@nysa.notmuch>
	<20140502214817.GA10801@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 04:18:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgPWs-0001UA-H8
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 04:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbaECCSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 22:18:14 -0400
Received: from plane.gmane.org ([80.91.229.3]:49373 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbaECCSN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 22:18:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WgPWk-0000ml-4r
	for git@vger.kernel.org; Sat, 03 May 2014 04:18:10 +0200
Received: from x2f3bf8b.dyn.telefonica.de ([2.243.191.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 May 2014 04:18:10 +0200
Received: from dak by x2f3bf8b.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 May 2014 04:18:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f3bf8b.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Cancel-Lock: sha1:hFIwcZ8nLwrvpM6nO5k6snqkQAE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248014>

Jeff King <peff@peff.net> writes:

> On Fri, May 02, 2014 at 02:11:05PM -0500, Felipe Contreras wrote:
>
>> Junio C Hamano wrote:
>> > If we step back a bit, because we are forcing him to differentiate
>> > these two pulls in his mental model anyway, perhaps it may help
>> > people (both new and old) if we had a new command to make the
>> > distinction stand out more.  What if the command sequence were like
>> > this instead?
>> > 
>> >     $ git checkout maint
>> >     $ git update [ origin maint ]
>> > 
>> >     $ git pull [--no-ff] developer-remote topic-branch
>> >     $ git push [ origin maint ]
>> > 
>> > where the new command 'update' enforces the '--ff-only' update.  And
>> > then we would stop telling "'git pull' first" when a push does not
>> > fast-forward.
>> 
>> In addition to barf when it's not a fast-forward, such command can
>> switch the parents, so it appears 'maint' was merged to 'origin/maint'.
>> Many people have complained about this order.
>
> I realize this has veered off into talking about an "update" command,
> and not necessarily "pull", but since there a lot of proposals floating
> around, I wanted to make one point: if we are going to do such a switch,
> let's please make it something the user explicitly turns on.

A safety catch defaulting to a factory position of "off" is not going to
stop inexperienced people from shooting themselves in the foot.

-- 
David Kastrup
