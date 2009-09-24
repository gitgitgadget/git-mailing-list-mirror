From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] 'git cat-file' needs a better design on its option interface
Date: Thu, 24 Sep 2009 21:21:39 +0200
Message-ID: <vpqy6o4kv24.fsf@bauges.imag.fr>
References: <3a3680030909240804w1399ed7fhd6367300544f34f@mail.gmail.com>
	<alpine.LFD.2.01.0909241021120.3303@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Li Hong <lihong.hi@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 24 21:22:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqttj-0006Pd-Ed
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 21:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbZIXTWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 15:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbZIXTWY
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 15:22:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56749 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbZIXTWY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 15:22:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8OJIRPQ009271
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 Sep 2009 21:18:30 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mqtsp-0005nB-Ir; Thu, 24 Sep 2009 21:21:39 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mqtsp-0006Pb-HT; Thu, 24 Sep 2009 21:21:39 +0200
In-Reply-To: <alpine.LFD.2.01.0909241021120.3303@localhost.localdomain> (Linus Torvalds's message of "Thu\, 24 Sep 2009 10\:23\:52 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 Sep 2009 21:18:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8OJIRPQ009271
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254424710.60885@9m2gxmNu+udcAyFAuFIgjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129055>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> 'git cat-file' is really really low-level plumbing. Humans should 
> generally never use it.

... except to understand Git better ;-). I enjoyed being able to to a
'git cat-file' on a tree or commit object when I started with Git.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
