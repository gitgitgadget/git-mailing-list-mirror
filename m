From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: integrating make and git
Date: Wed, 15 Apr 2009 17:41:09 +0200
Message-ID: <vpqbpqx6i22.fsf@bauges.imag.fr>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:15:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu7lX-0008Th-By
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 18:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbZDOQNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 12:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbZDOQNg
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 12:13:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:61170 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbZDOQNf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 12:13:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3FGAZa7027923
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 Apr 2009 18:10:35 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lu7Eb-0003uG-AA; Wed, 15 Apr 2009 17:41:09 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lu7Eb-00068f-7k; Wed, 15 Apr 2009 17:41:09 +0200
In-Reply-To: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com> (E. R.'s message of "Wed\, 15 Apr 2009 10\:19\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 15 Apr 2009 18:10:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116619>

E R <pc88mxer@gmail.com> writes:

> When checking out a
> different revision of the project you would have to perform another
> 'make clean' before 'make all' since you aren't sure of what's changed
> and the timestamps of the derived files will be more recent than the
> timestamps of the source files.

The last assumption is incorrect. git checkout will touch the files it
modifies, and won't play with timestamp precisely to save you from
having to do "make clean" each time you use git.

-- 
Matthieu
