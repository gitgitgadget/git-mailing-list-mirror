From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
   to
Date: Wed, 25 Jun 2008 12:41:18 +0200
Message-ID: <486220CE.3070103@viscovery.net>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Boaz Harrosh <bharrosh@panasas.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 25 12:42:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBSSV-0001jt-1X
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 12:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbYFYKlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 06:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbYFYKlY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 06:41:24 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30689 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561AbYFYKlX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 06:41:23 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KBSRC-00052F-Vo; Wed, 25 Jun 2008 12:41:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 54BD1AFCC; Wed, 25 Jun 2008 12:41:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0806251109380.9925@racer>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86269>

Johannes Schindelin schrieb:
> Incidentally, a friend just told me that "checkout" is everything but 
> intuitive, and he would have preferred "git branch switch <branch>", but 
> then settled for my proposed "git branch --switch <branch>", which I did 
> not have time to implement yet, unfortunately.

$ git config alias.switch checkout
$ git switch topic

Hm? Notice that the command even reports back:

Switched to branch "topic"
^^^^^^^^

-- Hannes
