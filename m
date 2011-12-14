From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Revert "http: don't always prompt for password"
Date: Wed, 14 Dec 2011 09:20:45 +0100
Message-ID: <vpqr507d0o2.fsf@bauges.imag.fr>
References: <20111213201704.GA12072@sigill.intra.peff.net>
	<20111213202508.GA12187@sigill.intra.peff.net>
	<7vaa6wuqjt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Stefan Naewe <stefan.naewe@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 09:21:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rak5K-0001ju-7b
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 09:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab1LNIVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 03:21:00 -0500
Received: from mx1.imag.fr ([129.88.30.5]:39080 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263Ab1LNIU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 03:20:59 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id pBE8EqUk002117
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Dec 2011 09:14:52 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Rak50-0001h8-CH; Wed, 14 Dec 2011 09:20:46 +0100
In-Reply-To: <7vaa6wuqjt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 13 Dec 2011 13:09:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 Dec 2011 09:14:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: pBE8EqUk002117
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1324455293.26768@Sw5FCjLA4T096hxjW1Eu6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187099>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Doing (3) is obviously the easiest thing. And given the complexity of
>> the other two solutions, I think it makes sense to revert 986bbc08
>> (i.e., apply this patch), ship a working v1.7.8.1, and then look at
>> doing one of the other two solutions for v1.7.9.
>
> Or just let the "dumb HTTP" die.
>
> I thought push over DAV has long been dead; is anybody using it for real?

I am.

I'm working with people behind a firewall, hence HTTP is mandantory. My
lab has a webdav server, without Git installed on it. Being able to work
with this setup was one of the key feature of Git when I adopted it
(after a few years using GNU Arch the same way).

I could probably manage to convince my sysadmin to install Git on our
webserver, but I'd prefer if Git continues supporting my current setup.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
