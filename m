From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: [TOY PATCH] git wrapper: show similar command names for an unknown
 command
Date: Thu, 05 Jun 2008 22:59:29 +0200
Message-ID: <484853B1.80509@dirk.my1.cc>
References: <alpine.DEB.1.00.0806050747000.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 23:00:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MZk-0002oL-Bg
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 23:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762137AbYFEU7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbYFEU7h
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:59:37 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:58990 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762137AbYFEU7c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:59:32 -0400
Received: from [84.176.92.107] (helo=[192.168.2.100])
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1K4MYU-00049P-8M; Thu, 05 Jun 2008 22:59:30 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <alpine.DEB.1.00.0806050747000.21190@racer>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83981>

Johannes Schindelin schrieb:
> This patch introduces a modified Damerau-Levenshtein algorithm into
> Git's code base, and uses it with the following penalties to show some
> similar commands when an unknown command was encountered:
>
> 	swap = 0, insertion = 1, substitution = 2, deletion = 4
>
> A typical output would now look like this:
>
> 	$ git reabse
> 	git: 'reabse' is not a git-command. See 'git --help'.
>
> 	Did you mean one of these?
> 		rebase
> 		merge-base
> 		rev-parse
> 		remote
> 		rerere
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 	This is just a toy, but might be useful to other people.
>
>   
[snip]

Whow! This is really cool, especially for people that do not know the
different commands by heart -- like me. I often know there's a
command that's spelled somehow like X but I don't exactly remember.
Your patch seems perfect for that situation. :-)
Keen on seeing it in a future release. Thanks in advance. Did someone
suggest it or was it your very own idea?

    -- Dirk
