From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: BUG?? INSTALL MAKEFILE
Date: Tue, 06 Jan 2009 15:56:39 +0100
Message-ID: <vpqiqosa3fc.fsf@bauges.imag.fr>
References: <49635BF8.1010700@sadau-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Sadau <lars@sadau-online.de>
X-From: git-owner@vger.kernel.org Tue Jan 06 16:06:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKDUM-00025I-Gg
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 16:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbZAFPDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 10:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbZAFPDh
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 10:03:37 -0500
Received: from imag.imag.fr ([129.88.30.1]:54954 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbZAFPDg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 10:03:36 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n06EudON024524
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 6 Jan 2009 15:56:40 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LKDMF-0002AY-Ad; Tue, 06 Jan 2009 15:56:39 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LKDMF-0004wW-8K; Tue, 06 Jan 2009 15:56:39 +0100
In-Reply-To: <49635BF8.1010700@sadau-online.de> (Lars Sadau's message of "Tue\, 06 Jan 2009 14\:26\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 06 Jan 2009 15:56:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104688>

Lars Sadau <lars@sadau-online.de> writes:

> Hallo,
>
> i'm a brand-new git user. Just one minute ago I wanted to install git in
> my home directory. The INSTALL file says type simply "make install", but
> the makefile does a global installation.

I was going to write:

  Either run ./configure --prefix=$HOME/wherever/you/want or edit the
  prefix variable in config.mak.

but then realized that prefix is set to $(HOME) by default. Are you
sure you didn't edit the Makefile or run any sort of ./configure
before "make install" ?
  
-- 
Matthieu
