From: Johan Herland <johan@herland.net>
Subject: Re: [CGit RFC/PATCH 0/5] Commit graph on CGit's 'log' view
Date: Wed, 14 Jul 2010 07:59:01 +0200
Message-ID: <201007140759.02822.johan@herland.net>
References: <1279056219-27096-1-git-send-email-johan@herland.net>
 <1279057221-28036-1-git-send-email-johan@herland.net>
 <AANLkTilWENrG8wf1P4EMlzLSj0CdG9s3M8WAwmAZTYUX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 07:59:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYuzx-0003lO-O3
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 07:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab0GNF7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 01:59:08 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52874 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab0GNF7H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 01:59:07 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5J009CJ9YGBY40@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 14 Jul 2010 07:59:04 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 2BF001EEF394_C3D5228B	for <git@vger.kernel.org>; Wed,
 14 Jul 2010 05:59:04 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E45FD1EEC17E_C3D5227F	for <git@vger.kernel.org>; Wed,
 14 Jul 2010 05:59:03 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5J00KUU9YF0W10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 14 Jul 2010 07:59:03 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <AANLkTilWENrG8wf1P4EMlzLSj0CdG9s3M8WAwmAZTYUX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150966>

On Wednesday 14 July 2010, Lars Hjemli wrote:
> On Tue, Jul 13, 2010 at 23:40, Johan Herland <johan@herland.net> wrote:
> > Here are some patches to implement an ASCII-art commit graph on CGit's
> > 'log' page. The patches reuse the graph-drawing code from Git's own
> > 'git log --graph'. As such, these patches depend on the two patches
> > I just submitted to the Git list for extending the graph.h API.
> 
> Thanks. I've applied the git patches to the jh/graph branch in
> git://hjemli.net/pub/git/git (based on v1.7.1-rc2) and updated the
> submodule in cgit to point at the tip of this branch. The cgit patches
> are then applied on top of this and merged into the wip branch in
> git://hjemli.net/pub/git/cgit.

Thanks.

> The end result can be seen in action at http://hjemli.net/git/cgit/log
> [1] - it works, but I'll have to think about possible compromises
> between correctness and performance (i.e. the dependency on
> --topo-order).

Yes, this feature definitely introduces a performance tradeoff. IMHO it's up 
to the server admin to choose whether to enable this in the config or not. 
If you're serving large repos from a small server, you might simply want to 
turn it off.

We might also want to consider adding a query (and cookie?) flag enabling 
visitors to turn off graphs for faster browsing as well.

BTW, have you had time to look at my previous patch series for ignoring 
whitespace in diffs?


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
