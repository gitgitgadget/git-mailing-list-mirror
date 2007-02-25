From: Mark Levedahl <mlevedahl@verizon.net>
Subject: Re: autoCRLF, git status, git-gui, what is the desired behavior?
Date: Sun, 25 Feb 2007 16:14:04 -0500
Message-ID: <45E1FC1C.4090409@verizon.net>
References: <45E1E47C.5090908@verizon.net>
 <7vlkimrp1f.fsf@assigned-by-dhcp.cox.net>
 <7vfy8urngi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 22:14:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLQhN-0000dz-C1
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 22:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbXBYVOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 16:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbXBYVOL
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 16:14:11 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:39185 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965058AbXBYVOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 16:14:10 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JE100G3MEZA7STE@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 25 Feb 2007 15:13:59 -0600 (CST)
In-reply-to: <7vfy8urngi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40576>

Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
>   
> It might be interesting to try this patch.
>   
This patch makes no difference to the problems I noted in my second 
message where the file undergoes crlf->lf translation on commit, so 
working copy is known to be different than blob. Is it the case that the 
size info stored in the index reflects the size of the blob rather than 
of the working copy? Absent autoCRLF these are of course identical, but 
with autoCRLF they are not and what we need stored is the working file 
info (at least for checking dirty-ness).

Mark
