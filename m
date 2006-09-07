From: fork0@t-online.de (Alex Riesen)
Subject: Re: file rename causes history to disappear
Date: Thu, 7 Sep 2006 12:16:11 +0200
Message-ID: <20060907101611.GA15981@steel.home>
References: <44FEE0BB.2060601@garzik.org> <Pine.LNX.4.64.0609060834520.27779@g5.osdl.org> <44FEED4B.30909@garzik.org> <Pine.LNX.4.64.0609060858050.27779@g5.osdl.org> <Pine.LNX.4.64.0609060922110.27779@g5.osdl.org> <7vmz9c7pzm.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 12:17:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLGwF-0003uc-8e
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 12:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWIGKQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 06:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWIGKQb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 06:16:31 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:14570 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751096AbWIGKQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 06:16:29 -0400
Received: from fwd27.aul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 1GLGvj-0003ct-02; Thu, 07 Sep 2006 12:16:19 +0200
Received: from tigra.home (Vaedg0ZVQeYGBkQPVAbF0VCXLcUzOxqpyya4fN3R5JHsvXuez9jzQW@[84.160.126.71]) by fwd27.sul.t-online.de
	with esmtp id 1GLGvc-08tL3g0; Thu, 7 Sep 2006 12:16:12 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8CF53277AF;
	Thu,  7 Sep 2006 12:16:11 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GLGvb-0004Ah-EC; Thu, 07 Sep 2006 12:16:11 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmz9c7pzm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-ID: Vaedg0ZVQeYGBkQPVAbF0VCXLcUzOxqpyya4fN3R5JHsvXuez9jzQW
X-TOI-MSGID: 97d6cbc9-312a-4915-a4b9-b982ad0fdabd
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26625>

Junio C Hamano, Wed, Sep 06, 2006 21:29:49 +0200:
> The only people who will get burnt by this change are the ones
> with metacharacters in their pathnames, so it is relative safe
> change.

May be make metacharacters the default behaviour, but provide a
command-line option to disable it? It'll be seldom used, but would
provide a way to disambiguate input for scripts and make possible
(even if a bit harder) to use such filenames.
