From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [FEATURE REQUEST] git clone, just clone selected branches?
Date: Wed, 10 Oct 2007 12:38:04 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710101236350.20690@woody.linux-foundation.org>
References: <011401c80b6f$1a11d1f0$04ac10ac@Jocke>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:38:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfhNs-0001qu-F2
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 21:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbXJJTiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 15:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbXJJTiN
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 15:38:13 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53933 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755186AbXJJTiM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2007 15:38:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9AJc5TR016310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Oct 2007 12:38:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9AJc4dX022413;
	Wed, 10 Oct 2007 12:38:05 -0700
In-Reply-To: <011401c80b6f$1a11d1f0$04ac10ac@Jocke>
X-Spam-Status: No, hits=-3.229 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60533>



On Wed, 10 Oct 2007, Joakim Tjernlund wrote:
> 
> I know I can use git remote to do this, but it is a bit clumsy 
> when starting a new repo.

How about just

	git init
	.. set up remote tracking info in .git/config ..
	git fetch remote

which should do what you want.

		Linus
