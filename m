From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Maintaining two branches.
Date: Tue, 03 Jun 2008 20:41:45 +0200
Message-ID: <48459069.7090404@dirk.my1.cc>
References: <20080603163431.GA1244@old.davidb.org> <08056802-BBBC-4F1D-A1A6-2F8C381CDA2B@ai.rug.nl> <20080603181731.GB11735@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 20:42:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3bT1-00033I-KX
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 20:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbYFCSlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 14:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbYFCSlt
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 14:41:49 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:52649 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbYFCSls (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 14:41:48 -0400
Received: from [84.176.61.188] (helo=[192.168.2.100])
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1K3bS6-0007w7-W9; Tue, 03 Jun 2008 20:41:47 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080603181731.GB11735@old.davidb.org>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83689>

David Brown schrieb:
> On Tue, Jun 03, 2008 at 08:08:09PM +0200, Pieter de Bie wrote:
>
>> You might do the same workflow that Git has with stable / master / next
>>
>> If there is a new upstream release, merge it into external. If you 
>> have patches you want to show to the outside, apply those patches to 
>> external. Then you can merge external into local. The trick is to 
>> never merge local into external.
>>
>> By going only one way (upstream --> external --> local), you'll never 
>> have to worry about having to separate the different patches. Your 
>> history will be displayed much nicer too.
>
> I guess I didn't explain our dilema very well.  We _have_ to separate the
> different patches, for legal reasons.  Perhaps 'external' isn't a good 
> name
> for the branch, maybe it should be 'other'.  Basically, the 'upstream'
> branch is the real upstream tree.  The 'external' or 'other' branch
> contains patches from outside our company.  We are forbidden from
> redistributing these changes, and will be having our customers get them
> from the same source that we do.  Then our 'local' branch is where we do
> our development.
For my understanding: does your 'other' branch contain only a 3rd party
library that you (or the 3rd party people) did patch for your purpose
and you're not allowed to distribute that patched 3rd party lib? What
about using a git submodule for the 3rd party thing. The submodule
contains the patched library (for your development) and the customer
is then told to supply the genuine library (from the internet) and then
apply your patches to it. Would that help you? Probably I missed
some legal issues here...

     -- Dirk
