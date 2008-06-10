From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 13:23:56 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>  <m3abhtp42o.fsf@localhost.localdomain>  <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>  <200806102159.02875.jnareb@gmail.com>
 <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:25:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6APW-0008O5-Uw
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 22:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbYFJUYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 16:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755326AbYFJUYb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 16:24:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36977 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751541AbYFJUYa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 16:24:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AKNvba009920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 13:23:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AKNukR027581;
	Tue, 10 Jun 2008 13:23:57 -0700
In-Reply-To: <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.382 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84544>



On Tue, 10 Jun 2008, Denis Bueno wrote:
>
> You're onto something:
> 
> [dorothy.local /tmp <Tue Jun 10> <16:02:08>]
> tmp[176] > git clone file:///Volumes/work/identity.fb/

[ successful ]

Hmm. Scary. That should *not* have been successful with a corrupt repo.

Unless you have done a .grafts file to hide the corruption, or something 
like that?

Have you saved away the original corrupt repo (the whole .git directory as 
a tar-ball, for example)? And is the data public and non-embarrassing 
enough so that you could make it available for some post-corruption 
analysis? Even if we cannot help recover it, real-life corruption is 
always interesting to see if only as a test-case to make sure that git 
notices it as quickly as possible.

			Linus
