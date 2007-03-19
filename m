From: Petr Baudis <pasky@suse.cz>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 02:21:11 +0100
Message-ID: <20070319012111.GS18276@pasky.or.cz>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org> <7vps79wueu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de> <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070318140816.GG4489@pasky.or.cz> <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 19 02:21:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT6Yy-0003b4-Rh
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 02:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbXCSBVO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 21:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbXCSBVO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 21:21:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50623 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbXCSBVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 21:21:14 -0400
Received: (qmail 10769 invoked by uid 2001); 19 Mar 2007 02:21:11 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42554>

  Hi,

On Mon, Mar 19, 2007 at 12:48:27AM CET, Johannes Schindelin wrote:
> On Sun, 18 Mar 2007, Petr Baudis wrote:
> 
> > [...] if you look at the UNIX history, you'll notice that first people 
> > started with non-reentrant stuff because it was "good enough" and then 
> > came back later and added reentrant versions anyway. Let's learn from 
> > history. It's question of probability but it's very likely this will 
> > happen to us as well.
> 
> Yes, let's learn from history. Start with a libgit that is good enough. 
> And when somebody actually needs it to behave a little differently, or 
> more sophisticated, then let that somebody work on it!

  I was talking about the API. The API has to be designed to be
reentrant. And you get pretty much stuck with the API. And requiring
reentrance isn't that far off once libgit is there, as I tried to point
out; it's not really any obscure requirement.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
