From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Simplify packing public repositories
Date: Tue, 16 May 2006 07:47:10 -0400
Message-ID: <BAYC1-PASMTP0396DD9FA6E64F5AC63BB1AEA00@CEZ.ICE>
References: <20060516144635.010bb65f.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 13:53:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffy6m-0007EQ-8k
	for gcvg-git@gmane.org; Tue, 16 May 2006 13:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWEPLwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 07:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWEPLwp
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 07:52:45 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:35332 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750781AbWEPLwo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 07:52:44 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 16 May 2006 04:52:43 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 73847644C28;
	Tue, 16 May 2006 07:52:42 -0400 (EDT)
To: Timo Hirvonen <tihirvon@gmail.com>
Message-Id: <20060516074710.29ef67ca.seanlkml@sympatico.ca>
In-Reply-To: <20060516144635.010bb65f.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 16 May 2006 11:52:44.0116 (UTC) FILETIME=[3E13C140:01C678DF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 16 May 2006 14:46:35 +0300
Timo Hirvonen <tihirvon@gmail.com> wrote:

> Support "git repack project.git" syntax which is more intuitive than
> using the GIT_DIR environment variable.
> 

There are a few commands that would benefit from being easier to run
in a bare repository.  If this option was added to the "git" wrapper
rather than git-repack, it would work for all of them.  But maybe
git could just automatically recognize when it's in a bare repository.

Sean
