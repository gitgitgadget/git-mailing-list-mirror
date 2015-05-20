From: Faheem Mitha <faheem@faheem.info>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 23:28:15 +0530 (IST)
Message-ID: <alpine.DEB.2.11.1505202256330.9343@orwell.homelinux.org>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org> <vpq382rkvzf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 20 19:58:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv8GG-00053S-7B
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 19:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbbETR62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 13:58:28 -0400
Received: from rs145.luxsci.com ([64.49.212.113]:49935 "EHLO rs145.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbbETR60 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 13:58:26 -0400
Received: from orwell.homelinux.org (triband-mum-59.183.37.231.mtnl.net.in [59.183.37.231])
	(authenticated bits=0)
	by rs145.luxsci.com (8.14.4/8.14.9) with ESMTP id t4KHwMj8022830
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 20 May 2015 13:58:25 -0400
Received: from faheem (helo=localhost)
	by orwell.homelinux.org with local-esmtp (Exim 4.84)
	(envelope-from <faheem@faheem.info>)
	id 1Yv8G4-0000Pg-T8; Wed, 20 May 2015 23:28:20 +0530
X-X-Sender: faheem@orwell.homelinux.org
In-Reply-To: <vpq382rkvzf.fsf@anie.imag.fr>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-Lux-Comment: Message t4KHwMj8022830 sent by user #87163
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269483>


On Wed, 20 May 2015, Matthieu Moy wrote:

> Faheem Mitha <faheem@faheem.info> writes:

>> Hi,

>> Clone the repos https://github.com/fmitha/SICL.

>> Then

>>     git show 280c12ab49223c64c6f914944287a7d049cf4dd0

>> gives

>>     fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4dd0

> It seems 280c12ab49223c64c6f914944287a7d049cf4dd0 is not an object in
> your repository. The good news it: I don't think you have a corrupt
> repository. What makes you think you have an object with identifier
> 280c12ab49223c64c6f914944287a7d049cf4dd0?

I was going by the answer (by CodeWizard) in 
http://stackoverflow.com/q/30348615/350713

The question there also gives the context of this question.

The repos I referenced in my post to the git mailing list just now, is 
just a clone of https://github.com/drmeister/SICL.

If I just give a random hash to `git show` in that repos, I get

     fatal: ambiguous argument '...': unknown revision or path not in the working tree.

It seemed reasonable to assume (based on what little knowledge I had 
about) that the 280c12ab49223c64c6f914944287a7d049cf4dd0 commit was the 
problem.

However, this repos is a fork of another repos, namely 
https://github.com/robert-strandh/SICL

That repos contains more recent commits than the fork does.

If I take any of the more recent commits from that repos, and try the hash 
with `git show`, i.e.

     git show <hash>

in the fork, I get the same error, which makes to me think something else 
must be going on.

Chris (drmeister) has modified the path the submodule is obtained from, so 
the instructions in the SO question won't work as a reproduction recipe 
any more, but if you want to take a look I could clone his repos and set 
it up the same way it was. Let me know.

                                                     Regards, Faheem Mitha
