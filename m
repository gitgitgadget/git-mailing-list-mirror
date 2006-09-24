From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Git.pm: Kill Git.xs for now
Date: Sun, 24 Sep 2006 12:50:16 +0200
Message-ID: <20060924105016.GA5732@steel.home>
References: <20060923181849.28753.56984.stgit@machine.or.cz> <7vwt7ta6sh.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 12:50:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRRZP-0007Nw-Eg
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 12:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbWIXKuf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 06:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWIXKuf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 06:50:35 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:22465 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751968AbWIXKue (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 06:50:34 -0400
Received: from fwd29.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1GRRZ6-0003KM-03; Sun, 24 Sep 2006 12:50:28 +0200
Received: from tigra.home (S8Sp2rZH8e-71-Q1kZ1Gv7bypt3SG5XB1yNbn3H0H7GYfBILkEUKwo@[84.160.110.72]) by fwd29.sul.t-online.de
	with esmtp id 1GRRYw-16rNKq0; Sun, 24 Sep 2006 12:50:18 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 42BC7277AF;
	Sun, 24 Sep 2006 12:50:17 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GRRYu-0001Ul-LM; Sun, 24 Sep 2006 12:50:16 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwt7ta6sh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-ID: S8Sp2rZH8e-71-Q1kZ1Gv7bypt3SG5XB1yNbn3H0H7GYfBILkEUKwo
X-TOI-MSGID: 4f17a77c-94cc-43bf-8241-7006683dc933
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27654>

Junio C Hamano, Sun, Sep 24, 2006 12:38:22 +0200:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > This patch removes Git.xs from the repository for the time being. This
> > should hopefully enable Git.pm to finally make its way to master.
> 
> It's a bit sad, but I think this is a sane thing to do.
> 
> I suspect Alex still has problem with Makefile.PL due to issues
> around ActiveState (slash vs bs and CRLF line ending if I recall
> correctly)?
> 

Absolutely.
