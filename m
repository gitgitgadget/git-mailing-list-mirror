From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: [BUG] fatal error during merge
Date: Fri, 14 Nov 2008 10:16:04 +0100 (CET)
Message-ID: <38773.bFoQE3daRhY=.1226654164.squirrel@webmail.hotelhot.dk>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk>
    <2008-11-13-14-23-19+trackit+sam@rfc1149.net>
    <20081113140323.GA10267@neumann>
    <2008-11-13-15-26-33+trackit+sam@rfc1149.net>
    <20081113145325.GD29274@neumann>
    <57814.N1gUGH5fRhE=.1226596012.squirrel@webmail.hotelhot.dk>
    <20081113180931.GE29274@neumann>
    <20081113230932.GA8552@blimp.localdomain>
    <48332.N1gUGH5fRhE=.1226619243.squirrel@webmail.hotelhot.dk>
    <7vfxlvf8up.fsf@gitster.siamese.dyndns.org>
    <20081114071636.GA4013@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <gitster@pobox.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	"Samuel Tardieu" <sam@rfc1149.net>, git@vger.kernel.org,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 10:17:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0uns-0001vW-FO
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 10:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbYKNJQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 04:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbYKNJQJ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 04:16:09 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:40448 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbYKNJQH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 04:16:07 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 7F9C314068;
	Fri, 14 Nov 2008 10:16:04 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id 442F314062;
	Fri, 14 Nov 2008 10:16:04 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: bFoQE3daRhY=
In-Reply-To: <20081114071636.GA4013@blimp.localdomain>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100960>

Alex Riesen wrote:

> And the patch isn't enough: the file Anders noticed missing is in the
> index (correctly) but somehow removed from worktree.  Which is maybe
> because it _still_ was a rename: 99% similarity. Well, just
> "yes | tail -nNN" usually producess very similar data :)

Maybe reducing the example all the way down to "touch" lost the implicit
information that, indeed, it has to be a rename for this to fail.


Anders.
