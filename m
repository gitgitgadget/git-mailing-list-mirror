From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Status of all files (was: Re: How can I tell if a file is ignored by git?
Date: Fri, 09 Apr 2010 16:23:11 +0200
Message-ID: <vpqy6gw7lio.fsf@bauges.imag.fr>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
	<j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
	<20100409113248.GB27353@thyrsus.com>
	<m3sk74hjkg.fsf@localhost.localdomain>
	<20100409140215.GB27899@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Apr 09 16:23:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0F7J-0002sE-9d
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 16:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055Ab0DIOXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 10:23:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45025 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab0DIOXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 10:23:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o39EIWVo022378
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Apr 2010 16:18:32 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O0F71-0000h7-Lz; Fri, 09 Apr 2010 16:23:11 +0200
In-Reply-To: <20100409140215.GB27899@thyrsus.com> (Eric Raymond's message of "Fri\, 9 Apr 2010 10\:02\:15 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 09 Apr 2010 16:18:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o39EIWVo022378
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1271427513.69157@0NL9Qqg8CXMHNJtRvXACjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144434>

Eric Raymond <esr@thyrsus.com> writes:

> (The ls-files -t codes need better documentation.  If I get detailed enough
> answers, I will write some.)

http://thread.gmane.org/gmane.comp.version-control.git/126516

In short, "git ls-files -t" was written long ago, never tested, and
probably mostly used by no one. It has a very strange behavior, it's
not just the doc. I'd advise against using it.

"git status --porcelain" is probably what you want:

       --porcelain
           Give the output in a stable, easy-to-parse format for
           scripts. Currently this is identical to --short output, but
           is guaranteed not to change in the future, making it safe
           for scripts.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
