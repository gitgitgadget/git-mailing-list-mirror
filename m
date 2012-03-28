From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 21:38:42 +0200
Message-ID: <vpqk424zfb1.fsf@bauges.imag.fr>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
	<7vbongyd67.fsf@alter.siamese.dyndns.org>
	<vpqvclozr7e.fsf@bauges.imag.fr> <4F73632E.1060408@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:39:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyhy-00080Q-93
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758165Ab2C1Ti6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:38:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34882 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758027Ab2C1Ti5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:38:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2SJXorL007888
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Mar 2012 21:33:50 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SCyhf-0001hP-DV; Wed, 28 Mar 2012 21:38:43 +0200
In-Reply-To: <4F73632E.1060408@ira.uka.de> (Holger Hellmuth's message of "Wed,
	28 Mar 2012 21:14:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Mar 2012 21:33:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2SJXorL007888
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1333568035.36318@6bc5AeCzuwX6oeQU2XL+aQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194171>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> and additionally the following three options:
> b - choose the base version
> < - choose our version
> > - choose their version

What does it mean to "choose" in this context? In general, it means "put
this into the index", but if the file is in conflicted state, you have 3
different versions of the file in the index.

And you miss the most usefull (to me at least): "choose the version in
the worktree".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
