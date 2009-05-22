From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 13:04:13 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0905221259330.27232@reaper.quantumfyre.co.uk>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com> <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com> <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com> <4A1671E5.4030400@op5.se> <855e4dcf0905220335n367a065fidc65567119c0a5a3@mail.gmail.com>
 <4A16822A.2060404@viscovery.net> <855e4dcf0905220436h1b6fa632q7804c98bf09b324c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Sixt <j.sixt@viscovery.net>, Andreas Ericsson <ae@op5.se>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Tim Uckun <timuckun@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 14:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7TVg-0005SW-6N
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 14:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbZEVMFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 08:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbZEVMFv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 08:05:51 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:51185 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750916AbZEVMFu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2009 08:05:50 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 77DF8131E5F
	for <git@vger.kernel.org>; Fri, 22 May 2009 13:05:51 +0100 (BST)
Received: (qmail 12043 invoked by uid 103); 22 May 2009 13:04:13 +0100
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9378. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.026523 secs); 22 May 2009 12:04:13 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 22 May 2009 13:04:13 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <855e4dcf0905220436h1b6fa632q7804c98bf09b324c@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119728>

On Fri, 22 May 2009, Tim Uckun wrote:

>>
>> Did test_new contain ignored files?
>
> No.  I put the entire transcript in the first email. I did not tell
> git to ignore anything and there were no .git directories in the test
> folder.
>
>> In this case, when you checkout the
>> branch that does not have test_new, only the tracked files are removed;
>> the ignored (i.e untracked) files remain. Therefore, after the checkout
>> you still have a test_new directory.
>>
>
> As far as I can tell all the files are tracked after I do a commit.
>
> I can understand why it put the original test directory back when I
> changed to the master branch but I don't understand why it's missing a
> subdirectory.  I don't think the test_new directory should be in the
> master branch at all but I guess I can kind of sort of see why git
> might not remove it. What I can't understand at all is why it's
> missing subdirectories.

What's in the subdirectory?  Is it empty?  If so, that would explain what 
you are seeing.  Git doesn't track directories - so an empty directory is 
always treated as an untracked file.

> I hate to say this but I tried the exact same thing with mercurial in
> the last half hour and it did exactly what I thought it should do. The
> master had the test directory but not the test_new and the branch had
> the test_new directory but not the test. No subdirectories were
> missing out of either one.

I don't know if mercurial tracks directories, if it does, then this would 
explain why it behaves diffently to git.

-- 
Julian

  ---
Even a cabbage may look at a king.
