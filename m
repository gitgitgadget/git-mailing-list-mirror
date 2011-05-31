From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: speed of git reset -- file
Date: Wed, 01 Jun 2011 00:13:39 +0200
Message-ID: <vpqr57e1pt8.fsf@bauges.imag.fr>
References: <20110531190015.GA12113@gnu.kitenet.net>
	<20110531212639.GA13234@sigill.intra.peff.net>
	<7vpqmyilj6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Joey Hess <joey@kitenet.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:13:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRXCG-0006dT-55
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 00:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758498Ab1EaWNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 18:13:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45585 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758469Ab1EaWNu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 18:13:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p4VMDb2s010296
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 Jun 2011 00:13:37 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QRXBz-0000bZ-NQ; Wed, 01 Jun 2011 00:13:39 +0200
In-Reply-To: <7vpqmyilj6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 31 May 2011 14:54:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 01 Jun 2011 00:13:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4VMDb2s010296
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1307484820.32338@jmgj7OxBg6OBRnhHjAq4Zw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174835>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Conceptually, no, I don't think so.
>
> Hmm, don't we have to say like all other reset types which paths are
> dirty, i.e.
>
>   $ git reset HEAD -- diff.c
>   Unstaged changes after reset:
>   M       diff.c
>   M       diff.h
>
> which would mean we would need to refresh the index anyway?

This reminder is handy, but I can understand that people with really big
trees whish to stat all the files only as needed (and would need to run
"git status" by hand when needed). We can imagine a config variable like
core.IHaveAReallyBigTree or so disabled by default for such cases.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
