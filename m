From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 12:53:05 +0100
Message-ID: <vpq7gyklq3i.fsf@bauges.imag.fr>
References: <4F63205A.6000202@seap.minhap.es> <vpqlin0n8w5.fsf@bauges.imag.fr>
	<4F632543.50402@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri Mar 16 12:53:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Vij-0007kg-3F
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 12:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720Ab2CPLxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 07:53:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:32796 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031279Ab2CPLxP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 07:53:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2GBmYXL014051
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Mar 2012 12:48:34 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S8ViU-0003gD-I9; Fri, 16 Mar 2012 12:53:06 +0100
In-Reply-To: <4F632543.50402@seap.minhap.es> (Nelson Benitez Leon's message of
	"Fri, 16 Mar 2012 12:34:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 16 Mar 2012 12:48:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2GBmYXL014051
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332503319.54996@vZYdNuKi0bn5JSFnGhQDzA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193254>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

>>   You can re-order the lines to change the order of commits in history.
>
> I like it but the word 'history' seems a bit too technical for me, and may
> scare the normal user,, what about:
>
> You can re-order the lines to change the order the commits are applied.

Perfect. "are applied" says more than my "in history", since rebase -i
is all about various ways to apply commits.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
