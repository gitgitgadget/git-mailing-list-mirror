From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: [BUG] fatal error during merge
Date: Thu, 13 Nov 2008 23:25:19 +0100 (CET)
Message-ID: <55583.N1gUGH5fRhE=.1226615119.squirrel@webmail.hotelhot.dk>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk>
    <2008-11-13-14-23-19+trackit+sam@rfc1149.net>
    <20081113140323.GA10267@neumann>
    <2008-11-13-15-26-33+trackit+sam@rfc1149.net>
    <20081113145325.GD29274@neumann>
    <57814.N1gUGH5fRhE=.1226596012.squirrel@webmail.hotelhot.dk>
    <20081113180931.GE29274@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 23:26:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ke9-0004BA-Fq
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280AbYKMWZY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 17:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbYKMWZX
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:25:23 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:41380 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755227AbYKMWZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:25:20 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 0BF0914068;
	Thu, 13 Nov 2008 23:25:20 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id CCBCA14062;
	Thu, 13 Nov 2008 23:25:19 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: N1gUGH5fRhE=
In-Reply-To: <20081113180931.GE29274@neumann>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100922>

SZEDER G=E1bor wrote:

> Well, oddly enough, your second test case behaves somewhat differentl=
y
> than the first one, at least as far as bisect is concerned.  Bisect
> nails down the second test case to 0d5e6c97 (Ignore merged status of
> the file-level merge, 2007-04-26; put Alex on Cc).  Reverting this
> commit on master makes both of your test cases pass.

Hmm. With that one reverted, git prints out this error instead:

error: failed to create path 'after/one': perhaps a D/F conflict?

and still has the moved file disapper in the working tree. The merge is
successful, though, and the moved file is in the committed tree.


Anders.
