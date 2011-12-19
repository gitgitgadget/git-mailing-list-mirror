From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: Escape character for .gitconfig
Date: Mon, 19 Dec 2011 16:59:21 +0100
Message-ID: <4EEF5F59.8030802@dirk.my1.cc>
References: <4EEC6A9D.1060005@icefield.yk.ca> <20111217105806.GB23935@sigill.intra.peff.net> <4EED9BE5.8060600@icefield.yk.ca> <20111218095120.GA2290@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Erik Blake <erik@icefield.yk.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 19 16:59:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcfcg-00079S-JC
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 16:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713Ab1LSP71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 10:59:27 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.100]:56876 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab1LSP7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 10:59:25 -0500
Received: from [84.176.42.34] (helo=[192.168.2.100])
	by smtprelay05.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1RcfcY-0000sx-Ir; Mon, 19 Dec 2011 16:59:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111218095120.GA2290@sigill.intra.peff.net>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187453>

Am 18.12.2011 10:51 schrieb Jeff King:
> On Sun, Dec 18, 2011 at 08:53:09AM +0100, Erik Blake wrote:
> 
[...]
>> Now, however, I have a different problem in that notepad++ is somehow
>> signalling git that editing is complete before I even get a chance to
>> edit the file. I am trying the command
>>> git commit --amend
[...]
> 
> I know nothing about notepad++, but a quick google turned up the
> "-multiInst" option, which would avoid attaching to the existing
> instance. That might work for you.
> 
> -Peff

Jeff is right! I also use notepad++ and have set

export GIT_EDITOR='notepad++ -multiInst'

in my .bashrc (msysGit). And btw: notepad++ DOES handle cr/lf. Look at
the "Format" menu.

    Dirk
