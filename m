From: Sergei Organov <osv@javad.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 20:31:20 +0300
Message-ID: <87prye832v.fsf@osv.gnss.ru>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org>
	<87ve86889o.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0711131600590.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irzgd-0007Pk-39
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 18:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbXKMRgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 12:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755056AbXKMRgL
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 12:36:11 -0500
Received: from javad.com ([216.122.176.236]:1205 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754267AbXKMRgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 12:36:10 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADHVP036431;
	Tue, 13 Nov 2007 17:31:25 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Irzbc-0004Um-2q; Tue, 13 Nov 2007 20:31:20 +0300
In-Reply-To: <Pine.LNX.4.64.0711131600590.4362@racer.site> (Johannes Schindelin's message of "Tue\, 13 Nov 2007 16\:01\:31 +0000 \(GMT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64815>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 13 Nov 2007, Sergei Organov wrote:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > The wildcard refspec is not documented adequately, so I'm not sure if 
>> > adding
>> >
>> >         fetch = !refs/heads/pu
>> >
>> > would help, or do you have to replace wildcard refspec by explicit 
>> > list of branches you want to fetch.
>> 
>> Isn't "git branch -d -r" supposed to do whatever magic is required to
>> get rid of the remote branch?
>
> But it did!  You explicitely fetched it _again_!

Sorry, but *I* didn't *explicitly* fetch it _again_!

1. I cloned git.git repo making no custom steps.

2. I decided I don't need to track some of branches.

3. I tried to find in documentation a way to remove remote tracking
   branch. I found that 'git branch -d -r' should do it.

4. I used 'git branch -d -r origin/pu' to remove one of remote branches,
   -- it succeeded.

5. Some time later I ran 'git fetch', and it's *git fetch* that
   *implicitly* fetched it _again_! When I say *implicitly* I mean that
   I did nothing to tell 'fetch' to re-create the remote branch.

Please try to look at it from the *user* POV. A poor user that has no
idea how all this is implemented internally and tries to use git
documentation to do things.

-- 
Sergei.
