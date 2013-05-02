From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/3] Add colors to interactive git-clean
Date: Thu, 02 May 2013 17:07:22 +0200
Message-ID: <vpqhailfmj9.fsf@grenoble-inp.fr>
References: <6e795640952cad0eb25cb0db4243b2712f11e957.1367500374.git.worldhello.net@gmail.com>
	<3b80db3d2e8f31b1d9373406cce3cbdee2094a29.1367500374.git.worldhello.net@gmail.com>
	<vpq38u6n397.fsf@grenoble-inp.fr>
	<bb5463fa4ef09df08ad3bf5abf4660a5df414e64.1367500374.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 17:07:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXv6f-0006ww-CN
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 17:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab3EBPHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 11:07:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51596 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042Ab3EBPHc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 11:07:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r42F7LNw027562
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 May 2013 17:07:21 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UXv6R-0007cA-1C; Thu, 02 May 2013 17:07:23 +0200
In-Reply-To: <bb5463fa4ef09df08ad3bf5abf4660a5df414e64.1367500374.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Thu, 2 May 2013 21:15:04 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 02 May 2013 17:07:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r42F7LNw027562
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368112044.62953@YcBA4vP3xIHBbaG7mmSwYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223212>

Jiang Xin <worldhello.net@gmail.com> writes:

> Show help, error messages, and prompt in colors for interactive
> git-clean.

I find the red WARNING a bit agressive. Also, the NOTE: is the same
color as the WARNING, hence visually similar. I first thought it was
repeating the same message. I think it would make more sense to use
default color, black, for the NOTE, by analogy with "git add -p" which
uses it for patch hunk headers (somehow, this is the question you're
replying to after the blue prompt below).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
