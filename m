From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 3 Jun 2008 07:40:21 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806030738340.3473@woody.linux-foundation.org>
References: <200806030314.03252.jnareb@gmail.com> <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org> <7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 16:43:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3XjM-0001WC-Qz
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 16:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbYFCOm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 10:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754261AbYFCOm2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 10:42:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35521 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753077AbYFCOm1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 10:42:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m53EeMPH017044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jun 2008 07:40:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m53EeL74004954;
	Tue, 3 Jun 2008 07:40:22 -0700
In-Reply-To: <7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.39 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83668>



On Mon, 2 Jun 2008, Junio C Hamano wrote:

> "Merge branches 'RELEASE' and 'fluff' into RELEASE"?  That happens if you
> are _on_ release branch and say "git merge release fluff".

Right. But git shouldn't do duplicate parents. I agree it's a mis-use of 
git merge, but either we should have errored out or we should have pruned 
the parents.

Yes, the end result is "tecnically correct", but it's not optimal.

		Linus
