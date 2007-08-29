From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] t5701: "wc -l" may add whitespace
Date: Wed, 29 Aug 2007 18:55:53 +0200
Message-ID: <vpqbqcqi8km.fsf@bauges.imag.fr>
References: <Pine.LNX.4.64.0708291752050.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 29 18:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQQqq-0003oc-NL
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 18:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbXH2Q5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 12:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbXH2Q5E
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 12:57:04 -0400
Received: from imag.imag.fr ([129.88.30.1]:39363 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbXH2Q5D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 12:57:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7TGtr6R021065
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 29 Aug 2007 18:55:53 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IQQpd-0004JP-CW; Wed, 29 Aug 2007 18:55:53 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IQQpd-0008Mj-AB; Wed, 29 Aug 2007 18:55:53 +0200
In-Reply-To: <Pine.LNX.4.64.0708291752050.28586@racer.site> (Johannes Schindelin's message of "Wed\, 29 Aug 2007 17\:52\:45 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 29 Aug 2007 18:55:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56966>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> -	linked=$(find objects -type f ! -links 1 | wc -l) &&
> -	test "$linked" = 0
> +	test $(find objects -type f ! -links 1 | wc -l) = 0

You can also use "test x -eq y" to compare integers.

I don't know which one is the most portable.

-- 
Matthieu
