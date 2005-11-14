From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Bugfix: stop if directory already exists
Date: Mon, 14 Nov 2005 10:29:18 +0100
Message-ID: <200511141029.18256.Josef.Weidendorfer@gmx.de>
References: <200511131503.32078.Josef.Weidendorfer@gmx.de> <7vpsp3zjwm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 10:31:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbaeT-0001Yj-8k
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 10:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVKNJ3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 04:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVKNJ3X
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 04:29:23 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:36753 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751042AbVKNJ3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 04:29:22 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 43B782780;
	Mon, 14 Nov 2005 10:29:19 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
In-Reply-To: <7vpsp3zjwm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11780>

On Monday 14 November 2005 09:57, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> >  usage: git clone ...
> >  For more details, see 'man git-clone'
> 
> doing too much awk these days").  And "for more details see man"
> goes without saying.

Of course; it was more about the current inconsistency: usage
says "git clone", but for the man page, you have to know that
there is an additional command "git-clone" with extra man page.
Usually, if I see e.g. "usage: cvs diff", I look up the man
page of "cvs" searching for "diff" on it, not "cvs-diff".

So just another suggestion: Why not put most of the
documentation in a huge "git" man page? cvs does this (3601 lines
here), all the shells have huge man pages (bash: 4794).
We would be in a good tradition ;-)

Josef
