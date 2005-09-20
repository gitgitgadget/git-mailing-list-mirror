From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Garbage in .git directories???
Date: Mon, 19 Sep 2005 22:37:32 -0500
Message-ID: <200509192237.33042.dtor_core@ameritech.net>
References: <200509172141.31591.dtor_core@ameritech.net> <200509191909.22026.dtor_core@ameritech.net> <Pine.LNX.4.58.0509191744550.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 05:38:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHYwt-0002XJ-Re
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 05:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVITDhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 23:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVITDhh
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 23:37:37 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:24985 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964863AbVITDhh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 23:37:37 -0400
Received: (qmail 52822 invoked from network); 20 Sep 2005 03:37:35 -0000
Received: from unknown (HELO mail.corenet.homeip.net) (dtor?core@ameritech.net@69.219.239.52 with login)
  by smtp104.sbc.mail.re2.yahoo.com with SMTP; 20 Sep 2005 03:37:35 -0000
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.58.0509191744550.2553@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8966>

On Monday 19 September 2005 19:45, Linus Torvalds wrote:
> 
> On Mon, 19 Sep 2005, Dmitry Torokhov wrote:
> >
> > Yes, plain git-init-db produces the garbage.
> 
> Hmm. It doesn't do it for me, but I suspect it will be obvious where it
> happens if you send us the output from "strace git-init-db"
> 

Peter's fix for copy_templates() fixes the problem for me.

-- 
Dmitry
