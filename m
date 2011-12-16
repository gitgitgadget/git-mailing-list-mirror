From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Add '-P' as a synonym for '--no-pager' in the git command
Date: Fri, 16 Dec 2011 10:30:09 +0100
Message-ID: <vpqliqc50f2.fsf@bauges.imag.fr>
References: <1323982541-18995-1-git-send-email-jratt0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, git@vger.kernel.org
To: Joe Ratterman <jratt0@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 10:30:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbU7a-0002Dw-G2
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 10:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760231Ab1LPJaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 04:30:21 -0500
Received: from mx1.imag.fr ([129.88.30.5]:32908 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759876Ab1LPJaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 04:30:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id pBG9O9wK012343
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Dec 2011 10:24:09 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RbU7F-0004zD-O2; Fri, 16 Dec 2011 10:30:09 +0100
In-Reply-To: <1323982541-18995-1-git-send-email-jratt0@gmail.com> (Joe
	Ratterman's message of "Thu, 15 Dec 2011 14:55:41 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 16 Dec 2011 10:24:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: pBG9O9wK012343
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1324632252.85744@cpeCQibj6CscFvUJxgRdbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187267>

Joe Ratterman <jratt0@gmail.com> writes:

>   Also, add both -P|--no-pager to the existing -p|--paginate in bash
>   completion.

A good commit message should always answer the question "why?". In this
case, I really don't see why this is needed. If you don't like Git's
auto-paginate feature, turn it off with core.pager or pager.<cmd>. If
you like it, you very rarely need --no-pager (IIRC, I'm the one who
introduced --no-pager, and I don't think I've ever used it outside a
script).

So, I'd rather keep -P free in case we need it later for something
really useful (or possibly a better commit message).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
