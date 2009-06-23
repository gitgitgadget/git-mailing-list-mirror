From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: push.default???
Date: Tue, 23 Jun 2009 15:57:55 +0200
Message-ID: <20090623135755.GA24974@pvv.org>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org> <4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org> <4A40D6C2.2060700@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jun 23 15:58:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ6W0-0006ax-TI
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 15:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111AbZFWN5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 09:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756912AbZFWN5y
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 09:57:54 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:48004 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbZFWN5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 09:57:53 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1MJ6VX-0007bG-Bc; Tue, 23 Jun 2009 15:57:55 +0200
Content-Disposition: inline
In-Reply-To: <4A40D6C2.2060700@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122090>

On Tue, Jun 23, 2009 at 03:21:06PM +0200, Andreas Ericsson wrote:
> Finn Arne Gangstad wrote:
>> On Tue, Jun 23, 2009 at 02:59:10PM +0200, Paolo Bonzini wrote:
>> [...]
>>> Before going on, can you explain your use case for --push=tracking 
>>> (in a  case where --push=current wouldn't do the same)?
>>
>> The idea with "tracking" is to push the current branch to wherever it
>> would pull from, making push & pull "equivalent" in some sense.
>>
>> This is different from "current" if you have/choose to name the local
>> branch something else than the remote branch. This happens a lot when
>> using multiple remotes.
>>
>> E.g. some remotes have only a single active branch called "master",
>> and you have to name it something else locally, or several people have
>> local branches called "beta", and you have to name it something like
>> "fred-beta" locally if you are working on fred's beta.
>>
>
> Umm. Why not name it after the feature you're working on instead of the
> branch you started from? That way, you get fred/beta (assuming you've
> added Fred's repo as a remote named "fred" ofcourse) and all your
> branches have names that never (in theory) clash with any of your
> upstreams.

Maybe I misunderstand what you are saying, but: The point is that you
can not name it the same as on the remote. So the names are different,
and --current will not work.

- Finn Arne
