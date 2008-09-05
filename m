From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] add '%d' pretty format specifier to show decoration
Date: Thu, 04 Sep 2008 17:28:13 -0700
Message-ID: <7v7i9r1lnm.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0809032036270.32295@pollux>
 <20080903191217.GA31195@coredump.intra.peff.net>
 <7v4p4xat3v.fsf@gitster.siamese.dyndns.org>
 <20080903203616.GB32223@coredump.intra.peff.net>
 <7vsksh9c9m.fsf@gitster.siamese.dyndns.org> <48BF0A5A.2040502@lsrfire.ath.cx>
 <20080904035139.GA28123@sigill.intra.peff.net>
 <48C002FB.9010401@lsrfire.ath.cx> <48C055B3.3030204@lsrfire.ath.cx>
 <20080905001133.GA17463@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 05 02:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbPCb-0001rN-WA
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 02:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbYIEA2X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2008 20:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbYIEA2X
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 20:28:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbYIEA2W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2008 20:28:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5546573913;
	Thu,  4 Sep 2008 20:28:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1F53D7390A; Thu,  4 Sep 2008 20:28:15 -0400 (EDT)
In-Reply-To: <20080905001133.GA17463@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 4 Sep 2008 20:11:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8B3F38A8-7AE1-11DD-9CA9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94982>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 04, 2008 at 11:40:03PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Michael Dressel implemented an initial version and chose the letter =
d,
>> Junio suggested to add a leading space and parentheses.
>
> The whole series looks good to me, and I am happy if it is applied
> as-is. The only question I might raise is whether we want to use "%d"
> for this, or use something longer to anticipate a collision with othe=
r
> "d" words (I think you mentioned "describe" at one point).

How about using "%d()" for this one, so that later enhancements can
specify their features inside parentheses?
