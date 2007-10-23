From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 4/7] Bisect: factorise "bisect_write_*" functions.
Date: Wed, 24 Oct 2007 00:36:22 +0200
Message-ID: <471E7766.6000303@op5.se>
References: <20071014142938.d722299c.chriscool@tuxfamily.org> <7v640x7a4n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkSMY-0006EJ-Eg
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 00:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbXJWWg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2007 18:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755269AbXJWWg0
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 18:36:26 -0400
Received: from mail.op5.se ([193.201.96.20]:42126 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117AbXJWWgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 18:36:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EFBFE17306C0;
	Wed, 24 Oct 2007 00:34:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TSZCDa4AOTsX; Wed, 24 Oct 2007 00:34:19 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id EC0B017306B9;
	Wed, 24 Oct 2007 00:34:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7v640x7a4n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62167>

Junio C Hamano wrote:
> Sort of offtopic, but is "factorise" a correct verb here?  I
> thought "factorise" is to express a non prime number as the
> product of prime numbers.
>=20

It's the reverse of expanding brackets, like so:
2x=B2 + x - 3 =3D (2x + 3)(x - 1)

> "refactor" is the act of splitting and merging pieces of
> functions for better reuse, isn't it?
>=20

Yes.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
