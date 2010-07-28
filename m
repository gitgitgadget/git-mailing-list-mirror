From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git and binary files
Date: Wed, 28 Jul 2010 16:29:23 +0200
Message-ID: <vpqwrsf1xz0.fsf@bauges.imag.fr>
References: <AANLkTikceXUDDDcisnJRzg_i8mbi0TGwGiE5znAaK2aM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Dittmer <jdi@l4x.org>
X-From: git-owner@vger.kernel.org Wed Jul 28 16:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe7df-00083w-MR
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 16:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782Ab0G1O3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 10:29:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41466 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748Ab0G1O3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 10:29:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6SERcTT009056
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 16:27:38 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oe7dM-0004Cp-20; Wed, 28 Jul 2010 16:29:24 +0200
In-Reply-To: <AANLkTikceXUDDDcisnJRzg_i8mbi0TGwGiE5znAaK2aM@mail.gmail.com> (Jan Dittmer's message of "Wed\, 28 Jul 2010 16\:17\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Jul 2010 16:27:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6SERcTT009056
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280932061.4671@+kTkdUq6WfVqGFPw1mPdtw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152093>

Jan Dittmer <jdi@l4x.org> writes:

> The problem I'm facing is, that 'git status' is very
> very slow. They seem to read through every file in the directory
> tree. Is it possible to tell git to just use mtime/size information for
> an initial guess?

This is what it does by default. You probably need an initial "git
status" to be slow to get this information right in the index, though.

Have a look at git-bigfiles too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
