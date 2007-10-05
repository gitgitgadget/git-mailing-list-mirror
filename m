From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Question about "git commit -a"
Date: Fri, 05 Oct 2007 12:11:35 +0200
Message-ID: <vpqy7ehj2g8.fsf@bauges.imag.fr>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
	<545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
	<fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
	<Pine.LNX.4.64.0710042209410.4174@racer.site>
	<4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
	<4705FB52.3030208@op5.se>
	<4d8e3fd30710050206h7a177472x7c92f91204b15aa4@mail.gmail.com>
	<47060BB3.3030208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 05 12:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdkAS-0001IF-2X
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 12:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbXJEKMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 06:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXJEKMO
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 06:12:14 -0400
Received: from imag.imag.fr ([129.88.30.1]:50212 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbXJEKMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 06:12:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l95ABaTp016661
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 12:11:36 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Idk9f-0008DU-3e; Fri, 05 Oct 2007 12:11:35 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Idk9f-0002C5-1F; Fri, 05 Oct 2007 12:11:35 +0200
In-Reply-To: <47060BB3.3030208@op5.se> (Andreas Ericsson's message of "Fri\, 05 Oct 2007 12\:02\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 05 Oct 2007 12:11:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60063>

Andreas Ericsson <ae@op5.se> writes:

> Yes, but it's so enormously powerful once you get a grip on it that I can't
> for the life of me imagine an scm system without it. You just can't do
> "scm commit --interactive" without it in a sane way,

darcs|hg record do a very similar job. The real difference between
darcs and others here is not "scm commit --interactive", but the fact
that you can split the work among multiple commands, the index
maintains a persistant state.

> or check which merge- conflicts you've already resolved,

At least bzr and baz have this kind of conflict management. It's just
a separate file, containing the list of unresolved conflicts.

> or compare working tree with what the next commit *will* look like,

To me, *that* is the point.

-- 
Matthieu
