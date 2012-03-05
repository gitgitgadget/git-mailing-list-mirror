From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix fixed string (non-regexp) project
 search
Date: Mon, 05 Mar 2012 19:06:22 +0000
Message-ID: <4F550EAE.5030006@ramsay1.demon.co.uk>
References: <20120228183919.26435.86795.stgit@localhost.localdomain> <4F512327.3050504@ramsay1.demon.co.uk> <201203022334.25544.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 20:42:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4dnr-0006yp-7H
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 20:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619Ab2CETme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 14:42:34 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:61236 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751563Ab2CETme (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 14:42:34 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1S4dnk-0004L6-je; Mon, 05 Mar 2012 19:42:32 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201203022334.25544.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192267>

Jakub Narebski wrote:
>> This patch solves the problem for me when using a regex search
>> (re checkbox checked), but *not* for a non-regex search.
>>
>> If you have a leading '*' or '+', in the non-regex case, then you
>> still get the above complaint (and xml error page etc.), although
>> the line number has changed slightly from that given above.
> 
> Ramsay, please provide those line number in the future, together with
> line and if possible some context.

Yeah, sorry about that; when I wrote that I didn't have the information
readily available (I would have had to shutdown Windows, boot Linux, ...)
and I was about to go out. So, the choice was to wait about 24hrs to report
with full info, or provide the feedback earlier; I chose the latter. ;-)

>  gitweb/gitweb.perl |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)

[patch snipped]

This patch works great for me. Thanks!

ATB,
Ramsay Jones
