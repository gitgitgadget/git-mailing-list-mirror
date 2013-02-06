From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: CodingGuidelines Perl amendment
Date: Wed, 06 Feb 2013 13:05:25 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87vca5gvx6.fsf@lifelogs.com>
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
	<87lib3uats.fsf@lifelogs.com>
	<7v7gmn1xqi.fsf@alter.siamese.dyndns.org>
	<871ucto4vj.fsf_-_@lifelogs.com>
	<7vvca5mmmt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 19:05:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39NW-0002Ki-A1
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893Ab3BFSF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:05:27 -0500
Received: from z.lifelogs.com ([173.255.230.239]:58958 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754915Ab3BFSF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:05:27 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 88763DE0E3;
	Wed,  6 Feb 2013 18:05:26 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vvca5mmmt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 06 Feb 2013 08:29:30 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215604>

On Wed, 06 Feb 2013 08:29:30 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Is it ever (as opposed to "not always") possible to omit braces?

Oh yes!  Not that I recommend it, and I'm not even going to touch on
Perl Golf :)

JCH> It sounds as if we encourage the use of statement modifiers, which
JCH> certainly is not what I want to see.

Yup.  I think I captured that in the patch, but please feel free to
revise it after applying or throw it back to me.

JCH> You probably would want to mention that opening braces for
JCH> "if/else/elsif" do not sit on their own line, and closing braces for
JCH> them will be followed the next "else/elseif" on the same line
JCH> instead, but that is part of "most of the C guidelines above apply"
JCH> so it may be redundant.

OK; done.

>> - Don't abuse statement modifiers (unless $youmust).

JCH> It does not make a useful guidance to leave $youmust part
JCH> unspecified.

JCH> Incidentally, your sentence is a good example of where use of
JCH> statement modifiers is appropriate: $youmust is rarely true.

I was trying to be funny, honestly.  But OK; reworded.

Ted
