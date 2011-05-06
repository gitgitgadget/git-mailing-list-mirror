From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Fri, 6 May 2011 10:39:37 +0200
Message-ID: <20110506083937.GA3719@camk.edu.pl>
References: <20110505191027.GA3242@camk.edu.pl>
 <7vsjss6hmf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 10:39:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIGZi-0003Su-S3
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 10:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab1EFIjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 04:39:45 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:54786 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754346Ab1EFIjo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 04:39:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 08BD75F0049;
	Fri,  6 May 2011 10:39:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gzKuQ-oFc98N; Fri,  6 May 2011 10:39:37 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 7AD6A5F0046;
	Fri,  6 May 2011 10:39:37 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 63C5880AF5; Fri,  6 May 2011 10:39:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsjss6hmf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172959>

On Thu, May 05, 2011 at 01:02:16PM -0700, Junio C Hamano wrote:
> Kacper Kornet <draenog@pld-linux.org> writes:

> > In bash and some other shells the script:

> >   x=2; unset a; echo "${a:-'$x'}"

> > prints '2'. However ksh shell prints $x. The quoting is added to
> > reproduce bash behaviour.

> What I happen to have in /usr/bin/ksh

>     $ /usr/bin/ksh --version
>       version         sh (AT&T Research) 93t+ 2009-05-01

> does not seem to have this issue.

> Whose ksh is this

It is pdksh 5.2.14 from http://www.cs.mun.ca/~michael/pdksh/

> It is broken.

You are right. It is corrected in mksh, which claims to be a successor
to pdksh. Unfortunately pdksh is used by default as /bin/sh in PLD Linux
Distribution which are use. Probably the time to think about the change
of this default.

-- 
  Kacper Kornet
