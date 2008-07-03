From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: RFC: grafts generalised
Date: Thu, 03 Jul 2008 09:42:45 +0200
Message-ID: <486C82F5.6080405@viscovery.net>
References: <20080702143519.GA8391@cuci.nl> <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com> <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com> <20080702181021.GD16235@cuci.nl> <486C6B8E.5040202@viscovery.net> <20080703073041.GA28566@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:27:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK9z-0002yW-9a
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655AbYGCIVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 04:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755612AbYGCITY
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 04:19:24 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41494 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937020AbYGCHmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 03:42:47 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KEJSn-0007tc-IL; Thu, 03 Jul 2008 09:42:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3F50F54D; Thu,  3 Jul 2008 09:42:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080703073041.GA28566@cuci.nl>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87259>

Stephen R. van den Berg schrieb:
> Actually, ripple-through changes are rare.  In the current project it
> seems I need exactly one, but it's buried deep in the past (sadly).
> The reason why I need it, is to make sure that git-bisect will work for
> any revision in the past (i.e. the tree contained/contains some
> too-clever-for-their-own-good $Revision$-expansion dependencies)

But you do know that you don't need to apply the change *now*; you can
apply it at bisect-time? Unless you expect you or your mere mortal
coworkers are going to do dozens of bisects into that part of the history,
I wouldn't change history *like*this*. But of course, I don't understand
the circumstances enough, so... just my 2 cents.

-- Hannes
