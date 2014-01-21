From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 18:58:57 +0100
Organization: Organization?!?
Message-ID: <87zjmpp672.fsf@fencepost.gnu.org>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
	<87d2jlqp7x.fsf@fencepost.gnu.org> <20140121165546.GE18964@google.com>
	<874n4xqlly.fsf@fencepost.gnu.org> <20140121174448.GG18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 21 18:59:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5fba-0005eo-En
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 18:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbaAUR7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jan 2014 12:59:15 -0500
Received: from plane.gmane.org ([80.91.229.3]:47570 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971AbaAUR7N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 12:59:13 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W5fbS-0005ct-9b
	for git@vger.kernel.org; Tue, 21 Jan 2014 18:59:10 +0100
Received: from x2f444fe.dyn.telefonica.de ([2.244.68.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 18:59:10 +0100
Received: from dak by x2f444fe.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 18:59:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f444fe.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:gRADb259eIT9oT5TJ7PeD/ORmT8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240761>

Jonathan Nieder <jrnieder@gmail.com> writes:

> David Kastrup wrote:
>
>> So my understanding is that when we are talking about _significant_
>> additions to builtin/blame.c (the current patches don't qualify as s=
uch
>> really) that
>>
>> a) builtin/blame.c is licensed under GPLv2
>> b) significant contributions to it will not be relicensed under
>> different licenses without the respective contributors' explicit
>> consent.
>
> Yep, that's how it works.
>
> [...]
>> The combination of the SubmittingPatches text with the file notices =
in
>> builtin/blame.c is not really painting a full picture of the situati=
on.
>
> Any idea how this could be made more clear?  E.g., maybe we should
> bite the bullet and add a line to all source files that don't already
> state a license:
>
> 	/*
> 	 * License: GPLv2.  See COPYING for details.
> 	 */

Probably somewhat more verbose like "This file may be distributed under
the conditions of the GPLv2.  See the file COPYING for details".
I=A0think there are boilerplate texts for that.

Whatever the exact wording, that would be the cleanest way I think.  Th=
e
respective Documentation/SubmittingPatches text looks like it is quoted
from somewhere else, so adapting it to the realities of files without
clear copyright statement seems less straightforward.

--=20
David Kastrup
