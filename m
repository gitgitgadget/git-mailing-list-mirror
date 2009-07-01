From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Does CVS has a easy way to compare file with its previous
 version?
Date: Tue, 30 Jun 2009 18:18:29 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906301813480.3605@localhost.localdomain>
References: <1e56aa11-735a-47f7-a273-5b6bf611f528@n11g2000yqb.googlegroups.com> <m3hbxxx5jk.fsf@localhost.localdomain> <4A4A9FA5.7000009@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, dtletmn <dtletmedn@gmail.com>,
	git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 01 03:21:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLoW8-0007AW-Av
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 03:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbZGABTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 21:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbZGABTY
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 21:19:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56074 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932455AbZGABTW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 21:19:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n611IU55021969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2009 18:18:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n611ITjs014948;
	Tue, 30 Jun 2009 18:18:30 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A4A9FA5.7000009@gnu.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.468 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122559>



On Wed, 1 Jul 2009, Paolo Bonzini wrote:
> 
> I think he wants something more like
> 
> git diff `git log -2 --pretty=format:%h` <file> -- <file>

That's a rather difficult way of saying

	git log --no-merges -p -1 <filename>

which seems much simpler. Sure, you'll get the commit message too, but 
that just sounds like gravy to me (you can use "--pretty=oneline" or 
something to make it denser).

			Linus
