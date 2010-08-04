From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git server eats all memory
Date: Wed, 04 Aug 2010 17:55:21 +0200
Message-ID: <vpqwrs6fk46.fsf@bauges.imag.fr>
References: <wesfwyupgrg.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ivan Kanis <expire-by-2010-08-09@kanis.fr>
X-From: git-owner@vger.kernel.org Wed Aug 04 17:59:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OggN3-0005Hk-PJ
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 17:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab0HDP7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 11:59:04 -0400
Received: from imag.imag.fr ([129.88.30.1]:37633 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab0HDP7B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 11:59:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o74FtMd3016158
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Aug 2010 17:55:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OggJO-00077l-4i; Wed, 04 Aug 2010 17:55:22 +0200
In-Reply-To: <wesfwyupgrg.fsf@kanis.fr> (Ivan Kanis's message of "Wed\, 04 Aug 2010 16\:57\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 04 Aug 2010 17:55:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152585>

Ivan Kanis <expire-by-2010-08-09@kanis.fr> writes:

> Hello,
>
> I am running git 1.7.0.4 on Debian stable. I have compiled git from
> source. I am cloning using ssh.The client and the server are running
> the same version. The bare repository is 4.5G with various binary files,
> I have 6G of memory on my server.

I never tried that size myself, but according to what I read on the
mailing list, that should remain within what Git could manage, maybe a
bit painfully.

The standard followup question in your case is: is the repository
fully packed on the server? If not, maybe "git gc" or "git gc
--aggressive" (expansive, but a one-time operation) could help.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
