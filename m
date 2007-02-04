From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sun, 4 Feb 2007 11:35:36 -0500
Message-ID: <155A5E6A-9EC5-424B-A231-02EF1FE0FD2B@silverinsanity.com>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com> <20070203181329.GA10192@179.242.249.10.in-addr.arpa> <7v4pq358q4.fsf@assigned-by-dhcp.cox.net> <F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com> <7vabzv3qxi.fsf@assigned-by-dhcp.cox.net> <A9623793-111E-47F7-9709-1D569333C40C@silverinsanity.com> <7vlkje243u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 17:35:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDkL6-00076j-Vv
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 17:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbXBDQfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 11:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbXBDQfj
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 11:35:39 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:44802 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbXBDQfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 11:35:38 -0500
Received: from [192.168.1.3] (cpe-66-66-74-194.rochester.res.rr.com [66.66.74.194])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id EADA61FFC02B;
	Sun,  4 Feb 2007 16:35:37 +0000 (UTC)
In-Reply-To: <7vlkje243u.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38695>

Shawn has already provided an example of what happens to a UTF8  
string on OS X, so I won't provide a duplicate.

On Feb 3, 2007, at 6:50 PM, Junio C Hamano wrote:

> I think it is fairly idiotic and obtuse for a filesystem to
> treat pathnames anything but a random sequence of bytes that is
> slash separated and NUL terminated.  I would need a really hard
> convincing to buy any path munging on the git side to match
> whatever a stupid filesystem does, especially because we do not
> live in the ideal Unicode/utf-8 only world.

That's what I was agreeing with.  It drives me crazy that HFS+ is  
case-insensitive and now does bad things to UTF8 strings.  And I  
didn't think that doing munging similar to the FS in git is a good  
idea for Git in general, but might be useful for a few people like  
myself to have.  And it wouldn't break anything that isn't already  
broken.

Unfortunately my lack of understanding of ICU means I can't actually  
get the code to do anything useful, so it's a moot point.

~~ Brian
