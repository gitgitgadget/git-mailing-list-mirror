From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to and --bcc
Date: Tue, 18 Jun 2013 17:05:14 +0200
Message-ID: <vpqehbzpihh.fsf@anie.imag.fr>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	<7vip1b8nut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, git@vger.kernel.org,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 17:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoxVA-0000ad-0S
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308Ab3FRPHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 11:07:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43130 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756116Ab3FRPHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 11:07:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5IF5DrW029078
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 17:05:13 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UoxT8-00065y-Uv; Tue, 18 Jun 2013 17:05:14 +0200
In-Reply-To: <7vip1b8nut.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 18 Jun 2013 08:01:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Jun 2013 17:05:13 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228248>

Junio C Hamano <gitster@pobox.com> writes:

> Doesn't
>
> 	git send-email --to='Foo <foo@example.com>' --to='bar@example.com'
>
> work?  If it does, I do not see much point of this change.  If you
> are starting from two pieces of information, why combine it into
> one, only have the program to split it again, risking to be bitten
> by bugs, and changing the code to do so, risking to add new bugs?

The obvious use-case is to copy-paste a list of addresses from an email.
Currently, the Cc: list of the email I'm sending looks like

Cc: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr,  git@vger.kernel.org,  Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>

If I were to use "git send-email" on it, I'd have to cut the list
myself.

This could be mentionned in the commit message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
