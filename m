From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Funny error with git gc...
Date: Mon, 18 May 2009 10:28:06 +0200
Message-ID: <op.ut39s4cf1e62zd@merlin.emma.line.org>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302>
 <7vmy9etey8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0905151128230.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 10:28:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5yCt-0003oU-HX
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 10:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbZERI2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 04:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbZERI2M
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 04:28:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:45330 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751140AbZERI2J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 04:28:09 -0400
Received: (qmail invoked by alias); 18 May 2009 08:28:10 -0000
Received: from unknown (EHLO mandree.no-ip.org) [85.183.215.232]
  by mail.gmx.net (mp043) with SMTP; 18 May 2009 10:28:10 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX19y8lBfQR5yTunhXFaveRglOeSAlAxyGCf7WOZWKS
	EupZBLSNKcuPfM
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 623F394365;
	Mon, 18 May 2009 10:28:07 +0200 (CEST)
In-Reply-To: <alpine.LFD.2.01.0905151128230.3343@localhost.localdomain>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119426>

Am 15.05.2009, 20:46 Uhr, schrieb Linus Torvalds  
<torvalds@linux-foundation.org>:

> I also think you _should_ be able to avoid this by just limiting the pack
> size usage. IOW, with some packed_git_limit, something like
>
> 	[core]
> 		packedGitWindowSize = 16k
> 		packedGitLimit = 1M

Does the latter do the equivalent of "--max-pack-size"?

If it does, then there is a related issue on the output side - and that  
is, that I get humongous amounts of packs with that option. Say, I'm  
repacking my leafnode repos, then
with --max-pack-size=1, I get eight packs of 1 MB (8 MB),
  and --max-pack-size=4  yields one pack of 2 - 3 MB size...

-- 
Matthias Andree
