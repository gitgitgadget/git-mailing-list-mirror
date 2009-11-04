From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Wed, 4 Nov 2009 01:08:17 -0800 (PST)
Message-ID: <1257325697830-3943894.post@n2.nabble.com>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com> <fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com> <1257295737457-3942366.post@n2.nabble.com> <2e24e5b90911031758t651735f9xe9d078079112cfa6@mail.gmail.com> <1257315478920-3943388.post@n2.nabble.com> <fabb9a1e0911032241u3735fa30heaa195d959879f5a@mail.gmail.com> <20091104072709.GC24263@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 10:08:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5bqu-00065d-PW
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 10:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbZKDJIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 04:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbZKDJIO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 04:08:14 -0500
Received: from kuber.nabble.com ([216.139.236.158]:36077 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbZKDJIM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 04:08:12 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N5bqj-0005Si-R4
	for git@vger.kernel.org; Wed, 04 Nov 2009 01:08:17 -0800
In-Reply-To: <20091104072709.GC24263@coredump.intra.peff.net>
X-Nabble-From: Tim Mazid <timmazid@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132066>




Jeff King wrote:
> 
> On Wed, Nov 04, 2009 at 07:41:28AM +0100, Sverre Rabbelier wrote:
> 
>> On Wed, Nov 4, 2009 at 07:17, Tim Mazid <timmazid@hotmail.com> wrote:
>> > So instead of invoking 'git checkout REMOTE/BRANCH', do 'git checkout
>> -b
>> > BRANCH REMOTE/BRANCH'.
>> 
>> Automagically doing 'git checkout -t remote/branch' when asked to do
>> 'git checkout remote/branch' was suggested earlier on the list and I
>> think there was even a patch that implemented it, not sure what the
>> outcome of the series was. I do remember that Peff was annoyed by it
>> at the GitTogether though so it might be a bad idea.
> 
> It's in 'next' now. And for the record, my complaint about its behavior
> turned out to be partially because I was an idiot. I am still not
> convinced that we won't later regret leaving the stale local branch
> sitting around, or that users won't find it confusing to see:
> 
>   $ git checkout foo
>   Branch foo set up to track remote branch foo from origin.
>   Switched to a new branch 'foo'
> 
>   ... time passes ...
> 
>   $ git checkout foo
>   Switched to branch 'foo'
>   Your branch is behind 'origin/foo' by 1 commit, and can be
> fast-forwarded.
> 

Hm. I actually meant inside gitk, not git itself. As in, when you click
inside gitk and try to checkout a remote, it automatically creates a
tracking branch and checks THAT out instead, whereas command-line git works
the same way.
Does that even make sense? :P
-- 
View this message in context: http://n2.nabble.com/PATCH-gitk-disable-checkout-of-remote-branch-tp3939363p3943894.html
Sent from the git mailing list archive at Nabble.com.
