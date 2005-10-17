From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Some curl versions lack curl_easy_duphandle()
Date: Mon, 17 Oct 2005 11:01:30 -0700
Message-ID: <20051017180130.GJ5509@reactrix.com>
References: <Pine.LNX.4.63.0510150038550.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vmzlbpbwu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510151348080.12307@wbgn013.biozentrum.uni-wuerzburg.de> <20051016215018.GG5509@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 20:02:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERZJA-0001A3-6a
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 20:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVJQSBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 14:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVJQSBs
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 14:01:48 -0400
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:4471 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751321AbVJQSBr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 14:01:47 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9HI1UpI004539;
	Mon, 17 Oct 2005 11:01:30 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9HI1UE6004537;
	Mon, 17 Oct 2005 11:01:30 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20051016215018.GG5509@reactrix.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10187>

On Sun, Oct 16, 2005 at 02:50:18PM -0700, Nick Hengeveld wrote:

> Is that the correct version number?  I've been using 7.10.6 and 
> curl_easy_duphandle() has been working fine.

Apart from the version number question, this patch looks good.  Although
I'm now wondering whether it makes sense to bother trying to use
curl_easy_duphandle() at all and always use get_curl_handle() instead.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
