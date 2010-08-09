From: Ralf Ebert <info@ralfebert.de>
Subject: Re: understanding how remote tracking works
Date: Mon, 09 Aug 2010 03:31:44 +0200
Message-ID: <i3nlq0$8un$1@dough.gmane.org>
References: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 03:32:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiHDe-0004dr-TC
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 03:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675Ab0HIBb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 21:31:58 -0400
Received: from lo.gmane.org ([80.91.229.12]:39180 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596Ab0HIBb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 21:31:57 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OiHDX-0004cU-Rf
	for git@vger.kernel.org; Mon, 09 Aug 2010 03:31:55 +0200
Received: from port-92-198-61-236.static.qsc.de ([92.198.61.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 03:31:55 +0200
Received: from info by port-92-198-61-236.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 03:31:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: port-92-198-61-236.static.qsc.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152942>

Hi Geoff,

> Why does "git show-ref" show me far more than in
> in .git/refs/remotes/origin?

probably the other refs come from .git/packed-refs . See 
http://www.kernel.org/pub/software/scm/git/docs/git-pack-refs.html .

Greetings,
Ralf
