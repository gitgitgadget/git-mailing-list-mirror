From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: wierd git show syntax
Date: Thu, 30 Sep 2010 13:32:31 +0200
Message-ID: <vpqtyl7fovk.fsf@bauges.imag.fr>
References: <AANLkTi=Zz-1dSC0imJ3NZXWcdvhXWXt-Kk94zwKe8+6Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 30 13:36:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1HR4-0007e3-Gg
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 13:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab0I3Lfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 07:35:54 -0400
Received: from imag.imag.fr ([129.88.30.1]:64369 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab0I3Lfx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 07:35:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8UBWWxV000776
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 30 Sep 2010 13:32:32 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P1HNI-0008A4-0K; Thu, 30 Sep 2010 13:32:32 +0200
In-Reply-To: <AANLkTi=Zz-1dSC0imJ3NZXWcdvhXWXt-Kk94zwKe8+6Y@mail.gmail.com> (Geoff Russell's message of "Thu\, 30 Sep 2010 14\:32\:48 +0930")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 30 Sep 2010 13:32:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157641>

Geoff Russell <geoffrey.russell@gmail.com> writes:

> Hi,
>
> $ git show XXXX:data/path/object.c
>
> Gives me what I want, a cat of the objects contents. However
> for some files I get a message about ambiguous argument telling me to
> separate paths from revisions with '--'.

This happens if data/path/object.c doesn't exist in XXXX.

A common mistake is to write XXXX:relative/path when Git expects a
path relative to the tree root. Git >= 1.7 would give you a more
friendly error message in this case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
