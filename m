From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 23:26:27 +0100
Message-ID: <60F92BD7-6FFF-4D9A-B2F0-0858F4E90B59@wincent.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org> <20091125214949.GA31473@coredump.intra.peff.net> <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQnZ-0003TU-5o
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759404AbZKYW5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 17:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759234AbZKYW5H
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:57:07 -0500
Received: from outmail128088.authsmtp.com ([62.13.128.88]:60851 "EHLO
	outmail128088.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759250AbZKYW5G convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:57:06 -0500
X-Greylist: delayed 1829 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 17:57:05 EST
Received: from mail-c187.authsmtp.com (mail-c187.authsmtp.com [62.13.128.33])
	by punt8.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id nAPMQZWn027700;
	Wed, 25 Nov 2009 22:26:35 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id nAPMQVtV043348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Nov 2009 22:26:32 GMT
Received: from [192.168.1.2] (231.Red-83-60-136.dynamicIP.rima-tde.net [83.60.136.231])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id nAPMQReP014788
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 25 Nov 2009 17:26:30 -0500
In-Reply-To: <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: 95e405f5-da11-11de-ab46-001185d377ca
X-Report-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJCUVH aBsdCF1NdwdEHQAR AWQBWVJeU14/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSnQIfH1n QngeVhpxcw0IcHd4 YAhrWyVfXEEscFsp E09VCGwHMTJ9OTIb Vl1YdwJVeAYefRhC OQExNiYHcQ5nFx4T Pzp7MCo8JWcXbWFb XwUJaE4ITEtj
X-Authentic-SMTP: 61633436303433.1000:706/Kp
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133694>

El 25/11/2009, a las 23:12, James Pickens escribi=F3:

> I like Junio's suggestion to make paths starting with / anchored to =20
> the
> top.

Oh, I wouldn't like that at all. I think it would be a very ugly UI =20
wart, because it would basically make Git behave differently than =20
every other command line tool that accepts paths. If it is to deviate =20
from the extremely widespread convention that paths starting with / =20
refer to absolute paths rooted at the root of the filesystem, then the =
=20
justification for it would need to be very strong indeed.

Cheers,
Wincent
