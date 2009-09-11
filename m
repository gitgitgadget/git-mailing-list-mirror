From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: one half of a rebase
Date: Fri, 11 Sep 2009 20:39:16 +0200
Message-ID: <vpqvdjpgwbv.fsf@bauges.imag.fr>
References: <7f9d599f0909111025q42e3cdc6vba602b84c1d81215@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dylan Simon <dylan@dylex.net>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Fri Sep 11 20:42:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmB4N-0004pv-QV
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 20:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858AbZIKSlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 14:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755856AbZIKSlv
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 14:41:51 -0400
Received: from imag.imag.fr ([129.88.30.1]:60212 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755788AbZIKSlv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 14:41:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n8BIdGbN024812
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 11 Sep 2009 20:39:16 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MmB1g-0007Ak-6V; Fri, 11 Sep 2009 20:39:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MmB1g-00048O-58; Fri, 11 Sep 2009 20:39:16 +0200
In-Reply-To: <7f9d599f0909111025q42e3cdc6vba602b84c1d81215@mail.gmail.com> (Geoffrey Irving's message of "Fri\, 11 Sep 2009 13\:25\:59 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 11 Sep 2009 20:39:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128210>

Geoffrey Irving <irving@naml.us> writes:

> If I could do (2) as a separate operation, it would look something like
>
>     git cherry-pick-all topic

I believe

  git rebase --onto master master topic
  git update-ref master topic

would do the trick.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
