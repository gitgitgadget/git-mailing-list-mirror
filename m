From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git-filter-branch could be confused by similar names
Date: Sun, 30 Dec 2007 21:40:56 +0300
Message-ID: <20071230184056.GZ13968@dpotapov.dyndns.org>
References: <1198593316-7712-1-git-send-email-dpotapov@gmail.com> <Pine.LNX.4.64.0712292334080.14355@wbgn129.biozentrum.uni-wuerzburg.de> <20071230103146.GU13968@dpotapov.dyndns.org> <Pine.LNX.4.64.0712301145360.14355@wbgn129.biozentrum.uni-wuerzburg.de> <20071230135428.GW13968@dpotapov.dyndns.org> <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 19:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J936E-000309-2H
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 19:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbXL3Sk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 13:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbXL3Sk7
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 13:40:59 -0500
Received: from smtp01.mtu.ru ([62.5.255.48]:58916 "EHLO smtp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbXL3Sk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 13:40:58 -0500
Received: from smtp01.mtu.ru (localhost [127.0.0.1])
	by smtp01.mtu.ru (Postfix) with ESMTP id 6EF39ADD3E6;
	Sun, 30 Dec 2007 21:40:51 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-14.pppoe.mtu-net.ru [85.141.191.14])
	by smtp01.mtu.ru (Postfix) with ESMTP id 1CE92ADD33F;
	Sun, 30 Dec 2007 21:40:51 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1J935k-0008DO-CS; Sun, 30 Dec 2007 21:40:56 +0300
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp01.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69373>

On Sun, Dec 30, 2007 at 05:03:32PM +0100, Johannes Schindelin wrote:
> 
> On Sun, 30 Dec 2007, Dmitry Potapov wrote:
> 
> > How about this:
> > 
> > +			grep '^refs/\([^/]\+/\)\?'"$ref"'$')"
> 
> Maybe.  I wonder whether just adding a "$" (which I obviously forgot) 
> would not be enough...

Adding '$' will certainly make things much better, but you will still
have the same problem if you want to filter "master", but you have
"origin/master" in your repo.

Dmitry
