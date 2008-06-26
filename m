From: John Locke <mail@freelock.com>
Subject: Re: git svn clone a non-standard repository
Date: Thu, 26 Jun 2008 11:39:29 -0700
Message-ID: <4863E261.8040508@freelock.com>
References: <48613DC5.2000506@freelock.com> <g3to0t$35n$1@ger.gmane.org> <4863E01E.9050108@freelock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Jun 26 20:40:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBwOJ-0006za-7j
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 20:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbYFZSjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 14:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbYFZSjW
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 14:39:22 -0400
Received: from logan.freelock.com ([216.231.62.127]:58623 "EHLO
	logan.freelock.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbYFZSjV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 14:39:21 -0400
Received: from localhost (foraker.freelock.com [127.0.0.1])
	by logan.freelock.com (Postfix) with ESMTP id 1616CA0456;
	Thu, 26 Jun 2008 11:39:21 -0700 (PDT)
Received: from logan.freelock.com ([127.0.0.1])
 by localhost (foraker.freelock.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 05191-06; Thu, 26 Jun 2008 11:39:20 -0700 (PDT)
Received: from [192.168.9.243] (router.freelock.lan [192.168.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by logan.freelock.com (Postfix) with ESMTP id E2F66A0448;
	Thu, 26 Jun 2008 11:39:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <4863E01E.9050108@freelock.com>
X-Virus-Scanned: by amavisd-new at freelock.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86471>

Sorry to respond to my own post, but this section looks wrong:

John Locke wrote:
>
>
> Now the tricky part: I checked out a new "work" branch, and deleted 
> everything in the working copy. Then, 4 steps out of the howto, 
> adjusted to pull the particular branch from the current repository 
> (instead of an outside one):
>
> git remote add -t dojo -f dojo ./
> git merge -s ours --no-commit dojo-trunk
> git read-tree --prefix=dojo/ -u dojo-trunk
> git commit -m "merge dojo into subdirectory"

... since I added the remotes as svn-remote sections directly in 
git-config, I skipped that first line.

I'm going to write this all up on my blog when I get it working correctly...

Cheers,

-- 
John Locke
"Open Source Solutions for Small Business Problems"
published by Charles River Media, June 2004
http://www.freelock.com
