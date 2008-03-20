From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] rebase [--onto O] A B: omit needless checkout
Date: Thu, 20 Mar 2008 08:41:04 +0100
Message-ID: <47E21510.6020009@viscovery.net>
References: <20080312191041.GF3198@ins.uni-bonn.de> <47D8D5B8.70809@viscovery.net> <20080315103954.GD14769@ins.uni-bonn.de> <7vk5k3n2ho.fsf_-_@gitster.siamese.dyndns.org> <47E10D0D.2080702@viscovery.net> <7vhcf24j3e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 08:41:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcFPR-0002gm-6Q
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 08:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbYCTHlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 03:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754269AbYCTHlM
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 03:41:12 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24081 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772AbYCTHlK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 03:41:10 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JcFNn-0001gO-LI; Thu, 20 Mar 2008 08:40:16 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0F66B4E4; Thu, 20 Mar 2008 08:41:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vhcf24j3e.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77637>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Junio C Hamano schrieb:
>>> This teaches "git rebase [--onto O] A B" to omit an unnecessary checkout
>>> of branch B before it goes on.
>>> ...
>> This works for a frequent use-case of mine:
> 
> "Works" meaning "does not break", or "gives a great performance
> improvement that it is worth having it early in a tagged release"?

Sorry for being so terse. "Works", of course, means "works as expected",
and the "expected" part of that is that the annoyance is no longer
present, which is the unnecessary checkout.

But given how intrusive the patch is ("just to remove an unnecessary
checkout"), I'd say this is post-1.5.5 material. Also, the fact that you
had to post a fix-up is an indication that there are probably a number of
corner cases that need an extended testing period.

-- Hannes
