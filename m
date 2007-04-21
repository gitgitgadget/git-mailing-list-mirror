From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFH] How to get git-gui.sh history
Date: Sat, 21 Apr 2007 17:05:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704211703340.20005@beast.quantumfyre.co.uk>
References: <e5bfff550704210204p1f231076p6a68cb9d6038f4e3@mail.gmail.com>
 <7vtzvaulwe.fsf@assigned-by-dhcp.cox.net> <e5bfff550704210238gfdb5a51i2a7f4a8d16396b28@mail.gmail.com>
 <200704211654.16393.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Michael <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 18:06:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfI5Z-0000Im-DR
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 18:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbXDUQF0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 12:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbXDUQF0
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 12:05:26 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44202 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752336AbXDUQFZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2007 12:05:25 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 860B2C64B0
	for <git@vger.kernel.org>; Sat, 21 Apr 2007 17:05:24 +0100 (BST)
Received: (qmail 21163 invoked by uid 103); 21 Apr 2007 17:04:33 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3141. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.035891 secs); 21 Apr 2007 16:04:33 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 21 Apr 2007 17:04:33 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <200704211654.16393.barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45177>

On Sat, 21 Apr 2007, Michael wrote:

> Marco Costalba wrote:
>> On 4/21/07, Junio C Hamano <junkio@cox.net> wrote:
>>> "Marco Costalba" <mcostalba@gmail.com> writes:
>>>
>>> $ git rev-list -- git-gui.sh | wc -l
>>> 158
>>>
>>
>> This is strange....

try git rev-list --all --full-history -- git-gui.sh | wc -l, that gives 
158 for me (in the git repo) ...

> I think Junio was referring to Shawn's git-gui repo:
> http://repo.or.cz/w/git-gui.git
>
> ...Obviously, if you search for git-gui.sh in the toplevel directory
> of git.git repo you won't find anything ;)...

In the git repo, try this:

git show 41bdcda37376a5faa63028f01260890723c3fcfa -- git-gui.sh

;)

-- 
Julian

  ---
[during the preview for the new action movie about Jesus]
TV Announcer:  This Christmas, let He who is without sin kick the first ass.
