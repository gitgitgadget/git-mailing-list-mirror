From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Sat, 13 Jun 2009 13:02:42 +0200
Message-ID: <200906131302.43091.markus.heidelberg@web.de>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de> <e5bfff550906130013j3a9802cen48ac5828a2357bf1@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 13:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFR0a-0001jD-Lx
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 13:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021AbZFMLCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 07:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbZFMLCj
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 07:02:39 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:54888 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760957AbZFMLCi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 07:02:38 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id AD91110330365;
	Sat, 13 Jun 2009 13:02:40 +0200 (CEST)
Received: from [89.59.112.3] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MFR0S-0007qe-00; Sat, 13 Jun 2009 13:02:40 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <e5bfff550906130013j3a9802cen48ac5828a2357bf1@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19W7vFv/1S3wm142ZXry9SoCB3Y442qXBmKZxUW
	6YzQOw1k2ZWDkfO8bjX8RM8rT+kEu7z8fRzZsvqfgnQFUvyXYv
	A8uPPCoEoG1FPnPlbAlw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121491>

Marco Costalba, 13.06.2009:
> On Sat, Jun 13, 2009 at 00:29, Markus
> Heidelberg<markus.heidelberg@web.de> wrote:
> > Creating a patch series didn't work, because the SHA1 list was
> > interpreted in the wrong order.
> >
> > Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> > ---
> 
> I think they are generated in apply order as should be.
> 
> As example, from git repo we have the following revisions:
> 
> GIT 1.6.3
> t4029: use sh instead of bash
> t4200: convert sed expression which operates on non-text file to perl
> t4200: remove two unnecessary lines
> 
> Now if I select the 4 revisions and use "Save patch..." I have
> 
> 0001-t4200-remove-two-unnecessary-lines.patch
> 0002-t4200-convert-sed-expression-which-operates-on-non.patch
> 0003-t4029-use-sh-instead-of-bash.patch
> 0004-GIT-1.6.3.patch

In my git repository with some local branches I get this:

0001-t4200-convert-sed-expression-which-operates-on-non-t.patch
0002-t4029-use-sh-instead-of-bash.patch

In a plain newly created git repo with this command:

git clone --reference git git://git.kernel.org/pub/scm/git/git.git git-orig

I don't get any patches. I haven't tried it explicitely now, but I guess
my patch would solve this for me.

OK, if I now disable "All branches" in "View->Select range...", I get
the 2 patches from above again.
But in my git repo with local branches, it's the other way round...

Markus
