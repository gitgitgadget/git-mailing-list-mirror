From: Sean <seanlkml@sympatico.ca>
Subject: Re: git bisect with history manipulation
Date: Mon, 23 Oct 2006 12:25:27 -0400
Message-ID: <BAYC1-PASMTP110AEA1A20D3DF82D9BCE8AE000@CEZ.ICE>
References: <a425f86c0610230718i556537dei9a4b2a5fa8d7f003@mail.gmail.com>
	<a425f86c0610230722r2a0ae473o467d303f915b6c1e@mail.gmail.com>
	<BAYC1-PASMTP01856E85F8D54BE3CBF69EAE000@CEZ.ICE>
	<ehiq2l$lkq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 18:26:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc2cH-0007qq-Mz
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 18:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbWJWQZa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 12:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbWJWQZa
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 12:25:30 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:37600 "EHLO
	BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1751992AbWJWQZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 12:25:29 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 23 Oct 2006 09:34:21 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1Gc1g7-0003iG-Bt; Mon, 23 Oct 2006 11:25:27 -0400
To: Jakub Narebski <jnareb@gmail.com>
Message-Id: <20061023122527.4c095580.seanlkml@sympatico.ca>
In-Reply-To: <ehiq2l$lkq$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 23 Oct 2006 16:34:22.0125 (UTC) FILETIME=[182B4DD0:01C6F6C1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Oct 2006 18:19:56 +0200
Jakub Narebski <jnareb@gmail.com> wrote:

> Sean wrote:
> 
> > $ patch < patch1
> 
> We have git-apply for that (sometimes git-am would work on whole
> series of patches).

Point taken.  git-rebase and git-cherrypick may also be appropriate
to snag the commits from another branch rather than reapplying them
from patches.  In fact you may already have a branch that works
which contains just your patches on top of it.  I was trying to
make the example as clear as possible rather than exhaustive.

Sean
