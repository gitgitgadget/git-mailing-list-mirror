From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive.
Date: Sun, 18 Feb 2007 17:47:18 -0500
Message-ID: <45D8D776.9040604@verizon.net>
References: <7vejootynq.fsf@assigned-by-dhcp.cox.net>
 <11718196342317-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 18 23:47:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIuop-0000Sk-6p
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 23:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbXBRWrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 17:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbXBRWrj
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 17:47:39 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:59425 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbXBRWri (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 17:47:38 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDO00GQJKMRSPL1@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 18 Feb 2007 16:47:16 -0600 (CST)
In-reply-to: <11718196342317-git-send-email-mdl123@verizon.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40086>

Mark Levedahl wrote:
> -	git-peek-remote $exec "$peek_repo" ||
> +	if test -r "$peek_repo" ; then
>   
oops:                   test    -f
actually works. Corrected patch follows.

Mark
