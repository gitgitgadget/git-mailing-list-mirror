From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-branch --with=commit
Date: Thu, 08 Nov 2007 08:36:15 +0100
Message-ID: <4732BC6F.7070005@viscovery.net>
References: <7vpryl8x5t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 08:36:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq1wG-0007d4-U3
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 08:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbXKHHgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 02:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753943AbXKHHgS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 02:36:18 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52093 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbXKHHgR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 02:36:17 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iq1vX-0001Ps-II; Thu, 08 Nov 2007 08:35:47 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 509BF6B7; Thu,  8 Nov 2007 08:36:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vpryl8x5t.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63946>

Junio C Hamano schrieb:
>      $ git checkout -b xx/maint-fix-foo
>      $ git am -3 -s ,xx-maint-fix-foo.patch

Is this comma a hidden feature?

> With this patch, I could do this to find out which topic
> branches already contain the faulty commit:
> 
>     $ git branch --with=maint^ | grep /
>       xx/maint-fix-foo

It'd be helpful if you could construct the example in this commit message 
such that you don't need the "grep /" here; otherwise, the reader doesn't 
know which part of the effect is hidden by the grep.

-- Hannes
