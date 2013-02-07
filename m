From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: overriding/removing inherited credential.helper, Do not add an empty value from config credential.helper
Date: Thu, 07 Feb 2013 13:38:06 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <871ucsc6lt.fsf@lifelogs.com>
References: <CAHtLG6QaHOOYgVFPyOWo44-jTX__cd0dCyu+vs+Uf4_U-HxySw@mail.gmail.com>
	<87pq0cchsz.fsf@lifelogs.com>
	<7vvca47zl3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 19:38:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3WMj-0006F5-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 19:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069Ab3BGSiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 13:38:10 -0500
Received: from z.lifelogs.com ([173.255.230.239]:52643 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757423Ab3BGSiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 13:38:08 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id ABE3FDE0E3;
	Thu,  7 Feb 2013 18:38:07 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vvca47zl3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 07 Feb 2013 10:23:20 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215709>

On Thu, 07 Feb 2013 10:23:20 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> "Clear everything you saw so far" would be useful for variables
JCH> other than "credential.helper"; shouldn't it be done by adding a
JCH> general syntax to the configuration file format and teach the
JCH> configuration parser to clear the cumulative definitions so far?

That's a question for the configuration parser, right?  I don't have an
informed opinion on how it should be implemented, and am OK with any
syntax to clear a variable.

Ted
