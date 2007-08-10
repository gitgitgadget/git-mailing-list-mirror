From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 2/2] tweak manpage formatting
Date: Fri, 10 Aug 2007 15:32:07 -0400
Message-ID: <3BCFD157-64CE-408E-BFE8-C720A9FAE080@silverinsanity.com>
References: <7vbqdfvng9.fsf@assigned-by-dhcp.cox.net> <0F764326-63E8-447D-A2D4-E56E999775D7@silverinsanity.com> <7v3ayrtil5.fsf@assigned-by-dhcp.cox.net> <1b46aba20708101216s7660741ds5ef4c4c0fd13b45c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJaDX-0001ws-UZ
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 21:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086AbXHJTcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 15:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758793AbXHJTcJ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 15:32:09 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:41752 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978AbXHJTcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 15:32:08 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 997911FFC231;
	Fri, 10 Aug 2007 19:32:07 +0000 (UTC)
In-Reply-To: <1b46aba20708101216s7660741ds5ef4c4c0fd13b45c@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55569>


On Aug 10, 2007, at 3:16 PM, Carlos Rica wrote:

> I think this was because the end-of-line backslash "\" in the ASCII
> art diagram in the Documentation/git-rev-parse.txt.

No, it was complaining about unknown "man.indent.width" in  
callout.xsl.  Apparently docbook-xsl 1.69 doesn't like that.   
Updating it to 1.71 made it work again.  I lost the original error  
while updating before sending the first mail, unfortunately.  If it's  
truly needed, I probably still have the 1.69 deb file on my computer  
somewhere.

~~ Brian
