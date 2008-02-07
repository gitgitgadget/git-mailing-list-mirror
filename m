From: Tommy Thorn <tommy-git@thorn.ws>
Subject: Bug in gitk - can post the window off screen
Date: Wed, 06 Feb 2008 22:16:52 -0800
Message-ID: <47AAA254.2020008@thorn.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 07:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN051-0000cc-Oh
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 07:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbYBGGRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 01:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbYBGGRA
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 01:17:00 -0500
Received: from server204.webhostingpad.com ([69.65.0.218]:42618 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752412AbYBGGQ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2008 01:16:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=thorn.ws;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir;
	b=MTDNcFXl5Hein4p5/zvX7aa+3I0iUGnStWWnIHAJGA1UxtGd42aO3CK4IqqdI5BDh+96HxVqAmxwC5Dhqa4/v4aFQXJXtQTNF80zxfynRN42vjP2ovh7FQAf1yw/UnhE;
Received: from 208.65.183.75.static.etheric.net ([208.65.183.75] helo=silver.numba-tu.com)
	by server204.webhostingpad.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JN048-0000tf-2d
	for git@vger.kernel.org; Thu, 07 Feb 2008 00:16:56 -0600
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72896>

Just a quick heads-up: I was running a dual screen setup with gitk on my 
2nd monitor. When I later started gitk up without the 2nd monitor, the 
gitk window didn't appear. Given the time between the two sessions, it 
didn't occur to me what the problem was.

Gitk should probably validate the "set geometry(main)" variable against 
the current resolution.

Tommy
