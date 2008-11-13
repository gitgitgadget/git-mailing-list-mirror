From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: [BUG] git ls-files -m --with-tree does double output
Date: Fri, 14 Nov 2008 00:11:13 +0100 (CET)
Message-ID: <57320.N1gUGH5fRhE=.1226617873.squirrel@webmail.hotelhot.dk>
References: <37512.N1gUGH5fRhE=.1226613228.squirrel@webmail.hotelhot.dk>
    <7vod0jfe51.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 00:12:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0lMS-0004Yz-3p
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 00:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbYKMXLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 18:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbYKMXLN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 18:11:13 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:43723 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511AbYKMXLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 18:11:12 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id AC08514068;
	Fri, 14 Nov 2008 00:11:13 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id 721F614062;
	Fri, 14 Nov 2008 00:11:13 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: N1gUGH5fRhE=
In-Reply-To: <7vod0jfe51.fsf@gitster.siamese.dyndns.org>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> What's the use case of using -m together with --with-tree to begin with?

The script runs

   git ls-files -d -m -o -t --with-tree=HEAD

to get a parseable "git status"-like output. If I leave out
--with-tree=HEAD, I do not get information about staged changes.

I could use "git diff --name-status HEAD", but then there was a problem
about untracked files, I think.


Thanks,
Anders.
