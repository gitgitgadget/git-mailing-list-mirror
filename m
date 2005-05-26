From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Summary of core GIT while you are away.
Date: Fri, 27 May 2005 01:29:53 +0200
Message-ID: <20050526232953.GA6215@vrfy.org>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org> <20050526004411.GA12360@vrfy.org> <Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org> <20050526202712.GA6024@vrfy.org> <7vd5rdbtif.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 01:29:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbRlk-0007Cm-6J
	for gcvg-git@gmane.org; Fri, 27 May 2005 01:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVEZX37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 19:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVEZX37
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 19:29:59 -0400
Received: from soundwarez.org ([217.160.171.123]:32718 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261657AbVEZX35 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 19:29:57 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 04FE13A3C8; Fri, 27 May 2005 01:29:54 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5rdbtif.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2005 at 01:51:36PM -0700, Junio C Hamano wrote:
> >>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:
> 
> KS> Before someone asks: kernel.org needs to wait until cogito has catched up and
> KS> released a new version and it is installed on the machines.
> 
> Just from curiosity, does anybody runs (need to run) Cogito on
> kernel.org machine(s)?  Or is it that gitweb depends on Cogito,
> not running directly on top of Plumbing?

The cgi doesn't need it. Cogito has the spec file and the Mekefile
with support for it - that was the reason the RPM made it on the machines
there.
Splitting the git-core stuff completely out of Cogito and install
Cogito with a dependency on the git package is the only sane option I
think.

Kay
