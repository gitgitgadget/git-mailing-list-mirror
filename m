From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] add '%d' pretty format specifier to show decoration
Date: Fri, 05 Sep 2008 18:14:55 +0200
Message-ID: <48C15AFF.3070806@lsrfire.ath.cx>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org> <48BF0A5A.2040502@lsrfire.ath.cx> <20080904035139.GA28123@sigill.intra.peff.net> <48C002FB.9010401@lsrfire.ath.cx> <48C055B3.3030204@lsrfire.ath.cx> <20080905001133.GA17463@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 05 18:16:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbdyk-0000it-Jk
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 18:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbYIEQPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 12:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbYIEQPA
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 12:15:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:53692 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbYIEQO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 12:14:59 -0400
Received: from [10.0.1.200] (p57B7D008.dip.t-dialin.net [87.183.208.8])
	by india601.server4you.de (Postfix) with ESMTPSA id 1258B2F8045;
	Fri,  5 Sep 2008 18:14:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080905001133.GA17463@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95021>

Jeff King schrieb:
> On Thu, Sep 04, 2008 at 11:40:03PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> Michael Dressel implemented an initial version and chose the letter =
d,
>> Junio suggested to add a leading space and parentheses.
>=20
> The whole series looks good to me, and I am happy if it is applied
> as-is. The only question I might raise is whether we want to use "%d"
> for this, or use something longer to anticipate a collision with othe=
r
> "d" words (I think you mentioned "describe" at one point).

%d for decorations is OK, I think -- we still can use %D for describe.
When someone implements it eventually. *cough* ;-)

Thanks,
Ren=C3=A9
