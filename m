From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Mon, 17 Oct 2005 16:54:23 -0700
Message-ID: <20051017235423.GK5509@reactrix.com>
References: <Pine.LNX.4.63.0510161122570.23242@iabervon.org> <20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org> <7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net> <20051016213341.GF5509@reactrix.com> <7vwtkd6rik.fsf@assigned-by-dhcp.cox.net> <20051017060659.GH5509@reactrix.com> <7voe5o366d.fsf@assigned-by-dhcp.cox.net> <20051017174123.GI5509@reactrix.com> <7v3bmzzz30.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 01:56:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EReof-0001y1-2h
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 01:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVJQXyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 19:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVJQXyc
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 19:54:32 -0400
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:36575 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751415AbVJQXyb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 19:54:31 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9HNsNfP012197;
	Mon, 17 Oct 2005 16:54:23 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9HNsNNu012195;
	Mon, 17 Oct 2005 16:54:23 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bmzzz30.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10199>

On Mon, Oct 17, 2005 at 01:08:03PM -0700, Junio C Hamano wrote:

>  - a way for the user to say "unless I ask explicitly otherwise,
>    do not bother me if the commits older than these ones are
>    incomplete" -- an milder version of cauterizing commit chain
>    via info/grafts.
> 
>  - a way for the user to say "this time I am explicitly
>    overriding the above -- I am interested in older history".
> 
>  - change to fsck-objects, fetch- and probably upload-pack on
>    the other end, and commit walkers to honor the above two.

That's how I interpreted the -c and -a command-line arguments to the
commit walkers.  git-fetch calls them with -a but we've been using -t
to only follow the tree objects and it's been working great.

Perhaps that would be a good way for the commit walker to decide whether
to transfer a full pack file - it may not make sense if it wasn't told
to get history.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
