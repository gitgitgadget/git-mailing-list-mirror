From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: git cherry not marking commits with equivalent upstream
Date: Thu, 01 Jul 2010 14:17:01 -0700
Message-ID: <1278017685-sup-6132@pimlott.net>
References: <1278012954-sup-3724@pimlott.net> <20100701204151.GA6354@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?q?Bj=C3=B6rn_Steinbrink?= <b.steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 01 23:24:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OURF4-0005v5-S3
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 23:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925Ab0GAVYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 17:24:06 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from pimlott.net ([72.249.23.100]:2144 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759331Ab0GAVRE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 17:17:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=default; d=pimlott.net;
	h=Received:Content-Type:Cc:Subject:From:To:In-reply-to:References:Date:Message-Id:User-Agent:Content-Transfer-Encoding;
	b=Mm6xjR5BmVZgNzJ7iDXP56UsMjDGFOB4MNgu6kDuDCn2U0NIcykzq3daUEwnE5FuwMFb8pM+j84E+tStzDvOW2kUN/3dHw1fLpv5Ks9FjUMe95t5lySqDXiAhByRT6/wEbA6g+bR3B1V1AMdkb1xVXf1+Es834UsQVSkUueh3nE=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.69)
	(envelope-from <andrew@pimlott.net>)
	id 1OUR81-0001i3-PX; Thu, 01 Jul 2010 14:17:01 -0700
In-reply-to: <20100701204151.GA6354@atjola.homenet>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150085>

Excerpts from Bj=C3=B6rn Steinbrink's message of Thu Jul 01 13:41:51 -0=
700 2010:
> pull =3D fetch + merge, so your history in "b" looks like this:
>=20
>   2 (origin/master)
>  / \
> 1   M (master)
>  \ /
>   3
>=20
> So "2" is common to both branches and thus ignored by cherry.

Ok, it's unintuitive to me that 2 is not considered part of the upstrea=
m
branch just because I've merged it into mine, but that explains it.
Thanks!

However, I want to merge commits from upstream regularly and still
figure out what unmerged commits I have.  So how can I make this use
case work?  It sounds like I want to make git-cherry check against
everything upstream since the fork point, not just what I haven't
merged.  Would this be hard?

Andrew
