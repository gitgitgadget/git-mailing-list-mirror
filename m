From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: list all the untrack files in a git respo
Date: Wed, 04 Jun 2008 17:55:03 +0200
Message-ID: <g26dsq$dqr$1@ger.gmane.org>
References: <75b57c110806040705mc324d9dx9ce099593ce967dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 17:57:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3vLN-0003pD-8l
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 17:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbYFDPzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 11:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754196AbYFDPzP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 11:55:15 -0400
Received: from main.gmane.org ([80.91.229.2]:54634 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbYFDPzO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 11:55:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K3vKT-0006sD-Mq
	for git@vger.kernel.org; Wed, 04 Jun 2008 15:55:13 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 15:55:13 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 15:55:13 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <75b57c110806040705mc324d9dx9ce099593ce967dd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83792>

Gerb Stralko venit, vidit, dixit 04.06.2008 16:05:
> Is there a way to list only the untracked files in git? git status
> works, but i need to do some parsing in order to get a list of
> untracked files.  Something like git status --show-only-untracked?
> 
> thanks
> 
> Jerry

git-ls-files --others --exclude-standard

may be what you are looking for.

Michael
