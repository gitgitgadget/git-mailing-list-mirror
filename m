From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: inconsistency with --abbrev=0
Date: Mon, 1 Jun 2009 12:36:50 +0200
Message-ID: <200906011236.51289.markus.heidelberg@web.de>
References: <200905311748.00782.markus.heidelberg@web.de> <fabb9a1e0905311046t1cd45b2cj4f889313c7781b38@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 12:36:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB4sx-0001xs-N6
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 12:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457AbZFAKgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 06:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756387AbZFAKgq
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 06:36:46 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:36619 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756306AbZFAKgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 06:36:45 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id C9EF910436E39;
	Mon,  1 Jun 2009 12:36:46 +0200 (CEST)
Received: from [89.59.96.138] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MB4sn-0003ca-00; Mon, 01 Jun 2009 12:36:45 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <fabb9a1e0905311046t1cd45b2cj4f889313c7781b38@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+/6leEQfcGZlUF22myDuv4Q0CDVx8YBoUYv/kl
	dWsHvYfQ6ZBSoB74MG4+gDg50YAC6Y1bzxk/8uYvx02qYcqsgM
	muUc1zEXJ2JOGqdvuC/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120457>

Sverre Rabbelier, 31.05.2009:
> Heya,
> 
> On Sun, May 31, 2009 at 17:48, Markus Heidelberg
> <markus.heidelberg@web.de> wrote:
> > What should --abbrev=0 behave like?
> 
> If the minimum is 4, then --abbrev=n with n < 4 should give an error
> saying that it should be >= 4, no?

This would break existing workflows. Currently --abbrev=[1-3] (and also
--abbrev=-n (negative numbers)) always display >=4 chars in all
commands. So you don't have to remind git's lower limit of 4, if you
just want to display as few chars as possible.
Only --abbrev=0 is different.

Markus
