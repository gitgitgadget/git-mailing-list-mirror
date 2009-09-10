From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/4] reset: add option "--merge-dirty" to "git reset"
Date: Thu, 10 Sep 2009 16:24:48 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909101617280.3654@localhost.localdomain>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.37592.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 01:25:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlt0n-0003Na-1Q
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 01:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbZIJXY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 19:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbZIJXY7
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 19:24:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53933 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242AbZIJXY6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 19:24:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8ANOnWk011802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Sep 2009 16:24:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8ANOmrb024494;
	Thu, 10 Sep 2009 16:24:49 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090910202333.3722.37592.chriscool@tuxfamily.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.958 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128159>



On Thu, 10 Sep 2009, Christian Couder wrote:
> 
> In fact with "--merge-dirty", changes that are both in
> the work tree and the index are kept in the work tree
> after the reset (but discarded in the index). As with
> "--merge", changes that are in both the work tree and
> the index are discarded after the reset.

Can you explain that again? That paragraph makes no sense, because it 
boils down to saying two different thing for "changes that are in both the 
work tree and the index". First it says such changes are kept in the work 
tree (but discarded in the index), and then it says that the changes are 
discarded.

Which seems very odd.

Or are my reading comprehension skills lacking?

The patch also seems to imply that it's always about HEAD. True?

		Linus
