From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: [ANNOUNCE] GIT 1.6.1-rc3
Date: Mon, 15 Dec 2008 11:04:20 +0100 (CET)
Message-ID: <34543.bFoQE3daRhY=.1229335460.squirrel@webmail.hotelhot.dk>
References: <7vbpvnbcoa.fsf@gitster.siamese.dyndns.org>
    <7voczdyh23.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>, raa.lkml@gmail.com
X-From: git-owner@vger.kernel.org Mon Dec 15 11:04:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCAJg-0005vV-Fq
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 11:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbYLOKD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 05:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752598AbYLOKD0
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 05:03:26 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:44595 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316AbYLOKDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 05:03:25 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 2DAFB30A84;
	Mon, 15 Dec 2008 11:04:20 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id 03FD53049D;
	Mon, 15 Dec 2008 11:04:20 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: bFoQE3daRhY=
In-Reply-To: <7voczdyh23.fsf@gitster.siamese.dyndns.org>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103147>

Junio C Hamano wrote:

> I have fixed a few more smallish (old) bugs after I tagged this, which
> will be in 'master' shortly, but it seems that this cycle is stabilizing
> fairly nicely.  Let's have a successful 1.6.1 tagged on 20th.  Please hunt
> and fix bugs until then.

Even though it is not a 1.6.1 regression, I wonder about the merge
conflict issue in

 http://thread.gmane.org/gmane.comp.version-control.git/100859/focus=101182


The patch in that post improved things somewhat, by making a correct
commit. Of course, the working tree then silently loses a file, which
could be seen as being worse than a fatal failure.


Anders.
