X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: git pull and merging.
Date: Wed, 6 Dec 2006 11:00:01 +0100
Message-ID: <slrnend551.arq.Peter.B.Baumann@xp.machine.xx>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net> <cc723f590612052121u1f6e3c9lc7329f40ee1c9e5a@mail.gmail.com> <Pine.LNX.4.63.0612061019350.28348@wbgn013.biozentrum.uni-wuerzburg.de>
NNTP-Posting-Date: Wed, 6 Dec 2006 10:00:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33416>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grta5-0007vI-7p for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760414AbWLFKAk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760415AbWLFKAk
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:00:40 -0500
Received: from main.gmane.org ([80.91.229.2]:56736 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760413AbWLFKAj
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 05:00:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrtZi-0000hq-DN for git@vger.kernel.org; Wed, 06 Dec 2006 11:00:29 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 11:00:26 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 06 Dec 2006 11:00:26 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 2006-12-06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> You can have the same effect as what Junio wrote with the config:
>
> $ git repo-config remote.origin.url git://git.kernel.org/pub/scm/git/git.git
> $ git repo-config remote.origin.fetch \
> 	refs/heads/master:refs/remotes/origin/master
> $ git repo-config remote.origin.fetch \
> 	refs/heads/next:refs/remotes/origin/next ^$
> $ git repo-config remote.origin.fetch \
> 	+refs/heads/pu:refs/remotes/origin/pu ^$
>

What's that ^$ for?

-Peter
