X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Olivier Galibert <galibert@pobox.com>
Subject: Re: On removing files and "git-rm is pointless"
Date: Mon, 4 Dec 2006 17:04:29 +0100
Message-ID: <20061204160429.GA8512@dspnet.fr.eu.org>
References: <87odqm2ppv.wl%cworth@cworth.org> <Pine.LNX.4.64.0612020919400.3476@woody.osdl.org> <4571DB40.6020800@vilain.net> <Pine.LNX.4.64.0612022246310.2630@xanadu.home> <7vd570q888.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612040737120.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 16:04:49 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org, Carl Worth <cworth@cworth.org>,
	Sam Vilain <sam@vilain.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612040737120.3476@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33200>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrGJ7-0007wl-VU for gcvg-git@gmane.org; Mon, 04 Dec
 2006 17:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937054AbWLDQEc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 11:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937053AbWLDQEc
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 11:04:32 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3687 "EHLO
 dspnet.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937054AbWLDQEa (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 11:04:30 -0500
Received: by dspnet.fr.eu.org (Postfix, from userid 1007) id CB9A1A376B; Mon,
  4 Dec 2006 17:04:29 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

<pet_peeve>

On Mon, Dec 04, 2006 at 07:42:26AM -0800, Linus Torvalds wrote:
> (And obviously, for all the normal reasons, if the index or HEAD doesn't 
> match, the error message should be helpful and also explicitly mention the 
> "-f" flag. Somehing like
> 
> 	file 'x' does not match HEAD or has been staged for changes.
> 	Will not remove. Use '-f' to force removal.

And you wouldn't tell which, you stupid computer?

I hate when error messages go "there is a problem that may be x, y or
z.  You can figure out which one yourself.".

Incidentally, splitting the message would allow you to add a "use git
diff x" or a "use git diff --cached x to see the differences" message.

</pet_peeve>

