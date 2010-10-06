From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: textconv not used for diff
Date: Wed, 06 Oct 2010 22:40:12 +0200
Message-ID: <vpqr5g3f42b.fsf@bauges.imag.fr>
References: <AANLkTi=Y2U1DqnW4oA7_MD3gZMXYzFCFYHwKuuonsmA0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 22:40:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3aml-00028h-7u
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 22:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab0JFUkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 16:40:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52090 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab0JFUkT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 16:40:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o96KQXe6019515
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Oct 2010 22:26:33 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P3ama-00082K-Oa; Wed, 06 Oct 2010 22:40:12 +0200
In-Reply-To: <AANLkTi=Y2U1DqnW4oA7_MD3gZMXYzFCFYHwKuuonsmA0@mail.gmail.com> (Victor Engmark's message of "Wed\, 6 Oct 2010 22\:36\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Oct 2010 22:26:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o96KQXe6019515
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1287001597.84252@BL7d+0UvOWGTL8ayx0aoQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158307>

Victor Engmark <victor.engmark@gmail.com> writes:

> Hello,
>
> After trying for a couple hours to get textconv to work according to
> <https://git.wiki.kernel.org/index.php/Textconv> and other pages, I've
> given up. I've tried changing .odt, .ott and .ods files, but git-diff
> never outputs the text diff:
>
> $ git --version
> git version 1.7.0.4
> $ cat ~/.gitattributes

.gitattributes file should be in the working tree, not in your $HOME.

The development version of Git has a core.attributesfile variable that
would allow you to have a user-wide ~/.gitattributes, but this isn't
released yet.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
