From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Tue, 15 Jul 2008 18:52:06 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807151851090.2835@woody.linux-foundation.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <7v4p6qzla3.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807160315020.2841@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 03:53:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIwDK-0005Gy-H8
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 03:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbYGPBw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 21:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbYGPBw4
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 21:52:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35936 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751067AbYGPBwz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2008 21:52:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6G1q7eq021376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jul 2008 18:52:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6G1q6PF032677;
	Tue, 15 Jul 2008 18:52:06 -0700
In-Reply-To: <alpine.DEB.1.00.0807160315020.2841@eeepc-johanness>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.409 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88629>



On Wed, 16 Jul 2008, Johannes Schindelin wrote:
> 
> Of course, you can name it as you want.  But I thought that the name 
> "rebase" applies as well: the patches are rebased from somewhere else on 
> top of HEAD :-)

Well, the original thing was not rebasing, it was patch application. You 
could _perhaps_ call that "rebasing" from another tree, but that's a 
stretch.

But I don't really care about the name. _Anything_ is better then 
".dotest", after all.

		Linus
