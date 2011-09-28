From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email.perl: expand filename of aliasesfile
Date: Wed, 28 Sep 2011 16:47:37 +0200
Message-ID: <vpqty7wk9km.fsf@bauges.imag.fr>
References: <20110928131307.GB12586@laptop> <vpqwrcspyvq.fsf@bauges.imag.fr>
	<20110928144057.GC12586@laptop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 16:48:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8vQX-0000ME-0G
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425Ab1I1Or4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:47:56 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60718 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754180Ab1I1Orz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:47:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8SEjPS3010657
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Sep 2011 16:45:25 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R8vQA-0002Y3-7G; Wed, 28 Sep 2011 16:47:38 +0200
In-Reply-To: <20110928144057.GC12586@laptop> (Cord Seele's message of "Wed, 28
	Sep 2011 16:40:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Sep 2011 16:45:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8SEjPS3010657
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1317825926.07355@nMYdBtPSD2x4R4X7ei5Q1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182329>

Cord Seele <cowose@googlemail.com> writes:

> On Wed 28 Sep 2011 15:42:01 +0200, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> That'd be cleaner to use
>> 
>> git config --path sendemail.aliasesfile
>> 
>> to let Git do the right expansion, in a way consistant with other places
>> of Git.
>
> This means to expand it at 'git config' time?

Yes, but not the "git config" ran to set the value. The one ran
internally by "git send-email" through Git::config(). You may add --get
to my command line above.

> Wouldn't it be nicer to have it expanded when you run 'git
> send-email'? Then you could move your ~/.gitconfig (that's where I
> have my aliasesfile configured) between different accounts and it
> could still work.

That works with my proposal.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
