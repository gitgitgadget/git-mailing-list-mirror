From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: CodingGuidelines Perl amendment
Date: Wed, 06 Feb 2013 13:27:33 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87mwvhguwa.fsf@lifelogs.com>
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
	<87vca5gvx6.fsf@lifelogs.com>
	<7vehgtcnpm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 19:27:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39iv-0004Cr-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294Ab3BFS1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:27:35 -0500
Received: from z.lifelogs.com ([173.255.230.239]:35868 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059Ab3BFS1e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:27:34 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 0E952DE0E3;
	Wed,  6 Feb 2013 18:27:34 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vehgtcnpm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 06 Feb 2013 10:16:21 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215617>

On Wed, 06 Feb 2013 10:16:21 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> I'd suggest to just drop that "try to write without braces" entirely.

OK, I'll do it on the reroll, or you can just make the change directly.

I agree it was not going anywhere :)

Ted

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 951d74c..857f4e2 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -187,10 +187,6 @@ For Perl 5 programs:
 
  - use strict and use warnings are strongly preferred.
 
- - As in C (see above), we avoid using braces unnecessarily (but Perl forces
-   braces around if/unless/else/foreach blocks, so this is not always possible).
-   At least make sure braces do not sit on their own line, like with C.
-
  - Don't abuse statement modifiers--they are discouraged.  But in general:
 
        ... do something ...
