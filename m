From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Wed, 08 Jun 2011 19:28:35 +0200
Message-ID: <vpqtyc0nsfw.fsf@bauges.imag.fr>
References: <20110607200659.GA6177@sigill.intra.peff.net>
	<7vvcwh4ako.fsf@alter.siamese.dyndns.org>
	<20110607214532.GB7663@sigill.intra.peff.net>
	<m3hb80dynr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:29:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMZG-0002Vy-A3
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab1FHR3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 13:29:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51628 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509Ab1FHR3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 13:29:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p58HSYQ2005520
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 8 Jun 2011 19:28:34 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QUMYW-0005Hj-6O; Wed, 08 Jun 2011 19:28:36 +0200
In-Reply-To: <m3hb80dynr.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Wed, 08 Jun 2011 10:25:27 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 08 Jun 2011 19:28:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p58HSYQ2005520
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1308158918.07032@bqX/W/690lfqyY73tBNh6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175408>

Jakub Narebski <jnareb@gmail.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I find the all-caps ugly, and it is part of what confuses them with
>> HEAD. At the same time, we are using the same namespace that ref lookup
>> uses. So calling it "worktree" might be too ambiguous. I tried to avoid
>> using "--worktree" because I wanted to make it clear that these were
>> ordered arguments, not options.
>
> Perhaps we can use some character that is forbidden in ref names,
> doesn't make trouble when doing allowed operations on said refs, won't
> confuse user, and is not trouble with shell... ehhh...
>
> * @{wtree} would confuse users that it has something to do with reflog

Well, we already have @{upstream} ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
