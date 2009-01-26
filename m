From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Hosting from Windows XP.
Date: Mon, 26 Jan 2009 09:38:14 -0800
Message-ID: <20090126173814.GC31810@spearce.org>
References: <c115fd3c0901260827ge5e4b29w871b345da2373f6b@mail.gmail.com> <20090126163124.GA31810@spearce.org> <m3bptux984.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Visher <tim.visher@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 18:40:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRVRD-00007D-Cf
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 18:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbZAZRiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 12:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbZAZRiP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 12:38:15 -0500
Received: from george.spearce.org ([209.20.77.23]:38287 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbZAZRiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 12:38:15 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 98E8E38210; Mon, 26 Jan 2009 17:38:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m3bptux984.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107235>

Jakub Narebski <jnareb@gmail.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > - Use JGit and its daemon
> 
> From what I remember currently JGit daemon generates suboptimal
> packfiles, as it does not support delta compression yet...

Yes.

It does however support delta-reuse, and it only supports the
index-pack variant during receive-pack.  So it saves and reuses
any deltas created by C git.  Which makes it almost tolerable to
work with as a bit server.

-- 
Shawn.
