From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Tue, 06 Apr 2010 17:01:04 +0200
Message-ID: <vpqljd062xb.fsf@bauges.imag.fr>
References: <loom.20100406T161552-321@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vitaly Berov <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 17:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzAKf-0006EU-UC
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 17:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab0DFPEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 11:04:42 -0400
Received: from imag.imag.fr ([129.88.30.1]:55948 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab0DFPEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 11:04:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o36F15aY021787
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 6 Apr 2010 17:01:05 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NzAH2-00059k-R9; Tue, 06 Apr 2010 17:01:04 +0200
In-Reply-To: <loom.20100406T161552-321@post.gmane.org> (Vitaly Berov's message of "Tue\, 6 Apr 2010 14\:18\:53 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 06 Apr 2010 17:01:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144145>

Vitaly Berov <vitaly.berov@gmail.com> writes:

> We have quite a large repository and "git clone" takes about 6 hours. Herewith 
> "resolving deltas" takes most of the time.
> What git does at this stage and how can we optimize it?

Does running "git gc" (long, but done once and for all) on the server
help?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
