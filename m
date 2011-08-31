From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: git-svn and mergeinfo
Date: Wed, 31 Aug 2011 12:55:57 -0400
Organization: White Oak Technologies
Message-ID: <20110831125557.56ccffe2@robyn.woti.com>
References: <20110829132052.0ad7a088@robyn.woti.com>
	<CAGdFq_h+KjWQUwwLdaqA-0j0p1zQznZkNNEVgfS46_o-Zfr3oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 18:56:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyo58-0006OF-Tw
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121Ab1HaQ4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 12:56:00 -0400
Received: from mail02.woti.us ([66.92.158.6]:35694 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932118Ab1HaQz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 12:55:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id 8034C504D37EA;
	Wed, 31 Aug 2011 12:55:58 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Lbp4D1ZS9Ha; Wed, 31 Aug 2011 12:55:58 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 23A3A504D37F0;
	Wed, 31 Aug 2011 12:55:58 -0400 (EDT)
In-Reply-To: <CAGdFq_h+KjWQUwwLdaqA-0j0p1zQznZkNNEVgfS46_o-Zfr3oQ@mail.gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180489>

On Wed, 31 Aug 2011 15:59:26 +0200
Sverre Rabbelier <srabbelier@gmail.com> wrote:

> 
> Why not submit this as a proper patch [0] to the list, I reckon Eric
> (cc-ed, the maintainer of git-svn) wouldn't mind including it.

I have submitted a patch, following your conventions as best I could. I
forgot the CC line, sorry Eric!

There was an inaccurate line in the documentation concerning the
svn:mergeinfo property ("git-svn does not currently make use of this")
which I clobbered with my documentation change. I did not document the
whole of how "git svn fetch" deals with the property, but this should
probably be done at some point.

Side notes: It may also be productive to automatically set mergeinfo
when all parents of a merge commit have git-svn-info annotations, but I
have not done this (as I said earlier, I use scripts external to git
for this task). Finally, I am uncertain why the git-svn-info lines are
stored in commit bodies instead of as notes; a notes-based approach
would not involve commit hashes changing when they are pushed to an
upstream SVN server.

Thanks all,
Bryan Jacobs
