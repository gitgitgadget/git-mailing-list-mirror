From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: when git-rebase -i fails to cherry-pick
Date: Tue, 24 Jul 2007 00:54:02 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070723225402.GB22513@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:54:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID6n8-0003w1-37
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 00:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbXGWWyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Jul 2007 18:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbXGWWyK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 18:54:10 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:57037 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752365AbXGWWyI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 18:54:08 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1ID6n0-0002ix-Ft; Tue, 24 Jul 2007 00:54:06 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l6NMs2Fl023670;
	Tue, 24 Jul 2007 00:54:03 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l6NMs26H023669;
	Tue, 24 Jul 2007 00:54:02 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53498>

Hello,

even though git-rebase -i is still young, I'm already a big fan of it.

I just want to suggest two minor things:

- If a cherry-pick fails, it tells me to resolve my conflicts, 'git add
  <paths>' and to do 'git commit -c $sha1id'.

  But it doesn't tell me, how I continue to rebase after that.

  'git rebase -i --continue' works.

- If a cherry-pick of a commit to be squashed fails, the instruction to
  do 'git commit -c $sha1id' is wrong, because then I don't get both
  message to squash.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D12+mol+in+dozen
