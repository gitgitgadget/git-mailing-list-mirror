From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Tue, 3 Nov 2009 22:17:58 -0800 (PST)
Message-ID: <1257315478920-3943388.post@n2.nabble.com>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com> <fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com> <1257295737457-3942366.post@n2.nabble.com> <2e24e5b90911031758t651735f9xe9d078079112cfa6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 07:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ZC0-0003CK-Oo
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 07:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbZKDGRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 01:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbZKDGRy
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 01:17:54 -0500
Received: from kuber.nabble.com ([216.139.236.158]:32771 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbZKDGRx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 01:17:53 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N5ZBu-0002lh-To
	for git@vger.kernel.org; Tue, 03 Nov 2009 22:17:58 -0800
In-Reply-To: <2e24e5b90911031758t651735f9xe9d078079112cfa6@mail.gmail.com>
X-Nabble-From: Tim Mazid <timmazid@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132042>



Sitaram Chamarty wrote:
> 
> On Wed, Nov 4, 2009 at 6:18 AM, Tim Mazid <timmazid@hotmail.com> wrote:
> 
>> Might be better to include a configuration option to allow this, for
>> those
>> that know what they're doing. Most of the people that know what they're
>> doing will use the command line, anyway, but it may irritate some people.
> 
> I considered that but found my tcl fu was seriously lacking.  These
> are literally the first 3 lines of tcl I ever wrote in my life, and
> this program is one huge 11,000+ line monolith, so I'm naturally
> scared to make more than very, very, small changes :)
> 
> In any case, as you said, most people who know what they're doing can
> use the CLI to get there anyway...
> 

Hm, now that I think about it, what might be better is to just do what
should be done for them. :P

So instead of invoking 'git checkout REMOTE/BRANCH', do 'git checkout -b
BRANCH REMOTE/BRANCH'.

I know you said, you don't know, tcl, but just throwing it out there for
anyone else.

Cheers,
Tim.
-- 
View this message in context: http://n2.nabble.com/PATCH-gitk-disable-checkout-of-remote-branch-tp3939363p3943388.html
Sent from the git mailing list archive at Nabble.com.
