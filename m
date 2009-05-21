From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCHv2 1/2] parse-options: add PARSE_OPT_LITERAL_ARGHELP for
 complicated argh's
Date: Thu, 21 May 2009 18:51:51 +0200
Message-ID: <4A1586A7.9000909@lsrfire.ath.cx>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com>	<fbaa26d941f496efefc30e298f5534f8194ee716.1242891030.git.bebarino@gmail.com> <7v3aaybewo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 18:53:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7BWB-0004Yf-Bg
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 18:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960AbZEUQvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 12:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756944AbZEUQvy
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 12:51:54 -0400
Received: from india601.server4you.de ([85.25.151.105]:39602 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836AbZEUQvx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 12:51:53 -0400
Received: from [10.0.1.101] (p57B7DF15.dip.t-dialin.net [87.183.223.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 856DA2F8044;
	Thu, 21 May 2009 18:51:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7v3aaybewo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119699>

Junio C Hamano schrieb:
> Stephen Boyd <bebarino@gmail.com> writes:
>=20
>> I've decided to appease the pirate haters :-)
>=20
> Hmmm, why does this break t0040 (I am queuing this on top of 5acb3e5)=
?

Probably because it changes this:

	pos +=3D fprintf(...);

into this (simplified, usage_argh() expanded):

	pos +=3D pos + fprintf(...);

usage_argh() doesn't need the parameter pos.

Ren=E9
