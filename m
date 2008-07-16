From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Tue, 15 Jul 2008 17:57:48 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807151756550.2867@woody.linux-foundation.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 02:59:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIvMj-0001u2-DC
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 02:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086AbYGPA6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 20:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbYGPA6g
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 20:58:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43743 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753993AbYGPA6f (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2008 20:58:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6G0vnfG018605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jul 2008 17:57:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6G0vmG5030588;
	Tue, 15 Jul 2008 17:57:48 -0700
In-Reply-To: <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.409 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88620>



On Wed, 16 Jul 2008, Johannes Schindelin wrote:
> 
> Since the files generated and used during a rebase are never to be
> tracked, they should live in $GIT_DIR.  While at it, avoid the rather
> meaningless term "dotest" to "rebase", and unhide ".dotest-merge".

Ack. Please make it so. Even _I_ have now taught myself to do "git am" 
instead of using my old "dotest" alias.

		Linus
