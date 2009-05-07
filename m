From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 10:47:04 +0200
Message-ID: <4A02A008.30800@viscovery.net>
References: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de> <7vws8te2ht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 10:47:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1zGP-0007eb-1y
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 10:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbZEGIrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 04:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbZEGIrJ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 04:47:09 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:41455 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbZEGIrI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 04:47:08 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M1zFx-0000DJ-BC; Thu, 07 May 2009 10:47:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1972754D; Thu,  7 May 2009 10:47:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vws8te2ht.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118447>

Junio C Hamano schrieb:
> Matthias Andree <matthias.andree@gmx.de> writes:
> 
>> Problem: when git is installed into /usr/local/bin, running 'sudo make
>> install' won't find git in $PATH (because sudo strips PATH, for instance
>> on openSUSE 11.1, and doesn't include /usr/local/whatever).
> 
> That sounds like a bug/misfeature in sudo (which I do not use) to me.

sudo resets the environment, in particular also PATH. Why would this be a bug?

Current distros set env_reset in /etc/soduers for a reason. Not that I
know the reason in detail, but I won't claim that I'm more clever with
regards to security issues than distro packagers; so I trust that if they
do it, then it makes sense.

-- Hannes
