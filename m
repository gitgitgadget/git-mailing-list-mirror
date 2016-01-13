From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: loosen config globs limitations
Date: Wed, 13 Jan 2016 19:26:03 +0000
Message-ID: <20160113192603.GA3638@dcvr.yhbt.net>
References: <1452522358-16943-1-git-send-email-vleschuk@accesssoftek.com>
 <20160113031601.GA28224@dcvr.yhbt.net>
 <xmqqlh7tnwre.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Victor Leschuk <vleschuk@gmail.com>, git@vger.kernel.org,
	vleschuk@accesssoftek.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:26:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJR3d-0004IW-D6
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 20:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbcAMT0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 14:26:08 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48279 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbcAMT0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 14:26:07 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 763BA1FD21;
	Wed, 13 Jan 2016 19:26:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqlh7tnwre.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283974>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > I also noticed the "Only one set of wildcard directories" error
> > message is unnecessary long and "wildcard directories" should
> > probably be shortened to "wildcards" to avoid wrapping in a terminal.
> > That will probably be a separate patch for me.
> 
> Should I pull something from you now from 'master' at your
> bogomips.org repository?  I do not mind (and actually I would
> prefer) waiting until I hear a go ahead, which would let you work on
> your own changes before I pull.

Yes, please wait.  I'll fix the long messages later today.  Thanks
