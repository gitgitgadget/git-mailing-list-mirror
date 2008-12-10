From: Tim Olsen <tim@brooklynpenguin.com>
Subject: Re: fatal output from git-show really wants a terminal
Date: Wed, 10 Dec 2008 15:10:53 -0500
Message-ID: <4940224D.9060607@brooklynpenguin.com>
References: <ghop5d$qud$1@ger.gmane.org> <200812102046.50186.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 21:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAVQ6-0008D4-Gd
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 21:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbYLJULN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 15:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbYLJULM
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 15:11:12 -0500
Received: from main.gmane.org ([80.91.229.2]:41788 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbYLJULM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 15:11:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LAVOk-0004FJ-3I
	for git@vger.kernel.org; Wed, 10 Dec 2008 20:11:06 +0000
Received: from cyrus.limewire.com ([76.8.67.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 20:11:06 +0000
Received: from tim by cyrus.limewire.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 20:11:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cyrus.limewire.com
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <200812102046.50186.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102711>

Johannes Sixt wrote:
> The pattern is that if stdout is a terminal, the pager is thrown up and both 
> stdout and stderr of git show proper are redirected to the pager. If you 
> redirect only stderr, then this redirection is actually ignored.

I see.  So I probably want to use --no-pager.

Thanks for the help.

-Tim

> 
> -- Hannes
