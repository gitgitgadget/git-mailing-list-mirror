From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Thu, 31 Jan 2013 10:23:51 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87pq0l5qbc.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Michal Nazarewicz <mpn@google.com>,
	git@vger.kernel.org, Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 16:33:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0w8N-00066r-VL
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 16:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215Ab3AaPcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 10:32:42 -0500
Received: from z.lifelogs.com ([173.255.230.239]:33682 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab3AaPcl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 10:32:41 -0500
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2013 10:32:41 EST
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 97D876E57E;
	Thu, 31 Jan 2013 15:23:52 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
Gmane-Reply-To-List: yes
In-Reply-To: <7v7gmumzo6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 30 Jan 2013 07:57:29 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215117>

On Wed, 30 Jan 2013 07:57:29 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Jeff King <peff@peff.net> writes:
>> But it would probably make sense for send-email to support the existing
>> git-credential subsystem, so that it can take advantage of secure
>> system-specific storage. And that is where we should be pointing new
>> users. I think contrib/mw-to-git even has credential support written in
>> perl, so it would just need to be factored out to Git.pm.

JCH> Yeah, that sounds like a neat idea.

Jeff, is there a way for git-credential to currently support
authinfo/netrc parsing?  I assume that's the right way, instead of using
Michal's proposal to parse internally?

I'd like to add that, plus support for the 'string' and "string"
formats, and authinfo.gpg decoding through GPG.  I'd write it in Perl,
if there's a choice.

Ted
