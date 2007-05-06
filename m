From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Sun, 6 May 2007 23:53:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705062344230.29485@reaper.quantumfyre.co.uk>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
 <vpqbqgxak1i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon May 07 00:53:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkpbT-0006EN-8c
	for gcvg-git@gmane.org; Mon, 07 May 2007 00:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbXEFWxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 18:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbXEFWxQ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 18:53:16 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:54003 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751526AbXEFWxP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 18:53:15 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 8C4D1C6253
	for <git@vger.kernel.org>; Sun,  6 May 2007 23:53:13 +0100 (BST)
Received: (qmail 24085 invoked by uid 103); 6 May 2007 23:51:43 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3211. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.060161 secs); 06 May 2007 22:51:43 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 6 May 2007 23:51:43 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <vpqbqgxak1i.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46384>

On Sun, 6 May 2007, Matthieu Moy wrote:

> The reason why I'm posting this is that I was wondering whether
> "commit -a" not being the default was supposed to be a message like
> "you shouln't use it too often".

Well, personally I practically never use it, I find that having a 
separation between what the current state of my tree is and what will be 
comitted to be one of the really "oh wow, why doens't everything else do 
this?" features.  However, i tend to be working on more than one thing at 
once, and switch between them - so I commit work on A while work on B is 
still unfinished, then start C, finish B some point later and commit it, 
and then I can finish C.  Git is the first VCS that supports a butterfly 
mind :P.

> It seems it isn't. I'll just get used to "commit -a" (and probably
> alias it), and discover the actual benefits of the index little by
> little.

"git add -i" - this is a feature I have wanted since I started using 
version control ...

-- 
Julian

  ---
Your good nature will bring you unbounded happiness.
