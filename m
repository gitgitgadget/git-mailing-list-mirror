From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/2] builtin/blame.c: struct blame_entry does not need a prev link
Date: Wed, 22 Jan 2014 00:02:45 +0100
Organization: Organization?!?
Message-ID: <87eh41os4q.fsf@fencepost.gnu.org>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
	<1390157870-29795-2-git-send-email-dak@gnu.org>
	<xmqqlhy9t2z1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 00:03:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kLZ-0004sv-ON
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbaAUXDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:03:01 -0500
Received: from plane.gmane.org ([80.91.229.3]:45749 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbaAUXDA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:03:00 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W5kLS-0004q3-CR
	for git@vger.kernel.org; Wed, 22 Jan 2014 00:02:58 +0100
Received: from x2f444fe.dyn.telefonica.de ([2.244.68.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 00:02:58 +0100
Received: from dak by x2f444fe.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 00:02:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f444fe.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:MwavHXgzDj0U7oGpjTdRmunPCuA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240789>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> ---
>
> Thanks.  At some point during its development I must have thought
> that having it as a dual-linked list may make it easier when we have
> to split a block into pieces, but it seems that split_overlap() does
> not need to look at this information.
>
> Needs sign-off.

Well, as I said: it's quite possible that the double-linking might be
useful for some particular hypothetical rewrite of the code.  It isn't
for the current code, and it's not useful for my own rewrite.

Will be posting a signed-off version presently.

-- 
David Kastrup
