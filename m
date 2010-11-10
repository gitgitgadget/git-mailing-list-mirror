From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Wed, 10 Nov 2010 17:00:30 +0100
Message-ID: <vpqtyjpw4m9.fsf@bauges.imag.fr>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
	<20101104112530.5c0e444a@chalon.bertin.fr>
	<4CD2E7B4.3000908@nextest.com> <vpq62wddmc0.fsf@bauges.imag.fr>
	<20101104181020.GB16431@burratino> <20101104205307.GA8911@home.lan>
	<7vd3qfr7ki.fsf@alter.siamese.dyndns.org>
	<663A3F43-5F64-41F0-B272-64EEE9775250@sb.org>
	<20101108222937.GH3167@home.lan> <20101110014215.GA1503@burratino>
	<20101110084343.0c519764@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Yann Dirson <ydirson@free.fr>, Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raible <raible@nextest.com>, git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Wed Nov 10 17:03:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGD9A-0003H2-Gd
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 17:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757Ab0KJQDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 11:03:34 -0500
Received: from mx1.imag.fr ([129.88.30.5]:58178 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756488Ab0KJQDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 11:03:34 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oAAFj8L7004214
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 10 Nov 2010 16:45:08 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PGD66-0001rS-UW; Wed, 10 Nov 2010 17:00:30 +0100
In-Reply-To: <20101110084343.0c519764@chalon.bertin.fr> (Yann Dirson's message of "Wed\, 10 Nov 2010 08\:43\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 10 Nov 2010 16:45:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oAAFj8L7004214
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1290008709.77699@CJ+qEHQUs3UmqHANGZXXng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161155>

Yann Dirson <dirson@bertin.fr> writes:

> BTW, about people feeling at ease with "rebase -i", I often feel not
> quite comfortable to explain why to reorder commits you have to use
> this "rebase" feature

I feel a bit the same. Actually, I don't think I ever used "rebase -i"
to actually perform a rebase. I usually "git pull --rebase" to rebase,
and "rebase -i" to rewrite history without changing the origin of the
branch.

> alias.reroll = rebase -i $(git merge-base HEAD @{upstream})

Mercurial calls this "histedit" for example.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
