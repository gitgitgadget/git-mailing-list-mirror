From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 2/2] git-gui: teach fetch/prune menu to do it for
 all	remotes
Date: Tue, 22 Feb 2011 19:36:23 +0100
Message-ID: <4D640227.9090206@web.de>
References: <20110212164344.GA19433@book.hvoigt.net> <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com> <20110213134753.GC31986@book.hvoigt.net> <20110213135714.GE31986@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@gmail.com>,
	Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 19:37:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prx7C-00039K-GY
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 19:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165Ab1BVSha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 13:37:30 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:42971 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab1BVSha (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 13:37:30 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id 72CBB1991D34B;
	Tue, 22 Feb 2011 19:36:28 +0100 (CET)
Received: from [93.246.47.135] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Prx64-0000wD-00; Tue, 22 Feb 2011 19:36:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110213135714.GE31986@book.hvoigt.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18+R18F1p/FrEy8Cl20tF4eJOxpA9FFvTKzV+te
	7ZwSMAaESF4VyAV5Pz19jiboBusOsdux46pWji/ivEwDeR5yNG
	yisZdq59LLaN1xZlA4Yw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167570>

Am 13.02.2011 14:57, schrieb Heiko Voigt:
> The commandline fetch already has this option for some time.  Since this
> was not available at the time git gui was written lets implement it now.

I really like this feature, I wanted to have that for quite some time!

After testing it, I noticed two minor things:

1) It would be nice if the new menu entry would only appear when there
   is more than one remote to fetch from.

2) I would rather like to see it at the *end* of the submenu, not at the
   beginning. Being used to always click on the first menu entry only
   to learn that the remote that used to be there got with something
   else is kind of surprising ;-)

What do others think?
