From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Problem with git bisect in git-1.6.3.3
Date: Thu, 09 Jul 2009 08:39:31 +0200
Message-ID: <4A5590A3.8070404@viscovery.net>
References: <c6b1100b0907082242y7b348b13m8a4607c96b1d164b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Clayton <chris2553@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 08:40:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOnIX-0001Pa-Jh
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 08:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbZGIGjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 02:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbZGIGjn
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 02:39:43 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19078 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbZGIGjm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 02:39:42 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MOnI4-0004gO-02; Thu, 09 Jul 2009 08:39:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id ACAB06B7; Thu,  9 Jul 2009 08:39:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <c6b1100b0907082242y7b348b13m8a4607c96b1d164b@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122936>

Chris Clayton schrieb:
> git bisect start
> # good: [07a2039b8eb0af4ff464efd3dfd95de5c02648c6] Linux 2.6.30
> git bisect good 07a2039b8eb0af4ff464efd3dfd95de5c02648c6
> # bad: [8e4a718ff38d8539938ec3421935904c27e00c39] Linux 2.6.31-rc2
...
> but, from Makefile, it appears the last "bad" has placed me at a
> change earlier than 2.6.30:
> 
> [chris:~/kernel/linux-2.6]$ head Makefile
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 30
> EXTRAVERSION = -rc6
...
> I'm not an experienced git user, so it may be that I have made an
> error or false assumption.

Not an error, but false assumptions:

http://thread.gmane.org/gmane.comp.version-control.git/99967/focus=99977

Just continue bisecting. If you can't test the version that bisect warps
you to because the feature where the bug happens is not present, mark that
revision as "good".

-- Hannes
