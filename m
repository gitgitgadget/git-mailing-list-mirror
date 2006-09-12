From: Chris Wedgwood <cw@f00f.org>
Subject: Re: Start handling references internally as a sorted in-memory list
Date: Mon, 11 Sep 2006 18:09:30 -0700
Message-ID: <20060912010930.GA18639@tuatara.stupidest.org>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org> <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 12 03:09:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMwmN-0006Wv-CM
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 03:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbWILBJc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 21:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWILBJc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 21:09:32 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:29854 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965229AbWILBJc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 21:09:32 -0400
Received: (qmail 17147 invoked from network); 12 Sep 2006 01:09:31 -0000
Received: from unknown (HELO stupidest.org) (cwedgwood@sbcglobal.net@71.202.63.228 with login)
  by smtp109.sbc.mail.mud.yahoo.com with SMTP; 12 Sep 2006 01:09:31 -0000
Received: by tuatara.stupidest.org (Postfix, from userid 10000)
	id 1C9F0180B3F5; Mon, 11 Sep 2006 18:09:30 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26875>

On Mon, Sep 11, 2006 at 04:37:32PM -0700, Linus Torvalds wrote:

> This also adds some very rudimentary support for the notion of packed
> refs.

Neat.  Although git makes some repos nice and small the refs take a
lot of space when people use a lot of them:

3.5M  glibc/glibc-cvs.git/.git/refs/
11M   gcc-git/gcc.git/.git/refs/
