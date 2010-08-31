From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3 v4] Add global and system-wide gitattributes
Date: Wed, 01 Sep 2010 00:41:11 +0200
Message-ID: <vpqbp8i2yns.fsf@bauges.imag.fr>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
	<1283210123-19752-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Petr Onderka <gsvick@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 00:44:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqZZ2-0002o8-GD
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 00:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab0HaWoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 18:44:19 -0400
Received: from imag.imag.fr ([129.88.30.1]:35047 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754313Ab0HaWoS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 18:44:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7VMfCsH020067
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 Sep 2010 00:41:12 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OqZVv-0004Zi-Sy; Wed, 01 Sep 2010 00:41:11 +0200
In-Reply-To: <1283210123-19752-3-git-send-email-Matthieu.Moy@imag.fr> (Matthieu Moy's message of "Tue\, 31 Aug 2010 01\:15\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 01 Sep 2010 00:41:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154989>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This version doesn't touch config.c, and calls git_config with a
> trivial callback reading only the core.attributesfile variable.

I see that pu has a variant of my fix:

  17cd572 fixup! Add global and system-wide gitattributes

(is the fixup! here on purpose, or is it a failed rebase -i?)

Junio: your fixup fixes the git_config issue, but doesn't have the
test that my patch have. The difference is that your fixup moves the
global variable attributes_file in attr.c, which sounds like a good
idea. I'm resending my patch with this change for conveinience.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
