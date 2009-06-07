From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 2/2] send-email: fix threaded mails without chain-reply-to
Date: Sun, 7 Jun 2009 18:59:02 +0200
Message-ID: <200906071859.02871.markus.heidelberg@web.de>
References: <200906061414.27371.markus.heidelberg@web.de> <1244388019-12763-1-git-send-email-markus.heidelberg@web.de> <1244388019-12763-2-git-send-email-markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 18:59:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDLiD-0002bo-Iw
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 18:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723AbZFGQ7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 12:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbZFGQ7E
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 12:59:04 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:49294 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbZFGQ7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 12:59:02 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id F1385102143E8;
	Sun,  7 Jun 2009 18:59:03 +0200 (CEST)
Received: from [89.59.87.118] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDLi3-0008Kx-00; Sun, 07 Jun 2009 18:59:03 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1244388019-12763-2-git-send-email-markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/EqKY2mCD31mr69REbUovmLzgsAobxXggIB0wM
	2hheU4GT1rct23T/NpC1cxMP5q3Qih/ByzLjQCELWWFyYaw50b
	W12Q6x1crsimJYZhQbGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120986>

Markus Heidelberg, 07.06.2009:
> These commands didn't send threaded mails anymore:
> 
>     $ git format-patch <revision range>
>     $ git send-email --thread --no-chain-reply-to <files>

I also just noticed a warning without this patch, can't remember if I
have seen it before...

Use of uninitialized value in length at
/home/markus/git/install/libexec/git-core/git-send-email line 1146.
