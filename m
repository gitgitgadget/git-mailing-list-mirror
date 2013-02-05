From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Tue, 05 Feb 2013 16:00:53 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87y5f2pjay.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com>
	<7vip66sftf.fsf@alter.siamese.dyndns.org>
	<87bobyr0ju.fsf@lifelogs.com>
	<7vd2wese6z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 22:01:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2pdm-00067l-Se
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 22:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670Ab3BEVAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 16:00:55 -0500
Received: from z.lifelogs.com ([173.255.230.239]:40295 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640Ab3BEVAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 16:00:54 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id C331ADE0E3;
	Tue,  5 Feb 2013 21:00:53 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vd2wese6z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 05 Feb 2013 12:23:00 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215540>

On Tue, 05 Feb 2013 12:23:00 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Ted Zlatanov <tzz@lifelogs.com> writes:
JCH> You still need to parse a file that has a "default" entry correctly;
JCH> otherwise the users won't be able to share existing .netrc files
JCH> with other applications e.g. ftp, which is the whole point of this
JCH> series.  Not using values from the "default" entry is probably fine,
JCH> though.
>> 
>> OK; done in PATCHv4.

JCH> Hmph.

JCH> Didn't you remove that from your version of net_netrc_loader when
JCH> you borrowed the bulk of the code from Net::Netrc::_readrc?  I see
JCH> "default" token handled at the beginning of "TOKEN: while (@tok)"
JCH> loop in the original but not in your version I see in v4.

Damn, I accidentally moved that check to /dev/null.  OK, I added it in
PATCHv5.  Thanks for catching that.

Ted
