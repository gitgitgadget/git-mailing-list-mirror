From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Fix tests when using bash_completion
Date: Mon, 23 Apr 2007 22:39:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704232235280.7626@beast.quantumfyre.co.uk>
References: <769697AE3E25EF4FBC0763CD91AB1B0201D496D0@MBGMail01.mobot.org>
 <7vvefmeqs6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Ron Parker <ron.parker@mobot.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 23:39:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg6GH-0003lb-DL
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 23:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbXDWVji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 17:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754284AbXDWVjh
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 17:39:37 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44114 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754274AbXDWVjW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 17:39:22 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 029EAC613B
	for <git@vger.kernel.org>; Mon, 23 Apr 2007 22:39:20 +0100 (BST)
Received: (qmail 25172 invoked by uid 103); 23 Apr 2007 22:38:24 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3147. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.035791 secs); 23 Apr 2007 21:38:24 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 23 Apr 2007 22:38:23 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7vvefmeqs6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45366>

On Mon, 23 Apr 2007, Junio C Hamano wrote:

> "Ron Parker" <ron.parker@mobot.org> writes:
>
>> When using bash_completion, 'cd' echos the target directory name to
>> standard
>> out.  If 'cd' participates in a pipe whose output is compared against an
>> expected value, this causes a false failure report.  Pipe cd's stdout to
>> /dev/null in these cases.
>
> This is way too ugly.
>
> Are you sure bash-completion is the culprit, not your CDPATH?

even with bash-completion _and_ CDPATH I only get a print when changing to 
a directory in CDPATH not the current directory ... perhaps an alias set 
for cd?

(I'm not the only one who thinks CDPATH is ick am I? :S)

-- 
Julian

  ---
BOFH Excuse #350:

paradigm shift...without a clutch
