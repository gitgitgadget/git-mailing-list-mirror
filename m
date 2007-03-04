From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Sending a thread of patches
Date: Sun, 4 Mar 2007 23:56:42 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703042354250.15433@beast.quantumfyre.co.uk>
References: <45EB4F98.7030206@issaris.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Panagiotis Issaris <takis@issaris.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 00:56:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO0ZP-0004Sc-2B
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 00:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbXCDX4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 18:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbXCDX4p
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 18:56:45 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:57138 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbXCDX4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 18:56:44 -0500
Received: (qmail 28769 invoked by uid 103); 4 Mar 2007 23:56:43 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2713. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.033204 secs); 04 Mar 2007 23:56:43 -0000
Received: from unknown (HELO beast.quantumfyre.co.uk) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 4 Mar 2007 23:56:42 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <45EB4F98.7030206@issaris.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41391>

On Mon, 5 Mar 2007, Panagiotis Issaris wrote:

> Hi,
>
> I am trying to send a thread of patches to a mailinglist but the e-mails do 
> not show up as one thread in some mailclients.
> Gmane shows the patches nicely in one thread [1], but Thunderbird shows all 
> of them _except one_ as a thread. E-mail [PATCH 02/31]
> does not show up in the thread but beside it. The CC-ed emails which arrived 
> in my inbox do not appear in one thread either, half of
> them do end up in one thread, the other half don't. This is possibly (most 
> likely?) a Thunderbird problem as the e-mails appear alright in Mutt,
> but I was wondering if other people had noticed similar problems with 
> Thunderbird+git-format-patch+git-send-email and if they might have some
> workarounds. Or, if someone might  notice that I am just using incorrect 
> parameters for both commands.
>
> These are the commands I used:
> git format-patch --thread --attach -n origin..or2
> git-send-email --no-chain-reply-to --to ffmpeg-devel@mplayerhq.hu  --from 
> takis.issaris@uhasselt.be --subject "[PATCH 00/31] Various Doxygen related 
> patches"  --suppress-from --compose 00*patch

As far as I can figure, you don't want to use the --thread option to 
git-format-patch when using git-send-email.  However, I found 
git-send-email confusing enough that I just finished writing my own script 
to sit ontop of git-format-patch so I may be wrong ...

-- 
Julian

  ---
... relaxed in the manner of a man who has no need to put up a front of
any kind.
 		-- John Ball, "Mark One: the Dummy"
