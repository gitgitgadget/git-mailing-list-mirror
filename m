From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Wed, 08 Jun 2011 19:34:09 +0200
Message-ID: <vpqlixcns6m.fsf@bauges.imag.fr>
References: <20110607200659.GA6177@sigill.intra.peff.net>
	<7vvcwh4ako.fsf@alter.siamese.dyndns.org>
	<20110607214532.GB7663@sigill.intra.peff.net>
	<m3hb80dynr.fsf@localhost.localdomain>
	<vpqtyc0nsfw.fsf@bauges.imag.fr>
	<20110608173012.GA4279@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:40:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMja-0007Ze-1O
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab1FHRj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 13:39:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36028 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab1FHRj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 13:39:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p58HY8wx006421
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 8 Jun 2011 19:34:08 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QUMdu-0005Mt-1k; Wed, 08 Jun 2011 19:34:10 +0200
In-Reply-To: <20110608173012.GA4279@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 8 Jun 2011 13:30:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 08 Jun 2011 19:34:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p58HY8wx006421
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1308159248.99429@e/wj2XDYRw+80ognnVJnlg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175412>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 08, 2011 at 07:28:35PM +0200, Matthieu Moy wrote:
>
>> > Jeff King <peff@peff.net> writes:
>> >
>> > * @{wtree} would confuse users that it has something to do with reflog
>> 
>> Well, we already have @{upstream} ...
>
> Yes, but like all of the @{} things, it's a modifier for the left-hand
> side. So "master@{upstream}" is meaningful, and "@{upstream}" is the
> same as "HEAD@{upstream}".
>
> What does "master@{wtree}" mean?

Nothing, but then we already have @{-1} ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
