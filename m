From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for
 disconnected transfer
Date: Sat, 17 Feb 2007 09:50:04 -0500
Message-ID: <45D7161C.3050604@verizon.net>
References: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
 <7vhctl50zc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 15:50:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIQtH-0005jz-3L
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 15:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946766AbXBQOuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 09:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946769AbXBQOuP
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 09:50:15 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:38688 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946766AbXBQOuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 09:50:14 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDM00EJD3VF8213@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 17 Feb 2007 08:50:04 -0600 (CST)
In-reply-to: <7vhctl50zc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39991>

Junio C Hamano wrote:
> I haven't thought things through, but I think something like this
> would be sufficient:
>
> 	# create a bundle.
> 	$ git bundle --create v1.5.0..maint master next >file.bdl
>
>   
In this vein, would it make sense to let git-push be the front end to 
create the bundle? I'm not sure git-push really contributes anything, 
but the interface would then be consistent across all transports. Just a 
thought.

Mark
