From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] for-each-ref: add option to omit newlines
Date: Fri, 14 Feb 2014 08:11:43 +0000 (UTC)
Message-ID: <loom.20140214T085928-630@post.gmane.org>
References: <1392314429-15281-1-git-send-email-oystwa@gmail.com> <xmqq38jmlqo6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 09:13:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEDte-0006pu-BT
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 09:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbaBNINO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Feb 2014 03:13:14 -0500
Received: from plane.gmane.org ([80.91.229.3]:39609 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbaBNINN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 03:13:13 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WEDsX-0005mi-MT
	for git@vger.kernel.org; Fri, 14 Feb 2014 09:13:09 +0100
Received: from 195.204.181.130 ([195.204.181.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 09:12:09 +0100
Received: from oystwa by 195.204.181.130 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 09:12:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.204.181.130 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242091>

Junio C Hamano <gitster <at> pobox.com> writes:

>=20
> I would rather see us go in the direction to add "-z" output option,
> which is what everybody else that produces NUL terminated entries in
> our suite of subcommands does.
>=20

I agree that -z would help in this case and I very much appreciate that
option when using diff --name-only, ls-files, etc.

However, when specifying a format string it's just a matter of ending
the format string in '%00' and you're good to go. But then you get the
null byte *and* a newline. And with your proposal there would be no way
of saying you want neither.

I expected the output to be formatted according to a (repetition of) th=
e
format string, not some variation of it that I couldn't opt out of. But
I see that git-log also shows this behavior and already has a -z option=
,
so I guess that's fairly ingrained.

Maybe it's just me? In that case I've no problem with throwing in the
towel.

=C3=98sse
