From: Martin Mares <mj@ucw.cz>
Subject: Re: git-feed-mail-list.sh
Date: Wed, 10 May 2006 10:49:07 +0200
Message-ID: <mj+md-20060510.084721.9078.atrey@ucw.cz>
References: <1146678513.20773.45.camel@pmac.infradead.org> <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net> <1147131877.2694.37.camel@shinybook.infradead.org> <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org> <1147134522.2694.45.camel@shinybook.infradead.org> <Pine.LNX.4.64.0605081742330.3718@g5.osdl.org> <1147136467.2694.53.camel@shinybook.infradead.org> <7v64kgc8ik.fsf@assigned-by-dhcp.cox.net> <1147137170.2694.58.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 10:49:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdkNb-0004xe-9G
	for gcvg-git@gmane.org; Wed, 10 May 2006 10:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWEJItH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 04:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWEJItH
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 04:49:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38285 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964860AbWEJItG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 04:49:06 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 1000)
	id 7F0A3C7B31; Wed, 10 May 2006 10:49:07 +0200 (CEST)
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1147137170.2694.58.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19881>

Hello!

> I think I'd best wait for it to turn up in the release; preferably
> already capable of MIME quoting.

Wouldn't it be easier to feed the output to a MUA and letting it handle
the MIME stuff for you?

I am using mutt for this purpose:

mutt -x -e 'set charset="utf-8"; set send_charset="us-ascii:iso-8859-2:utf-8"' -s "$subj" "$recipient" <$out

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Next lecture on time travel will be held on previous Monday.
