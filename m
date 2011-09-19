From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: how to remove unreachable objects?
Date: Mon, 19 Sep 2011 22:36:47 +0200
Message-ID: <m239fsuv4w.fsf@igel.home>
References: <20110919110831.ewq03vnqos4w8cs8@webmail.edis.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: dieter@schoen.or.at
X-From: git-owner@vger.kernel.org Mon Sep 19 22:36:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5kaF-0007OO-8a
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 22:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097Ab1ISUgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 16:36:50 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:56028 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682Ab1ISUgu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 16:36:50 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 7E9031C0F590;
	Mon, 19 Sep 2011 22:36:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 6B3E61C0008D;
	Mon, 19 Sep 2011 22:36:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id JmNj953ViJ5E; Mon, 19 Sep 2011 22:36:48 +0200 (CEST)
Received: from igel.home (ppp-93-104-154-188.dynamic.mnet-online.de [93.104.154.188])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon, 19 Sep 2011 22:36:47 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 9C1E7CA296; Mon, 19 Sep 2011 22:36:47 +0200 (CEST)
X-Yow: I've got to get these SNACK CAKES to NEWARK by DAWN!!
In-Reply-To: <20110919110831.ewq03vnqos4w8cs8@webmail.edis.at>
	(dieter@schoen.or.at's message of "Mon, 19 Sep 2011 11:08:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181702>

dieter@schoen.or.at writes:

> if you look at the output of this script then you see that git knows  
> that there
> are unreachable/dangling objects, but they remain.

You also need to prune the reflog of HEAD.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
