From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH 4/3] git-svn: allow `info' command to work offline
Date: Wed, 21 Nov 2007 19:24:29 -0800
Message-ID: <4744F66D.7030007@apple.com>
References: <1195675039-26746-1-git-send-email-ddkilzer@kilzer.net>
 <20071122022343.GA9992@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 04:24:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv2gM-0000Lb-TW
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 04:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbXKVDYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 22:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbXKVDYc
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 22:24:32 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:63417 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbXKVDYb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 22:24:31 -0500
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id 2B6D719DD94A
	for <git@vger.kernel.org>; Wed, 21 Nov 2007 19:24:31 -0800 (PST)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 13A492808B
	for <git@vger.kernel.org>; Wed, 21 Nov 2007 19:24:31 -0800 (PST)
X-AuditID: 11807134-a6769bb000001d52-4c-4744f66e4495
Received: from elliott.apple.com (elliott.apple.com [17.151.62.13])
	by relay14.apple.com (Apple SCV relay) with ESMTP id CE57E28056
	for <git@vger.kernel.org>; Wed, 21 Nov 2007 19:24:30 -0800 (PST)
Received: from [10.0.1.199] ([67.160.250.192])
 by elliott.apple.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0JRW00KW81GUE520@elliott.apple.com> for
 git@vger.kernel.org; Wed, 21 Nov 2007 19:24:30 -0800 (PST)
In-reply-to: <20071122022343.GA9992@soma>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65738>

Eric Wong wrote:
> +	my $k = "svn-remote.$self->{repo_id}.reposRoot";
>   

"repoRoot" seems slightly more intuitive than "reposRoot", given that 
"repository" is normally abbreviated as "repo".

-Adam
