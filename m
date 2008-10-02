From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to remove a commit object?
Date: Thu, 02 Oct 2008 17:02:22 +0200
Message-ID: <48E4E27E.7030308@viscovery.net>
References: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>	 <48D36DF4.3030607@drmicha.warpmail.net>	 <33f4f4d70810020636g77f4180cm7aa6b7de07ae5beb@mail.gmail.com>	 <m3ljx7qemk.fsf@localhost.localdomain> <33f4f4d70810020726g71c6f39eq16585269fb268322@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Steven Grimm <koreth@midwinter.com>,
	Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 17:06:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPiO-0007RG-9g
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 17:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbYJBPCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 11:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbYJBPCa
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 11:02:30 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37381 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbYJBPC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 11:02:29 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KlPh9-0005cr-9Z; Thu, 02 Oct 2008 17:02:25 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0A7FF6B7; Thu,  2 Oct 2008 17:02:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <33f4f4d70810020726g71c6f39eq16585269fb268322@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97351>

Klas Lindberg schrieb:
> A solution to both problems seemed to be to use git-filter-branch to
> create a new repo by filtering out all the unwanted files. The
> astonishing result was that, for the subdirectory I tried it on, 90%
> or so of the commits on that subdirectory just disappeared. It didn't
> look right at all. Although I can't say for sure exactly what I did
> with filter-branch, I would appreciate some guidance for using it. It
> basically seemed to do exactly what I wanted (recreate the repo, minus
> some explicit stuff, with history intact otherwise), except the result
> looked crazy.

And your definition of 'crazy' is...?

I assume that you used --subdirectory-filter. This has issues that will be
fixed in 1.6.1. You need a current 'master' git (at least b805ef08).

-- Hannes
