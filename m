From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Sat, 12 Jan 2008 22:29:03 +0300
Message-ID: <20080112192903.GJ2963@dpotapov.dyndns.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <alpine.LSU.1.00.0801112127040.31053@racer.site> <34F43A68-6041-42BE-85BD-3EF971875C0F@sb.org> <alpine.LFD.1.00.0801111356000.3148@woody.linux-foundation.org> <20080112144629.GE2963@dpotapov.dyndns.org> <alpine.LFD.1.00.0801121040010.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 20:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDm2z-0004fW-JP
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 20:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbYALT3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 14:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbYALT3I
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 14:29:08 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:57911 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023AbYALT3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 14:29:07 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 4E7471870260;
	Sat, 12 Jan 2008 22:29:04 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id E25B41870277;
	Sat, 12 Jan 2008 22:29:03 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JDm2R-0000Yk-SF; Sat, 12 Jan 2008 22:29:03 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801121040010.2806@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70353>

On Sat, Jan 12, 2008 at 10:47:10AM -0800, Linus Torvalds wrote:
> 
> And that isn't going to change. It's the only sane way to do 
> locale-independent names: people can *choose* to see the filenames as some 
> UTF-8 sequence, or a series of Latin1, or anything, but that's not 
> something git itself will care about.

Unfortunately, to agree on a single encoding for different systems is
even more difficult than agreeing on a single end-of-line encoding.
OTOH, it is not a real issue as long as anyone use ASCII names only.

> 
> Trying to involve locale in name comparison simply isn't possible.

Agreed. However, the proper solution would be that all filenames are
stored in UTF-8, so conversation is done when a file is added to the
index. But that requires a lot of work, and as I said before, I doubt
that many people really want to store files with non-ASCII names, after
all, Git is a developer tool. So, as far as I am concern, it does not
worth efforts.

Dmitry
