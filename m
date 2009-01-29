From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Force commit date
Date: Thu, 29 Jan 2009 19:55:10 +0100
Message-ID: <200901291955.10769.markus.heidelberg@web.de>
References: <1233253817209-2240539.post@n2.nabble.com> <1233254709681-2240602.post@n2.nabble.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Zabre <427@free.fr>
X-From: git-owner@vger.kernel.org Thu Jan 29 19:55:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSc3H-0007ju-4f
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 19:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbZA2SyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 13:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbZA2SyW
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 13:54:22 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:51673 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbZA2SyV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 13:54:21 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2020BF9A53AB;
	Thu, 29 Jan 2009 19:54:20 +0100 (CET)
Received: from [89.59.97.168] (helo=pluto.local)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LSc1r-0003I8-00; Thu, 29 Jan 2009 19:54:19 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1233254709681-2240602.post@n2.nabble.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX193FwDFkAUsHP87loZevPeehnAhOELnubfmVoyv
	cowbWfbkbJbgUTMiZwC8iaLmOxjBtqlnyIqBfLej0anW2b2FL2
	gRqr9rawcQVIoz5d/b3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107715>

Zabre, 29.01.2009:
> 
> I'm wondering : maybe the trick is outside git? Maybe is it possible to
> specify a "forced date" at which an action (a "git commit" in this case) is
> done.
> Some command that would wrap around the git commit command and tell the
> system "apply this, but do it as if now was 2008-08-23 06:15:34".

man git-commit-tree
-> GIT_COMMITTER_DATE

Though only in the git-commit-tree docs, it also works with git-commit.
Maybe it should be added there, too.

Markus
