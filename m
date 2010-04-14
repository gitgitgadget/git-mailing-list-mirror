From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: git log of remote repositories.
Date: Wed, 14 Apr 2010 22:39:29 +0200
Message-ID: <20100414203929.GA10201@dualtron.lan>
References: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com>
 <slrnhsba0k.h9q.heipei@dualtron.heipei.net>
 <x2q3abd05a91004141208x6e154385l8b7ce6488d65f21b@mail.gmail.com>
 <20100414194552.GA5178@dualtron.lan>
 <w2s3abd05a91004141305h28d69d44g2fcb69abe578dbcc@mail.gmail.com>
 <r2rfabb9a1e1004141311sa27dedf2h8bfff789a6ef1200@mail.gmail.com>
 <z2m3abd05a91004141318mdf91a7aapf66b742192fc44a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:38:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29MP-0002hD-O3
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703Ab0DNUiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:38:55 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:35325 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678Ab0DNUiy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:38:54 -0400
Received: from u-7-245.vpn.rwth-aachen.de ([137.226.103.245]:49797 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1O29MK-0006PR-FH; Wed, 14 Apr 2010 22:38:52 +0200
Content-Disposition: inline
In-Reply-To: <z2m3abd05a91004141318mdf91a7aapf66b742192fc44a3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 137.226.103.245
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144910>

On 14/04/10 16:18, Aghiles wrote:
> Yes, size can be an issue. Additionally, git fetch will probably update
> some references, like FETCH_HEAD, no ? I might want these
> untouched, if possible.

Besides the space-problem: If you worry about losing already-fetched
history (because the guy upstream forgot to take his meds and has
deleted all the history and your remote is configured to accept non-ff
refs) you still have the reflog to get back.

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://heipei.net
GPG-Key: 0xD47A7FFC
GPG-Fingerprint: 5441 D425 6D4A BD33 B580  618C 3CDC C4D0 D47A 7FFC
