From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 12:38:20 +0200
Message-ID: <4713431C.7030103@viscovery.net>
References: <20071014221446.GC2776@steel.home>	<023101c80eb5$e3b6b310$2e08a8c0@CAM.ARTIMI.COM> <20071015000347.GA13033@old.davidb.org> <E1IhJ7T-0008AC-8b@fencepost.gnu.org> <47133DEC.6020600@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eli Zaretskii <eliz@gnu.org>, David Brown <git@davidb.org>,
	dave.korn@artimi.com, raa.lkml@gmail.com,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org, make-w32@gnu.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 15 12:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhNLJ-0004gR-Mz
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 12:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758715AbXJOKiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 06:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758235AbXJOKiY
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 06:38:24 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:50504 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757848AbXJOKiY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 06:38:24 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IhNKs-0005kt-L9; Mon, 15 Oct 2007 12:38:10 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1B78369F; Mon, 15 Oct 2007 12:38:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47133DEC.6020600@op5.se>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60978>

Andreas Ericsson schrieb:
> Eli Zaretskii wrote:
>>
>>> If you know what the library on the other end is doing to re-parse the
>>> arguments back into separate strings, it might be possible to quote 
>>> things
>>> enough to handle names with spaces, but it is hard.
>>
>> It's not hard, it's just a bit of work.  And it needs to be done
>> exactly once.
> 
> Before someone beats me to it: "Patches welcome" ;-)

Let others do the research for you, hm?

http://repo.or.cz/w/git/mingw.git?a=blob;f=compat/mingw.c;h=2554f19765da5709b787e873da225c59f9d22bb7;hb=HEAD#l306

-- Hannes
