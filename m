From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Tue, 10 Sep 2013 11:19:22 +0200
Message-ID: <vpq4n9tghk5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 11:19:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJK6h-0003qi-AI
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 11:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab3IJJTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 05:19:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59239 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab3IJJTa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 05:19:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8A9JMjp010482
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Sep 2013 11:19:22 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VJK6V-0001Vh-4k; Tue, 10 Sep 2013 11:19:23 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 10 Sep 2013 11:19:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8A9JMjp010482
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379409562.40654@UvSPVHETe8PmljPkxe8UoA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234427>

Hi,

I just noticed that the template COMMIT_EDITMSG was containing status
hints, and that they were not particularty helpfull _during_ a commit. I
think it would be sensible to ignore advice.statusHints and disable
hints unconditionally when writting to COMMIT_EDITMSG.

Any objection?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
