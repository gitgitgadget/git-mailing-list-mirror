From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: [BUG] fatal error during merge
Date: Mon, 11 May 2009 09:37:03 +0200 (CEST)
Message-ID: <41870.bFoQE3daRhY=.1242027423.squirrel@webmail.hotelhot.dk>
References: <20090510163336.GA27241@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, "Samuel Tardieu" <sam@rfc1149.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 09:37:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Q4a-0000Mo-By
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 09:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbZEKHhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 03:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbZEKHhE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 03:37:04 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:57813 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbZEKHhD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 03:37:03 -0400
Received: from webmail.hotelhot.dk (web.hotelhot.dk [192.168.0.170])
	by mail.hotelhot.dk (Postfix) with ESMTP id 1A26344FD;
	Mon, 11 May 2009 09:37:03 +0200 (CEST)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: bFoQE3daRhY=
In-Reply-To: <20090510163336.GA27241@blimp.localdomain>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118780>

On Sun, 10 May 2009 18:33:36 +0200, Alex Riesen <raa.lkml@gmail.com> wrote:

> I still have the patch below (rebased) in my tree.
> Was the problem fixed somehow differently?

> Subject: [PATCH] Update index after refusing to rewrite files unchanged
> during merge

I tested recently, and it does not appear to be fixed yet.

However, your patch was not enough to fix my test case completely,
so I am unsure whether it makes sense to apply it as a partial fix.

The test is here:

   http://article.gmane.org/gmane.comp.version-control.git/116999


Anders.
