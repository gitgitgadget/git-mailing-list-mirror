From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH 3/3] Fix contrib/credentials/netrc minor issues: exit quietly; use 3-parameter open; etc.
Date: Mon, 04 Feb 2013 13:41:23 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <874nhrvs4s.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
	<87k3qovxlp.fsf_-_@lifelogs.com>
	<7vfw1c2dm5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:41:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2QzE-0006fY-8u
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 19:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab3BDSlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 13:41:25 -0500
Received: from z.lifelogs.com ([173.255.230.239]:41669 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab3BDSlY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 13:41:24 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id DDFD1DE0CA;
	Mon,  4 Feb 2013 18:41:23 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vfw1c2dm5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 04 Feb 2013 09:27:46 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215408>

On Mon, 04 Feb 2013 09:27:46 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Ted Zlatanov <tzz@lifelogs.com> writes:
>> Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
>> ---
>> contrib/credential/netrc/git-credential-netrc |   38 +++++++++++++------------
>> 1 files changed, 20 insertions(+), 18 deletions(-)

JCH> Especially because this is an initial submission, please equash
JCH> three patches into one, instead of sending three "here is my first
JCH> attempt with many problems I know I do not want to be there", "one
JCH> small improvement", "another one to fix remaining issues".

JCH> Otherwise you will waste reviewers' time, getting distracted by
JCH> undesirable details they find in an earlier patch while reviewing,
JCH> without realizing that some of them are fixed in a later one.

OK, thanks.  I wasn't sure, since Jeff already reviewed it, if it was
better to squash or not.  Ignore this same question in my other reply to
you, and thanks for your patience.

Ted
