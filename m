From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Mon, 04 Feb 2013 18:54:11 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87zjzjr5y4.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vd2wf1yex.fsf@alter.siamese.dyndns.org>
	<87bobzslke.fsf@lifelogs.com>
	<7vy5f3zlzj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 00:54:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Vrv-0001m4-Gl
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 00:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954Ab3BDXyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 18:54:13 -0500
Received: from z.lifelogs.com ([173.255.230.239]:54249 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754356Ab3BDXyM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 18:54:12 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 2640CDE0E0;
	Mon,  4 Feb 2013 23:54:12 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vy5f3zlzj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 04 Feb 2013 15:40:32 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215436>

On Mon, 04 Feb 2013 15:40:32 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> "Sorry we couldn't" sounded like an error messag to me.  If this is
JCH> a normal exit, then please make sure it is a normal exit.

OK; done in PATCHv4: removed all "Sorry" because they are not abnormal
exits.  I'll hold PATCHv4 until the below are known.

JCH> The review cycle is not like reviewers give you instructions and
JCH> designs and you blindly implement them.  It is a creative process
JCH> where you show the design and a clear implementation of that design.

OK.  I would like you to make the decisions I asked for, though:

- do you want to support backslashed newlines?
- do you want me to remove the statement modifiers?
- should all die() calls just print to STDERR and exit(0)?
- do you want to support multiple netrc files, as you and Peff suggested?

On all of those, I can go either way, it's just a little more work for me.

Ted
