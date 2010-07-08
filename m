From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [ANNOUNCE] Git 1.7.2.rc1
Date: Thu, 08 Jul 2010 10:06:12 +0200
Message-ID: <vpq4ogaxurv.fsf@bauges.imag.fr>
References: <7vhbkk3vm7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 10:17:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWmIc-0003DZ-Gg
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 10:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab0GHIRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 04:17:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:39227 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053Ab0GHIRa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 04:17:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6886DGq000451
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Jul 2010 10:06:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OWm7Y-0007ps-Sy; Thu, 08 Jul 2010 10:06:12 +0200
In-Reply-To: <7vhbkk3vm7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 30 Jun 2010 17\:15\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 08 Jul 2010 10:06:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150547>

Junio C Hamano <gitster@pobox.com> writes:

> Updates since v1.7.1

>  * "git blame" applies the textconv filter to the contents it works
>    on, when available.

I think you forgot to mention "git cat-file --textconv" (branch
cp/textconv-cat-file). How about

* "git cat-file" learnt a new --textconv action, to apply the textconv
  filter to the selected blob.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
