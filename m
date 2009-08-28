From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Fri, 28 Aug 2009 10:46:06 +0200
Message-ID: <vpq7hwo8gxd.fsf@bauges.imag.fr>
References: <20090827203402.GC7168@kisimul> <vpqk50pasek.fsf@bauges.imag.fr>
	<4A979690.1050601@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: seanh <seanh.nospam@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 10:46:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgx6F-0004KL-SW
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 10:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbZH1IqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 04:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbZH1IqQ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 04:46:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37282 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbZH1IqP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 04:46:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7S8gsmN031478
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 28 Aug 2009 10:42:54 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mgx5y-0003HF-7R; Fri, 28 Aug 2009 10:46:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mgx5y-0002pU-53; Fri, 28 Aug 2009 10:46:06 +0200
In-Reply-To: <4A979690.1050601@gnu.org> (Paolo Bonzini's message of "Fri\, 28 Aug 2009 10\:34\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 28 Aug 2009 10:42:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7S8gsmN031478
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252053775.48463@k+RKocPVO0AMreUZliPsKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127280>

Paolo Bonzini <bonzini@gnu.org> writes:

> You can also merge from the master to your working branch after every
> merge --squash.

Yes, good point. I didn't think of this, but it works because ...

>    ... work on local ...
>    git commit
>    ... work on local ...
>    git commit
>
>    git checkout master
>    git merge --squash local; git commit -m'day 1'

... this should fast-forward, so get the same tree as in branch
'local' and ...

>    git checkout local
>    git merge master

... then this is a merge of two identical trees, so it's trivial.

-- 
Matthieu
