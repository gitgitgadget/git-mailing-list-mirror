From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [RFC/PATCH 0/5] macro-based key/value maps
Date: Fri, 05 Aug 2011 17:31:37 +0200
Message-ID: <4E3C0CD9.4020902@lsrfire.ath.cx>
References: <20110713064709.GA18499@sigill.intra.peff.net> <20110713065700.GA18566@sigill.intra.peff.net> <20110713175250.GA1448@elie> <20110713200814.GD31965@sigill.intra.peff.net> <20110714173454.GA21657@sigill.intra.peff.net> <7vipr4373f.fsf@alter.siamese.dyndns.org> <20110804224354.GA27476@sigill.intra.peff.net> <20110805110302.GA23619@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 05 17:31:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpMNM-0007dx-Mb
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 17:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab1HEPbr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Aug 2011 11:31:47 -0400
Received: from india601.server4you.de ([85.25.151.105]:47964 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab1HEPbr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 11:31:47 -0400
Received: from [192.168.2.104] (p579BE51C.dip.t-dialin.net [87.155.229.28])
	by india601.server4you.de (Postfix) with ESMTPSA id 200D42F8035;
	Fri,  5 Aug 2011 17:31:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110805110302.GA23619@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178798>

Am 05.08.2011 13:03, schrieb Jeff King:
>   Commits 1, 4, and 5 introduce infrastructure in the form of static
>   functions and macros that contain functions that call the statics. =
But
>   they don't actually instantiate the macro functions themselves, so
>   they won't compile with -Werror (due to the "unused static" warning=
)
>   until there is some calling code.
>=20
>   That hurts bisectability a little if you compile with -Werror (you
>   need to add -Wno-error=3Dunused-function). I don't know how much we
>   care.

I don't know either, but you could avoid the issue by adding a test-map=
s
command in the first patch and exercising the new functionality a bit.

Ren=C3=A9
