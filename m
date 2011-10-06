From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] git stash -k show the help message for diff-index
Date: Thu, 06 Oct 2011 11:54:21 +0200
Message-ID: <vpqhb3mcunm.fsf@bauges.imag.fr>
References: <vpqfwj7v5cx.fsf@bauges.imag.fr>
	<7v4nzn8hcp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 11:54:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBkf2-0005gw-Et
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 11:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab1JFJya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 05:54:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36080 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300Ab1JFJy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 05:54:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p969ptIv022339
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Oct 2011 11:51:55 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RBkej-0002z3-9B; Thu, 06 Oct 2011 11:54:21 +0200
In-Reply-To: <7v4nzn8hcp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 05 Oct 2011 10:43:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 06 Oct 2011 11:51:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p969ptIv022339
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1318499519.18814@/VfzPCPqAE2Am1w7j+IgFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182937>

Junio C Hamano <gitster@pobox.com> writes:

> Hmm, does not reproduce.
>
> : alter victim-2.git/master; git status
> # On branch master
> nothing to commit (working directory clean)
> : alter victim-2.git/master; git stash -k
> No local changes to save
> : alter victim-2.git/master; git version
> git version 1.7.7

Sorry, I should have mentionned that: I had the bug with next.

I've tried bisecting it down, but the bug mysteriously disappeared
during the bisect (I did have bad and good commits during bisect, but at
the end, I had only good commits, and the bad ones weren't
reproducible).

I can't reproduce anymore.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
