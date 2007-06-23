From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] t9500: skip gitweb tests if perl version is too old
Date: Sat, 23 Jun 2007 12:51:19 +0200
Message-ID: <20070623105118.GY955MdfPADPa@greensroom.kotnet.org>
References: <20070622154908.GA7946MdfPADPa@greensroom.kotnet.org>
 <7vps3n89mb.fsf@assigned-by-dhcp.pobox.com>
 <20070623085751.GX955MdfPADPa@greensroom.kotnet.org>
 <7vps3n3rm7.fsf@assigned-by-dhcp.pobox.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 12:51:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I23D8-00031A-Tw
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 12:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbXFWKvV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 06:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbXFWKvV
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 06:51:21 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:56690 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472AbXFWKvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 06:51:21 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JK300KJV4TJXN@psmtp09.wxs.nl> for git@vger.kernel.org; Sat,
 23 Jun 2007 12:51:19 +0200 (MEST)
Received: (qmail 14889 invoked by uid 500); Sat, 23 Jun 2007 10:51:19 +0000
In-reply-to: <7vps3n3rm7.fsf@assigned-by-dhcp.pobox.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50728>

On Sat, Jun 23, 2007 at 03:14:08AM -0700, Junio C Hamano wrote:
> Well, "Encode::FB_CLUCK" is a bogus symbol even in recent Perl.
> IOW, the tested function does not seem to care if I give
> whatever garbage as the second parameter.
> 
> But I guess you are only interested if the perl used to run
> gitweb barfs with that two parameter, so the original check
> would be the right way.

Indeed.  gitweb doesn't use FB_CLUCK and if it did, we would
want to know about it (and not skip the tests).

skimo
