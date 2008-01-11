From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Update and fix Makefile
Date: Sat, 12 Jan 2008 10:36:46 +1100
Message-ID: <18311.64910.643392.816623@cargo.ozlabs.ibm.com>
References: <200801082154.21282.stimming@tuhh.de>
	<7vk5mkq669.fsf@gitster.siamese.dyndns.org>
	<18308.17099.334609.80415@cargo.ozlabs.ibm.com>
	<7vk5mg3fjf.fsf@gitster.siamese.dyndns.org>
	<7vfxx43f5r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 00:37:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDTRD-0007ks-Oa
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 00:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762188AbYAKXgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 18:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761727AbYAKXgz
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 18:36:55 -0500
Received: from ozlabs.org ([203.10.76.45]:57213 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757682AbYAKXgy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 18:36:54 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 45F29DE09F; Sat, 12 Jan 2008 10:36:53 +1100 (EST)
In-Reply-To: <7vfxx43f5r.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70223>

Junio C Hamano writes:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I applied three patches since last pull from you and pushed the
> > result (pure gitk part) out in gitk branch:
> >
> > 	master.kernel.org:/pub/scm/git/git.git/ gitk
> >
> > Could you please pull?

I get:

~/gitk$ git pull master.kernel.org:/pub/scm/git/git.git/ gitk
error: no such remote ref refs/heads/gitk
fatal: Fetch failure: master.kernel.org:/pub/scm/git/git.git/

> Sorry, this was a very ill-behaved pull request.  The patches
> picked up from the list I applied are these three:
> 
> Charles Bailey (1):
>       gitk: Fix the Makefile to cope with systems lacking msgfmt
> 
> Christian Stimming (2):
>       gitk: Fix typo in user message.

I was going to ignore this one since "descendent" is actually a valid
alternate spelling, and is the one I am used to.  However, I don't
have a strong feeling about it.

Paul.
