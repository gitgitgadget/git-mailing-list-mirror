From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Wed, 08 Jun 2011 20:01:35 +0200
Message-ID: <vpq62ogkxs0.fsf@bauges.imag.fr>
References: <20110607200659.GA6177@sigill.intra.peff.net>
	<20110608173012.GA4279@sigill.intra.peff.net>
	<vpqlixcns6m.fsf@bauges.imag.fr> <201106081950.04910.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:04:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUN7P-00037E-6F
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab1FHSEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:04:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45267 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187Ab1FHSEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:04:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p58I1XxJ008456
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 8 Jun 2011 20:01:33 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QUN4R-0005qm-Jw; Wed, 08 Jun 2011 20:01:35 +0200
In-Reply-To: <201106081950.04910.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 8 Jun 2011 19:50:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 08 Jun 2011 20:01:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p58I1XxJ008456
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1308160894.69475@YNEMq88KEUtniGviOGvggg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175416>

Jakub Narebski <jnareb@gmail.com> writes:

> Matthieu Moy wrote:
>> Jeff King <peff@peff.net> writes:
>> > On Wed, Jun 08, 2011 at 07:28:35PM +0200, Matthieu Moy wrote:
>> >> > Jeff King <peff@peff.net> writes:
>> >> >
>> >> > * @{wtree} would confuse users that it has something to do with reflog
>> >> 
>> >> Well, we already have @{upstream} ...
>> >
>> > Yes, but like all of the @{} things, it's a modifier for the left-hand
>> > side. So "master@{upstream}" is meaningful, and "@{upstream}" is the
>> > same as "HEAD@{upstream}".
>> >
>> > What does "master@{wtree}" mean?
>> 
>> Nothing, but then we already have @{-1} ;-).
>
> That's actually HEAD reflog.

Yes, but neither HEAD@{-1} nor master@{-1} work. So we have one instance
of @{...} which is unrelated from reflog, and another which isn't a
suffix. @{wtree} would be both.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
