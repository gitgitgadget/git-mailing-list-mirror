From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Making CFLAGS compilant with GNU Coding Standards
Date: Mon, 8 Aug 2005 19:10:36 -0400
Message-ID: <20050808231036.GA22778@mythryan2.michonline.com>
References: <1123306575.7588.17.camel@dv.roinet.com> <7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 01:13:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Gls-0006CP-TW
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 01:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVHHXKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 19:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHHXKl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 19:10:41 -0400
Received: from mail.autoweb.net ([198.172.237.26]:59601 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932345AbVHHXKk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 19:10:40 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E2GlR-0006I0-Gm; Mon, 08 Aug 2005 19:10:37 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E2GlQ-0001j8-00; Mon, 08 Aug 2005 19:10:36 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E2GlQ-0004YZ-DQ; Mon, 08 Aug 2005 19:10:36 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 08, 2005 at 01:53:24PM -0700, Junio C Hamano wrote:
> I do want to revisit Makefile issues after 0.99.4, along with
> the changes Pasky sent several days ago.  Please remind me about
> them after Wednesday.

We should discuss (or just do) a reorganization of how we lay out the
source tree.

There's probably a few too many files in the top directory, from all the
porcelain we've built on the plumbing. (heh)

I haven't really given a lot of thought to this yet, but I was thinking
of something along these lines:

Rename tools/ to mail-tools/, push git-send-email-script into that.
Create a "porcelain" directory for things like git-bisect-script
Create a "core" directory for things like "git-commit-script"
Create a "src" (?) directory for *.[ch]
Maybe move documentation into the same directory as the scripts they
belong to.

Then we can argue over where the leftover things fall.

If we can get the directory structure to make sense and start putting
new things into the right spots, the exact location of where *current*
things end up is probably not so important.

I consider this post 1.0 material, personally.

-- 

Ryan Anderson
  sometimes Pug Majere
