From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 2/2] Improve doc for format-patch threading options.
Date: Wed, 22 Jul 2009 22:57:14 +0200
Message-ID: <20090722205713.GA7901@nan92-1-81-57-214-146.fbx.proxad.net>
References: <cover.1246834883.git.ydirson@altern.org> <200907170058.46962.markus.heidelberg@web.de> <20090717065236.GE5762@nan92-1-81-57-214-146.fbx.proxad.net> <200907180123.41735.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 22 22:57:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTisO-0008I6-Hp
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 22:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbZGVU5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 16:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbZGVU5O
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 16:57:14 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:36903 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbZGVU5N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 16:57:13 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 419DC94011C;
	Wed, 22 Jul 2009 22:57:03 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5FADE940147;
	Wed, 22 Jul 2009 22:57:01 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 695ABA003; Wed, 22 Jul 2009 22:57:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907180123.41735.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123774>

On Sat, Jul 18, 2009 at 01:23:41AM +0200, Markus Heidelberg wrote:
> Yann Dirson, 17.07.2009:
> > On Fri, Jul 17, 2009 at 12:58:46AM +0200, Markus Heidelberg wrote:
> > > > - even when --no-thread is specified, and format-patch was run with
> > > > --no-thread as well, it still adds In-Reply-To and References headers,
> > > > and I must say I do not see what in the code causes this behaviour.
> > > 
> > > This is caused by a bug fixed in commit 5e9758e29 (send-email: fix
> > > non-threaded mails, 2009-06-12). Try using "git send-email --no-thread
> > > --no-chain-reply" and it may work again. You should use an up-to-date
> > > git, when searching for bugs.
> > 
> > I had tried exactly this just in case it would help, with current
> > master (1.6.4rc1), and it still saw the same behaviour.
> 
> Strange, I can't reproduce it.

You're right, I must have forgotten --exec-path=$PWD when doing my
tests.  It also works with "git send-email --no-thread",
--no-chain-reply is (as expected) not even necessary.

Cool, I can get back to documenting that :)
