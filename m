From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: `./configure --XXdir=` ignored?
Date: Thu, 26 Feb 2009 18:33:48 +0100
Message-ID: <vpq4oyht85f.fsf@bauges.imag.fr>
References: <c115fd3c0902260648g3cc9bfeap58823e53a9dc72e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 19:12:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LckiD-00065P-Ee
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 19:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbZBZSKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 13:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbZBZSK3
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 13:10:29 -0500
Received: from imag.imag.fr ([129.88.30.1]:44338 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbZBZSK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 13:10:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n1QI4iCG024071
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Feb 2009 19:04:44 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lck7I-0002AE-Tf; Thu, 26 Feb 2009 18:33:48 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lck7I-0000fs-RH; Thu, 26 Feb 2009 18:33:48 +0100
In-Reply-To: <c115fd3c0902260648g3cc9bfeap58823e53a9dc72e6@mail.gmail.com> (Tim Visher's message of "Thu\, 26 Feb 2009 09\:48\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.90 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 26 Feb 2009 19:04:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Visher <tim.visher@gmail.com> writes:

> Hello Everyone,
>
> I'm working on getting git 1.6.2-rc2 built.  I have a bin, man, info,
> and html directory in my home folder that I'd like to use as the
> defaults for git.  I attempted to do this through
>
>     make configure
>     ./configure --XXdir=/full/path/to/dir

Did you actually type --XXdir, or is this XX just a way to mean
something else? I don't see --XXdir mentionned anywhere.

I use "./configure --prefix=$HOME/some/dir" and it works fine (make
install-html installs to $prefix/share/doc/).

-- 
Matthieu
