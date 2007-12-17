From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first argument.
Date: Mon, 17 Dec 2007 16:13:56 +0100
Message-ID: <47669234.7020202@viscovery.net>
References: <20071217095014.GF7453@artemis.madism.org> <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com> <20071217114703.GH7453@artemis.madism.org> <Pine.LNX.4.64.0712171149540.9446@racer.site> <3CF3CEA5-72F1-47D1-ADB9-37F5C2E292A8@wincent.com> <Pine.LNX.4.64.0712171223210.9446@racer.site> <26962818-F702-44D2-BD26-95D74CE21F0D@wincent.com> <Pine.LNX.4.64.0712171253290.9446@racer.site> <223E3B44-92DA-4861-83D6-67E56F70E784@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 16:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Hfk-0003Ep-Eq
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 16:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbXLQPOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 10:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbXLQPOB
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 10:14:01 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26689 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbXLQPOA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 10:14:00 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J4HfZ-0000ki-AS; Mon, 17 Dec 2007 16:14:13 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 85C36546; Mon, 17 Dec 2007 16:13:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <223E3B44-92DA-4861-83D6-67E56F70E784@wincent.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68569>

Wincent Colaiuta schrieb:
> But leaving -p aside, will you oppose any patches that make it possible
> for people to write stuff like:
> 
> git init --bare
> 
> Personally, I think this is an obvious usability improvement worth
> striving for. Given that "git --bare init" will continue to work under
> what I'm proposing, I really can't see any worthwhile argument against
> it. Because we're talking about a UI improvement for newcomers at no
> cost to old timers.

Your point. I hate to have to think hard each time whether it's "git --bare
init" or "git init --bare" and "git clone --bare" or "git --bare clone" and
wouldn't mind if I no longer needed to.

-- Hannes
