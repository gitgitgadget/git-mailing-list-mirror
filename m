From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 10:51:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705021046230.2425@reaper.quantumfyre.co.uk>
References: <200705012346.14997.jnareb@gmail.com> <200705020955.04582.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	releases@openoffice.org, Jan Holesovsky <kendy@suse.cz>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 11:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjBVH-0007qA-LN
	for gcvg-git@gmane.org; Wed, 02 May 2007 11:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992987AbXEBJvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 05:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992988AbXEBJvj
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 05:51:39 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:59557 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992987AbXEBJvh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2007 05:51:37 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id B4DE7FE228
	for <git@vger.kernel.org>; Wed,  2 May 2007 10:51:35 +0100 (BST)
Received: (qmail 31804 invoked by uid 103); 2 May 2007 10:50:16 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3190. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.037371 secs); 02 May 2007 09:50:16 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 2 May 2007 10:50:16 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <200705020955.04582.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46009>

On Wed, 2 May 2007, Andy Parkins wrote:

> On Tuesday 2007 May 01, Jakub Narebski wrote:
>
>> In 'Size of data on the server' git has CVS beat hands down: 1.3G vs
>> 8.5G for sources, 591M vs 1.1G for third party. I think it is similar
>> for Subversion. I hope that repository is fully packed: IIRC the Mozilla
>> CVS repository import was about 0.6GB pack file, not 1.3GB.
>
> I'm fairly sure it's not.  If so that would also affect the speed of
> operations wouldn't it?

A fully packed clone of the OOo git repo was indeed 1.3G, and the entrire 
checkout + repo was indeed 8.5G (using git 1.5.1.2).

Took about 46m to clone on a server with decent bandwith, ~5.5m user time, 
~1.5m system.

>
> I also doubt the subversion checkout size - subversion keeps a pristine copy
> of the HEAD file - so a subversion checkout is usually over twice the size of
> the source tree.
>
>> takes 3min (!) according to the benchmark. 13-25sec for commit is also
>> bit long
>
> I wonder if they are measuring the time for the generation of the commit
> message or something?  Or perhaps by using "git-commit -a" is causing a check
> of the whole tree for changed files?
>
>> Comparison / benchmark lacks some crucial info, like what computer was
>> used (CPU, RAM, HDD), what filesystem was used, git version etc. It
>> does have commands used for tests (benchmarks).
>
> I'd also like to see some of the numbers for the other systems, I tried to use
> subversion with the linux kernel once and got fed up waiting for it to do
> anything.  I suspect the reason numbers aren't shown for the others is that
> they haven't finished yet :-)
>
>> Could you confirm (or deny) those results? go-oo.org uses git 1.4.3.4;
>> was there some improvement or bugfix related to the speed of checkout?
>
> Wasn't there a recent change that made repacking after a clone unnecessary?
> That would certainly reduce the checkout size.

Not from the numbers that are quoted it won't, they are fully packed 
sizes.

-- 
Julian

  ---
"Do you have blacks, too?"

George W. Bush
To Brazilian president Fernando Cardoso
November 8, 2001
Washington, D.C.
