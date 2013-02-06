From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: CodingGuidelines Perl amendment
Date: Wed, 06 Feb 2013 13:54:47 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87bobxgtmw.fsf@lifelogs.com>
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
	<CANgJU+VbkQ+xa+_sSAu-3pMe+6gycHi9J4VR18M5YJt=pa9QUw@mail.gmail.com>
	<87ip65guj8.fsf@lifelogs.com>
	<CANgJU+X=Bb=ncqOxsd1hZDWsnFkt-bJw=Zbtuz8_KC0gO-dLaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 19:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3A9I-00027f-Aq
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368Ab3BFSyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:54:50 -0500
Received: from z.lifelogs.com ([173.255.230.239]:46942 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755877Ab3BFSyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:54:49 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id D5F25DE0E3;
	Wed,  6 Feb 2013 18:54:48 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <CANgJU+X=Bb=ncqOxsd1hZDWsnFkt-bJw=Zbtuz8_KC0gO-dLaQ@mail.gmail.com>
	(demerphq@gmail.com's message of "Wed, 6 Feb 2013 19:44:16 +0100")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215622>

On Wed, 6 Feb 2013 19:44:16 +0100 demerphq <demerphq@gmail.com> wrote: 

d> Ah ok. Right, at a low level:

d> if (condition) { do_this() }

d> is identical to

d> condition && do_this();

d> IOW, Perl allows logical operators to act as control flow statements.

d> I hope your document include something that says that using logical
d> operators as control flow statements should be used sparingly, and
d> generally should be restricted to low precedence operators and should
d> never involve more than one operator.

I'd stay away from wording it so tightly, but instead just say

"Make your code readable and sensible, and don't try to be clever."

But this is good C and shell advice too, so I'd put it under "General
Guidelines" and leave it for Junio to decide if it's appropriate.

Ted
