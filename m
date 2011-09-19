From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] Configurable hyperlinking in gitk
Date: Mon, 19 Sep 2011 11:05:52 -0400
Message-ID: <4E775A50.4070805@xiplink.com>
References: <20110917022903.GA2445@unpythonic.net> <4E7467B7.1090201@gmail.com> <20110917134527.GA28463@unpythonic.net> <4E752E32.2010208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 17:06:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5fQQ-0000xi-32
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 17:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab1ISPGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 11:06:21 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:44582 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab1ISPGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 11:06:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp29.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 7E01F1485D5;
	Mon, 19 Sep 2011 11:06:20 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp29.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 488951485D4;
	Mon, 19 Sep 2011 11:06:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Thunderbird/3.1.13
In-Reply-To: <4E752E32.2010208@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181681>

On 11-09-17 07:33 PM, Chris Packham wrote:
> 
> Hmm no joy with \&. Seems to upset the invocation of git web-browse
> 
>   git config gitk.linkify.bugtracker.sub \
>        'https://internalhost/code\&stuff/bugs.php?id=\1'
> 
>   gitk
>   /home/chrisp/libexec/git-core/git-web--browse: line 167:
> stuff/bugs.php?id=bug123: No such file or directory
>   fatal: 'web--browse' appears to be a git command, but we were not
>   able to execute it. Maybe git-web--browse is broken?
> 
> Using the following works as expected with no error with your updated patch.
> 
>   git config gitk.linkify.bugtracker.sub \
>        'https://internalhost/code%26stuff/bugs.php?id=\1'

Jeff: This is great -- thanks!

I still had problems with using an & in the URL, even with the updated patch.
 I had to apply Chris's git-web--browse patch to get it to work.

		M.
