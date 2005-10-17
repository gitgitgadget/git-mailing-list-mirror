From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Mon, 17 Oct 2005 10:41:23 -0700
Message-ID: <20051017174123.GI5509@reactrix.com>
References: <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org> <435264B1.2010204@de.bosch.com> <Pine.LNX.4.63.0510161122570.23242@iabervon.org> <20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org> <7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net> <20051016213341.GF5509@reactrix.com> <7vwtkd6rik.fsf@assigned-by-dhcp.cox.net> <20051017060659.GH5509@reactrix.com> <7voe5o366d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 19:43:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERYzY-0003V8-7x
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 19:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbVJQRli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 13:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVJQRli
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 13:41:38 -0400
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:40049 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750923AbVJQRli (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 13:41:38 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9HHfNV3004126;
	Mon, 17 Oct 2005 10:41:23 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9HHfNnR004122;
	Mon, 17 Oct 2005 10:41:23 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voe5o366d.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10186>

On Mon, Oct 17, 2005 at 01:21:14AM -0700, Junio C Hamano wrote:

> The assumption, which is the property the suggested packing
> strategy has, is that older objects that are needed to complete
> the history leading to the current tip are packed in those
> n-month/n-week packs, so if we do not have them we would likely
> be needing them, although we might not have walked that far back
> in history yet.

Gotcha - I'm still thinking in terms of content distribution, where
you only need a specific version of a tree to be available locally
and explicitly don't want to transfer history.  In our case, using
packs doesn't make sense at the moment.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
