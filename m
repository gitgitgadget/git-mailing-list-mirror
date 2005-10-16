From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Sun, 16 Oct 2005 09:12:44 -0700
Message-ID: <20051016161244.GE5509@reactrix.com>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> <434EABFD.5070604@zytor.com> <434EC07C.30505@pobox.com> <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org> <435264B1.2010204@de.bosch.com> <Pine.LNX.4.63.0510161122570.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 16 18:13:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERB8d-0000z7-Fg
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 18:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVJPQNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 12:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVJPQNL
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 12:13:11 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:42202 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751268AbVJPQNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 12:13:09 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9GGCjOq008244;
	Sun, 16 Oct 2005 09:12:45 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9GGCiW6008242;
	Sun, 16 Oct 2005 09:12:44 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510161122570.23242@iabervon.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10160>

On Sun, Oct 16, 2005 at 11:44:46AM -0400, Daniel Barkalow wrote:

> This is the problem: it's impossible to download only a few objects from a 
> pack file from an HTTP server, because those don't exist on the server as 
> separate files.

Is it possible to determine the object locations inside the remote pack
file?  If so, it would be possible to use Range: headers to download
selected objects from a pack.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
