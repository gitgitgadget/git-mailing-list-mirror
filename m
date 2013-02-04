From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH 1/3] Add contrib/credentials/netrc with GPG support
Date: Mon, 04 Feb 2013 14:40:31 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87lib3uats.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
	<87sj5cvxnf.fsf_-_@lifelogs.com>
	<7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
	<87k3qoudxp.fsf@lifelogs.com>
	<7vvca7291z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 20:41:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2RuZ-0006L6-61
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 20:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab3BDTkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 14:40:37 -0500
Received: from z.lifelogs.com ([173.255.230.239]:49001 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755683Ab3BDTkc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 14:40:32 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 09155DE0CA;
	Mon,  4 Feb 2013 19:40:31 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vvca7291z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 04 Feb 2013 11:06:16 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215411>

On Mon, 04 Feb 2013 11:06:16 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Ted Zlatanov <tzz@lifelogs.com> writes:
>> Sorry, I didn't realize contrib/ stuff was under the same rules.

JCH> I had a feeling that this may start out from contrib/ but will soon
JCH> prove to be fairly important to be part of the Git proper.

Cool!

>> It would help if the requirements were codified as the fairly standard
>> Emacs file-local variables, so I can just put them in the Perl code or
>> in .dir-locals.el in the source tree.  At least for Perl I'd like that,
>> and it could be nice for the Emacs users who write C too.
>> 
>> Would you like me to propose that as a patch?

JCH> I thought that we tend to avoid Emacs/Vim formatting cruft left in
JCH> the file.  Do we have any in existing file outside contrib/?

No, but it's a nice way to express the settings so no one is guessing
what the project prefers.  At least for me it's not an issue anymore,
since I understand your criteria better now, so let me know if you want
me to express it in the CodingGuidelines, in a dir-locals.el file, or
somewhere else.

>> Either way, I guessed that these settings are what you want as far as
>> tabs and indentation (I use cperl-mode but perl-mode is the same):
>> 
>> # -*- mode: cperl; tab-width: 8; cperl-indent-level: 4; indent-tabs-mode: t; -*-

JCH> Indent is done with a Tab and indent level is 8 places (check add--interactive.perl
JCH> and imitate it, perhaps?).

Yup, got it.  My mistake on the size-4 indents.

I found this helpful, at least while I was indenting, for anyone else
who might want to indent Perl appropriately to imitate existing Perl code:

# -*- mode: cperl; tab-width: 8; cperl-indent-level: 8; indent-tabs-mode: t; -*-

I'll resubmit now.

Thanks
Ted
