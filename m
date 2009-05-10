From: Bryan Drewery <bryan@shatow.net>
Subject: Re: [PATCH] Fix git-push --mirror also mirroring refs/remotes/
Date: Sun, 10 May 2009 16:31:37 -0500
Message-ID: <4A0747B9.1080707@shatow.net>
References: <1241984136-2578-1-git-send-email-bryan@shatow.net> <200905102225.25508.markus.heidelberg@web.de> <4A073E2E.6060403@shatow.net> <200905102313.13544.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sun May 10 23:32:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Gd1-0005rZ-Fz
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 23:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbZEJVbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 17:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755801AbZEJVbr
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 17:31:47 -0400
Received: from data.xzibition.com ([64.18.130.122]:51583 "EHLO
	data.xzibition.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbZEJVbr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 17:31:47 -0400
Received: from c-75-73-187-87.hsd1.mn.comcast.net ([75.73.187.87] helo=[192.168.10.8])
	by data.xzibition.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <bryan@shatow.net>)
	id 1M3Gco-000OJs-Of; Sun, 10 May 2009 17:31:58 -0400
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200905102313.13544.markus.heidelberg@web.de>
X-Enigmail-Version: 0.95.7
OpenPGP: id=3A809694;
	url=www.shatow.net/bryan.asc
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - data.xzibition.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [26 6] / [26 6]
X-AntiAbuse: Sender Address Domain - shatow.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118750>

Markus Heidelberg wrote:
> Bryan Drewery, 10.05.2009:
>   
>> This behavior makes no sense to me. Can we at least add a config option
>> to make it not push remotes? I push my development repository
>> to a remote private repository only as a backup, and push my master/next
>> to a public repository. I see no reason to push my 8 remotes and
>> all their branches to my backup repository.
>>     
>
> Why are you disturbed by the remotes, if it's only a backup repository
> where you don't look into in the normal case?
>
>   
If it's going to push remote heads, shouldn't it (in line with "mirror")
also push all
remote settings for all remotes from the config to the destination
repository, as
well as other config settings?

If not, then why push remote heads at all?

Bryan
