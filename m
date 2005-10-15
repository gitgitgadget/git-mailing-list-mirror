From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: Sat, 15 Oct 2005 14:56:48 -0700
Message-ID: <20051015215648.GC5509@reactrix.com>
References: <867jciz18w.fsf@blue.stonehenge.com> <864q7kqsa4.fsf@blue.stonehenge.com> <7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net> <86achcoyvz.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0510141543030.23242@iabervon.org> <863bn3lypn.fsf@blue.stonehenge.com> <7vd5m6py11.fsf@assigned-by-dhcp.cox.net> <7v1x2mpx6m.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510151502290.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 23:58:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQu1i-0000dD-QL
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 23:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVJOV5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 17:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVJOV5K
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 17:57:10 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:48765 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751228AbVJOV5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 17:57:09 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9FLunKd013375;
	Sat, 15 Oct 2005 14:56:49 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9FLumdm013373;
	Sat, 15 Oct 2005 14:56:48 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510151502290.23242@iabervon.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10148>

On Sat, Oct 15, 2005 at 03:41:35PM -0400, Daniel Barkalow wrote:

> > BTW, I do not think this is related to git.git repository
> > problem, but I wonder why we do not do fetch_object() against
> > each altbase in http-fetch.c::fetch(); nobody said you cannot
> > borrow unpacked object from your neighbour.
> 
> I believe the code is doing that, but elsewhere.

Er, never mind what I said in my previous message.  Daniel is correct,
process_curl_messages() will try the next altbase if a request 404s.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
