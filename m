From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/4] Make tag names (i.e. the tag object's "tag" line)
 optional
Date: Mon, 11 Jun 2007 01:01:08 +0200
Message-ID: <200706110101.08664.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706101349.33280.johan@herland.net>
 <7vps435sy0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:01:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxWPP-0001GC-5S
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759215AbXFJXBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760205AbXFJXBM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:01:12 -0400
Received: from smtp.getmail.no ([84.208.20.33]:59663 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759215AbXFJXBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 19:01:11 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00803ZXYQN00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Jun 2007 01:01:10 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00EUJZXXKR30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Jun 2007 01:01:09 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00CH6ZXWGP80@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Jun 2007 01:01:09 +0200 (CEST)
In-reply-to: <7vps435sy0.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49785>

On Monday 11 June 2007, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> 
> > The tag line is now optional. If not given in the tag object data, it
> > defaults to the empty string ("") in the parsed tag object.
> 
> Sorry, I may have missed the discussion.  I recall that we
> talked about tagger line which may not exist for historical
> reasons, but have we heard any reasoning behind this?

In the discussion that followed the first proof-of-concept of 'notes',
I argued that the "tag" header is _really_ only needed for
signed tag objects (although we want it for annotated tags as well),
and that it doesn't make sense to specify a tag name for unnamed 'note'
objects.

If the "tag" line remains mandatory, I'll have to construct an
artificial name for unnamed 'notes'...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
