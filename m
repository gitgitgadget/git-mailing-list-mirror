From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: RFC: grafts generalised
Date: Thu, 3 Jul 2008 11:37:19 +0200
Message-ID: <20080703093719.GD29838@cuci.nl>
References: <20080702143519.GA8391@cuci.nl> <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com> <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com> <20080702181021.GD16235@cuci.nl> <486C6B8E.5040202@viscovery.net> <20080703073041.GA28566@cuci.nl> <486C82F5.6080405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:53:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEOIj-0005Az-TR
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269AbYGCMlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756641AbYGCMk7
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:40:59 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:41934 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482AbYGCMk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:40:58 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 479AA4E02; Thu,  3 Jul 2008 11:37:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <486C82F5.6080405@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87283>

Johannes Sixt wrote:
>Stephen R. van den Berg schrieb:
>> Actually, ripple-through changes are rare.  In the current project it
>> seems I need exactly one, but it's buried deep in the past (sadly).
>> The reason why I need it, is to make sure that git-bisect will work for
>> any revision in the past (i.e. the tree contained/contains some
>> too-clever-for-their-own-good $Revision$-expansion dependencies)

>But you do know that you don't need to apply the change *now*; you can
>apply it at bisect-time? Unless you expect you or your mere mortal
>coworkers are going to do dozens of bisects into that part of the history,
>I wouldn't change history *like*this*. But of course, I don't understand
>the circumstances enough, so... just my 2 cents.

That is exactly the case, I do expect dozens of bisects.
-- 
Sincerely,
           Stephen R. van den Berg.

This is a day for firm decisions!  Or is it?
