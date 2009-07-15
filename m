From: Unknown <borg@uu3.net>
Subject: Re: [commit 4ecbc178704] Incosistency?
Date: Wed, 15 Jul 2009 10:32:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0907151028050.10773@cube>
References: <Pine.LNX.4.64.0907142335210.31779@cube>
 <20090714214852.GA2786@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 15 10:32:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQzus-0000wg-Fr
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 10:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbZGOIcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 04:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbZGOIcf
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 04:32:35 -0400
Received: from borg.uu3.net ([87.99.63.19]:33748 "EHLO borg.uu3.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbZGOIcf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 04:32:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by borg.uu3.net (Postfix) with ESMTP
	id BE0ED633F9; Wed, 15 Jul 2009 10:32:32 +0200 (CEST)
X-X-Sender: borg@cube
In-Reply-To: <20090714214852.GA2786@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123294>

On Tue, 14 Jul 2009, Jeff King wrote:
> Hmm. I think I wrote a better commit message than that...
Yes you did :)

> No. Two things you are missing:
>
>  1. "git-add" still goes in exec-dir. It's just not the magic one we do
>     separately (see how we no longer need to use filter-out?).
Right. but git-add now is a link to git. Now we have one more file out 
there.

>  2. check_bindir is actually about looking for dashed-form commands in
>     the $bindir, which would indicate cruft from an older installed
>     version of git. We can't use "git" for this, because that is the
>     command that is _supposed_ to be in $bindir.
Indeed. Thanks for clarification.

Regards,
Borg
