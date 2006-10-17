From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 08:07:02 -0400
Message-ID: <BAYC1-PASMTP046FDC7A294B02BDB398D4AE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<200610171345.32313.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 14:07:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZniw-0006rq-La
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 14:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWJQMHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 08:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWJQMHH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 08:07:07 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:38687 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750717AbWJQMHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 08:07:04 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 05:07:04 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZmmk-0005Yn-MB; Tue, 17 Oct 2006 07:07:02 -0400
To: Jakub Narebski <jnareb@gmail.com>
Message-Id: <20061017080702.615a3b2f.seanlkml@sympatico.ca>
In-Reply-To: <200610171345.32313.jnareb@gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 12:07:04.0288 (UTC) FILETIME=[C2651600:01C6F1E4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Oct 2006 13:45:31 +0200
Jakub Narebski <jnareb@gmail.com> wrote:

> Git cannot do that remotely (with exception of git-tar-tree/git-archive 
> which has --remote option), yet. But you can get contents of a file 
> (with "git cat-file -p [<revision>:|:<stage>:]<filename>"), list 
> directory (with "git ls-tree <tree-ish>") and compare files or 
> directories (git diff family of commands) without need for working 
> directory.

Interesting, I didn't know about the --remote option.  So in fact as long
as the remote has enabled upload-tar then anyone can do a "light checkout".
However, it appears that kernel.org for instance doesn't enable this feature.

Sean
  
