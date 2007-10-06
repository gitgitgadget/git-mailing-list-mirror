From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
Date: Sat, 06 Oct 2007 10:46:11 +0200
Message-ID: <20071006084611.GE3619MdfPADPa@greensroom.kotnet.org>
References: <1191447902-27326-1-git-send-email-krh@redhat.com>
 <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp>
 <20071005143014.GA18176@glandium.org> <20071005144540.GM19879@artemis.corp>
 <598D5675D34BE349929AF5EDE9B03E2701624FD6@az33exm24.fsl.freescale.net>
 <20071005155647.GC20305@artemis.corp>
 <598D5675D34BE349929AF5EDE9B03E2701624FF2@az33exm24.fsl.freescale.net>
 <86wsu1v8ha.fsf@lola.quinscape.zz> <20071005163846.GE20305@artemis.corp>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Oct 06 10:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ie5Ik-0007VJ-Us
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 10:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbXJFIqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 04:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbXJFIqO
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 04:46:14 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:38445 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbXJFIqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 04:46:13 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JPH002JCF0ZL9@psmtp08.wxs.nl> for git@vger.kernel.org; Sat,
 06 Oct 2007 10:46:12 +0200 (MEST)
Received: (qmail 1706 invoked by uid 500); Sat, 06 Oct 2007 08:46:11 +0000
In-reply-to: <20071005163846.GE20305@artemis.corp>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60142>

On Fri, Oct 05, 2007 at 06:38:46PM +0200, Pierre Habouzit wrote:
>   The real issue is dependency and bloat. getopt_long would need the GNU
> implementation, That I believe depends upon gettext, and argp is just
> bloated, and I'm not even sure it's distributed outside from the glibc
> anyways.

It's part of gnulib (http://savannah.gnu.org/git/?group=gnulib).
Including argp (and all its dependencies) is as easy as running some
gnulib command.
It does have some bloat, but for my project it was definitely more
convenient to include it than to write my own parser and the bloat
is still acceptable I suppose...

bash-3.00$ du lib m4
572     lib
208     m4
bash-3.00$ du -s .
20348   .

(In a source tree without the git repo.)

skimo
