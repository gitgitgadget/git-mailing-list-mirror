From: Vineet Kumar <vineet@doorstop.net>
Subject: Re: git-daemon in IPv4 and IPv6 mode
Date: Sun, 1 Nov 2009 21:11:26 +0000 (UTC)
Message-ID: <loom.20091101T220400-570@post.gmane.org>
References: <4AEB5640.1010708@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 22:15:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4hlY-0006OA-Aa
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 22:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbZKAVPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 16:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbZKAVPA
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 16:15:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:49453 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480AbZKAVPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 16:15:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N4hlP-0006KD-UL
	for git@vger.kernel.org; Sun, 01 Nov 2009 22:15:04 +0100
Received: from cpe-98-14-195-36.nyc.res.rr.com ([98.14.195.36])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 22:15:03 +0100
Received: from vineet by cpe-98-14-195-36.nyc.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 22:15:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 98.14.195.36 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/532.3 (KHTML, like Gecko) Chrome/4.0.223.11 Safari/532.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131880>

* Sebastian Pipping <webmaster <at> hartwork.org> writes:
> it seems like the git daemon cannot bind to both IPv4 and IPv6 at the
> same time, yet.

It doesn't seem that way here.  I just tried to run a git-daemon and
it listened by default on 0.0.0.0:9418 (v4) and :::9418 (v6).  I could
connect using either v4 or v6.  Is yours behaving differently?

Have a look at the output from "strace -ebind,socket,listen ./git-daemon".

Vineet
