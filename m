From: Panagiotis Issaris <takis@issaris.org>
Subject: Sending a thread of patches
Date: Mon, 05 Mar 2007 00:00:40 +0100
Message-ID: <45EB4F98.7030206@issaris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 00:00:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNzgp-0005zd-Re
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 00:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbXCDXAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 18:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbXCDXAY
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 18:00:24 -0500
Received: from outmx016.isp.belgacom.be ([195.238.4.115]:46256 "EHLO
	outmx016.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbXCDXAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 18:00:23 -0500
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
        by outmx016.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id l24N0KsZ027282
        for <git@vger.kernel.org>; Mon, 5 Mar 2007 00:00:20 +0100
        (envelope-from <takis@issaris.org>)
Received: from [192.168.1.11] (78.129-64-87.adsl-dyn.isp.belgacom.be [87.64.129.78])
        by outmx016.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id l24N0GKR027256
        for <git@vger.kernel.org>; Mon, 5 Mar 2007 00:00:16 +0100
        (envelope-from <takis@issaris.org>)
User-Agent: Thunderbird 2.0b2 (X11/20070116)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41386>

Hi,

I am trying to send a thread of patches to a mailinglist but the e-mails 
do not show up as one thread in some mailclients.
Gmane shows the patches nicely in one thread [1], but Thunderbird shows 
all of them _except one_ as a thread. E-mail [PATCH 02/31]
does not show up in the thread but beside it. The CC-ed emails which 
arrived in my inbox do not appear in one thread either, half of
them do end up in one thread, the other half don't. This is possibly 
(most likely?) a Thunderbird problem as the e-mails appear alright in Mutt,
but I was wondering if other people had noticed similar problems with 
Thunderbird+git-format-patch+git-send-email and if they might have some
workarounds. Or, if someone might  notice that I am just using incorrect 
parameters for both commands.

These are the commands I used:
git format-patch --thread --attach -n origin..or2
git-send-email --no-chain-reply-to --to ffmpeg-devel@mplayerhq.hu  
--from takis.issaris@uhasselt.be --subject "[PATCH 00/31] Various 
Doxygen related patches"  --suppress-from --compose 00*patch

With friendly regards,
Takis

[1] http://thread.gmane.org/gmane.comp.video.ffmpeg.devel/45715
