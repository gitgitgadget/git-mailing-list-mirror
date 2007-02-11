From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] Clean up geometry save code in gitk.
Date: Sun, 11 Feb 2007 12:44:03 -0500
Message-ID: <45CF55E3.9080508@verizon.net>
References: <11712040401127-git-send-email-mdl123@verizon.net>
 <11712040403973-git-send-email-mdl123@verizon.net>
 <1171204040779-git-send-email-mdl123@verizon.net>
 <20070211195643.b1f548f2.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Paul Mackerras <paulus@samba.org>
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Sun Feb 11 18:44:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGIkQ-0000TB-Ko
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 18:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbXBKRoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 12:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbXBKRoT
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 12:44:19 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:48889 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbXBKRoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 12:44:19 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDB00MJL7XC0V90@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 11 Feb 2007 11:44:02 -0600 (CST)
In-reply-to: <20070211195643.b1f548f2.vsu@altlinux.ru>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39299>

Sergey Vlasov wrote:
> These two patches fix saving of the window position for me; however,
> some things still remain broken:
>
>  - No matter what sizes of the commit tree, patch and filelist panes I
>    set, on gitk restart they come up with their default sizes.
>
>  - Sizes of commit tree columns are not saved properly - on every gitk
>    restart the dividers are shifting more and more to the right.
>
> This is on Linux (x86_64) with Tk 8.4.13.
>
> I made two more patches which fix the above problems for me - please
> test them (in particular, someone needs to check that the Cygwin
> support is not broken - apparently something is different between Tk
> on Linux and Cygwin to create the problem with commit tree columns).
>
> See the followup messages.
>
> --
> Sergey Vlasov
>   

I could not actually apply your patches, but your suggested changes were 
simple enough to apply by hand:
1) I do notice the change in size of panes in the upper window on Cygwin 
(hadn't noticed before but it is there), and your "-highlightthickness 
0" tweak fixes that. Just for grins, I tried reenabling the "subtract 2" 
strategy in place before, and that only makes the problem worse on Cygwin.
2) I don't see any effect of the "pane configure" tweak on Cygwin. 
Haven't checked on Linux (don't have that here) so cannot comment.

Gotta say, the more I play with Tk, the more I wonder why anyone uses 
anything else  ;-) .

Mark
