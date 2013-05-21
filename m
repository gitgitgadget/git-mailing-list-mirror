From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: activate color.ui by default (Re: What's cooking in git.git (May 2013, #05; Mon, 20))
Date: Tue, 21 May 2013 13:47:43 +0200
Message-ID: <vpqd2skzh9c.fsf@grenoble-inp.fr>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 13:47:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uel2s-0007lT-0r
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 13:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab3EULry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 07:47:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45461 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340Ab3EULrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 07:47:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4LBlgMC022038
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 21 May 2013 13:47:42 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uel2d-0000ga-Eo; Tue, 21 May 2013 13:47:43 +0200
In-Reply-To: <7v38thrxwo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 20 May 2013 17:15:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 21 May 2013 13:47:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4LBlgMC022038
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369741665.13588@OHde36NuYXeJZ+hnJNd3JA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225028>

Junio C Hamano <gitster@pobox.com> writes:

> * mm/color-auto-default (2013-05-15) 2 commits
>  - make color.ui default to 'auto'
>  - config: refactor management of color.ui's default value
>
>  Flip the default for color.ui to 'auto', which is what many
>  tutorials recommend new users to do.
>
>  I think this is ready for 'next', but we may want to audit tutorials
>  to see if we need to adjust them if they suggest to set color.ui as
>  the first thing to do when they meet Git.

The little grepping I did in our docs didn't show much about color.ui,
and nothing about its default value (just technical documentation, not
beginner-oriented).

Other than that, the patch makes the doc say "... `auto` (this is the
default since Git 2.0)". I'm slightly in favor of delaying the change
until Git 2.0 and keeping it as-is, but I'm OK with letting it in the
next minor version if other people think it should (I did not see strong
opinion on that, but I think the general opinion from the discussion was
it would be OK). If so, I can resend without the 2.0 mention (or Junio
can edit it locally).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
