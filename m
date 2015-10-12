From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Mon, 12 Oct 2015 22:21:24 +0200
Message-ID: <vpqsi5fx2gr.fsf@grenoble-inp.fr>
References: <561C1132.3090606@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>
X-From: git-owner@vger.kernel.org Mon Oct 12 22:21:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZljbA-0005ut-H0
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 22:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbbJLUV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 16:21:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56775 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbbJLUV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 16:21:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9CKLL8e018734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 12 Oct 2015 22:21:21 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9CKLOxJ019679;
	Mon, 12 Oct 2015 22:21:24 +0200
In-Reply-To: <561C1132.3090606@orange.fr> (Francois-Xavier Le Bail's message
	of "Mon, 12 Oct 2015 21:59:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 12 Oct 2015 22:21:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9CKLL8e018734
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445286082.87766@Wqww0JXf/4WOkEtzyaadEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279416>

Francois-Xavier Le Bail <devel.fx.lebail@orange.fr> writes:

> Hello,
>
> [I try some search engines without success, perhaps I have missed something].
>
> For example, if I rebase the following commits, I would want that if
> the commit hash 2222222... become 7777777...,
> the message
> "Update test output for 2222222222222222222222222222222222222222"
> become
> "Update test output for 7777777..."
>
> Is it possible currently? And if yes how?

AFAIK, it's not possible other than by editing the message by hand.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
