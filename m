From: Steve =?ISO-8859-1?Q?Fr=E9cinaux?= <nudrema@gmail.com>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 10:46:56 +0100
Message-ID: <1174297616.5884.42.camel@mejai>
References: <20070316042406.7e750ed0@home.brethil>
	 <20070316060033.GD31606@spearce.org>
	 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
	 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070318140816.GG4489@pasky.or.cz>
	 <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070319012111.GS18276@pasky.or.cz>
	 <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550703190001k761541c7v2c259ef3f7695b10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 10:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTESE-0003OZ-I1
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 10:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbXCSJrA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 05:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbXCSJq7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 05:46:59 -0400
Received: from serv108.segi.ulg.ac.be ([139.165.32.111]:59197 "EHLO
	serv108.segi.ulg.ac.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbXCSJq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 05:46:59 -0400
Received: (qmail 23457 invoked by uid 510); 19 Mar 2007 10:46:56 +0100
Received: from 83.182.28.64 by serv108.segi.ulg.ac.be (envelope-from <nudrema@gmail.com>, uid 501) with qmail-scanner-1.25 
 (clamdscan: 0.90/2867.  
 Clear:RC:1(83.182.28.64):. 
 Processed in 0.015643 secs); 19 Mar 2007 09:46:56 -0000
Received: from unknown (HELO [10.0.0.14]) (s020908@[83.182.28.64])
          (envelope-sender <nudrema@gmail.com>)
          by serv108.segi.ulg.ac.be (qmail-ldap-1.03) with SMTP
          for <mcostalba@gmail.com>; 19 Mar 2007 10:46:56 +0100
In-Reply-To: <e5bfff550703190001k761541c7v2c259ef3f7695b10@mail.gmail.com>
X-Mailer: Evolution 2.10.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42602>

On Mon, 2007-03-19 at 08:01 +0100, Marco Costalba wrote:

> I' have tried to do the list myself, but I found only viewers ;-)
> among _currently_ tools I know of, and all the viewers allow loading
> in background _now_ so will not be portable to libgit without main
> surgery, read multi-thread (BTW none is currently multi-thread).

I thought about configuration tools (gconf, kconfig, etc), that could
then implement something similar to what the recovery system of WinXP
does: they could store an history of the configuration state, and then
recover a previous state if things go wrong. This would be incredibly
useful for system administrators.

Also, more generally, git can be used as a versioned storage system
without direct link to source control. I'm thinking about ikiwiki for
instance.

More SCM-oriented, a cron script that manages a website by checkouting
several repositories (one for the wiki module, another for the blog
module, another for the forum, etc) using, say, the python bindi

There are probably a zillion other possible uses. The common thing when
exposing an API is that it ends up being used in a way nobody had
thought of. So it's dangerous to say "it's useless" or "nobody will do
it". You can be sure someone will, it's just a matter of time.
