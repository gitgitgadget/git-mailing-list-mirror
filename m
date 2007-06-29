From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] git-clone: fetch possibly detached HEAD over dumb http
Date: Fri, 29 Jun 2007 10:11:00 +0200
Message-ID: <20070629081100.GA7969MdfPADPa@greensroom.kotnet.org>
References: <20070628105208.GA11105@liacs.nl>
 <7vsl8bmxv9.fsf@assigned-by-dhcp.pobox.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Louis-Noel Pouchet <louis-noel.pouchet@inria.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 10:11:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4BZW-00022p-Vp
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 10:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbXF2ILF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 04:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbXF2ILF
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 04:11:05 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:37980 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbXF2ILC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 04:11:02 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JKE00E1H1ECQU@psmtp09.wxs.nl> for git@vger.kernel.org; Fri,
 29 Jun 2007 10:11:01 +0200 (MEST)
Received: (qmail 11655 invoked by uid 500); Fri, 29 Jun 2007 08:11:00 +0000
In-reply-to: <7vsl8bmxv9.fsf@assigned-by-dhcp.pobox.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51161>

On Thu, Jun 28, 2007 at 05:02:18PM -0700, Junio C Hamano wrote:
> You would want to do this extra fetch only in case (1).
> I think the additional fetch would fail in case (2), and result
> in removal of $GIT_DIR/REMOTE_HEAD.

You're right.  It looks like I only tested it on symbolic link HEADs.
Sorry about that.  Will send a corrected patch later.

skimo
