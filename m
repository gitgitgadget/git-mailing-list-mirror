From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn vs. $Id$
Date: Tue, 23 May 2006 19:23:39 -0700
Message-ID: <11484374214073-git-send-email-normalperson@yhbt.net>
References: <20060521030330.GA15812@soma>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 04:23:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fij2J-00079h-OB
	for gcvg-git@gmane.org; Wed, 24 May 2006 04:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWEXCXo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 22:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWEXCXo
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 22:23:44 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35716 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932547AbWEXCXo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 22:23:44 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A8FD42DC01A;
	Tue, 23 May 2006 19:23:42 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 23 May 2006 19:23:41 -0700
To: Tommi Virtanen <tv@inoi.fi>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <20060521030330.GA15812@soma>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20659>

Tommi: I'm reasonably confident about this patch, but I won't be
getting much real-world usage since I rarely see repos that use
svn:keywords, and I'm afflicted with RSI which prevents me from
doing very much in front of a computer these days.  So
feedback/testing from you or any other git-svn guine^Wusers
would be greatly appreciated.

Junio: This is probably safe enough for next or even master, the
one in pu is completely broken wrt svn:eol-style.
