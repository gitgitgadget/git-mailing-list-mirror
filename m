From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 11:13:06 +0200
Message-ID: <vpqejmjjrdp.fsf@bauges.imag.fr>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 11:13:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdjkV-00032v-M4
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 11:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbXDQJNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 05:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbXDQJNQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 05:13:16 -0400
Received: from imag.imag.fr ([129.88.30.1]:52508 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbXDQJNP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 05:13:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l3H9D6oN021467
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Apr 2007 11:13:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HdjkI-0005l0-5K; Tue, 17 Apr 2007 11:13:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HdjkI-0004J0-35; Tue, 17 Apr 2007 11:13:06 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> (Pietro Mascagni's message of "Tue\, 17 Apr 2007 10\:02\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 17 Apr 2007 11:13:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44744>

"Pietro Mascagni" <pietromas@gmail.com> writes:

> So, in 15 seconds, how does one argue that GIT is vastly superior to
> other version control software, especially CVS.

Vs CVS, in 15 seconds, I'd say:

* Atomic commits. CVS makes it hard to get back to a consistant state
  in the past. What does it mean, for example to checkout revision 1.5
  of a project in CVS (hint: nothing, it's meaningfull for a file
  only).

* Rename management.

* Performance.

* Perhaps your boss will be interested in the "data integrity" (i.e.
  git fsck) problem too.

You have also the joker argument "Linus Torvalds is very intelligent,
and he gave up with CVS looong ago", but it might or might not work.

If you have to argue against SVN, you'll need more than 15
seconds ;-).

-- 
Matthieu
