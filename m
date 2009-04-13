From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn doesn't recognise trunk as parent of branch
Date: Mon, 13 Apr 2009 09:26:01 +0200
Message-ID: <20090413072601.GC25300@m62s10.vlinux.de>
References: <F562B0FA-6E9F-45AD-ADD5-D6EE1AD9C248@orestis.gr> <20090412185440.GA25300@m62s10.vlinux.de> <3110D1F9-B096-4E10-8795-748EF5E38318@orestis.gr> <CDAC8304-EADC-4481-96C9-968DCC4E61A5@orestis.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Orestis Markou <orestis@orestis.gr>
X-From: git-owner@vger.kernel.org Mon Apr 13 09:25:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtGYI-00017f-9L
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 09:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbZDMHWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 03:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbZDMHWK
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 03:22:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:42963 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751000AbZDMHWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 03:22:09 -0400
Received: (qmail invoked by alias); 13 Apr 2009 07:22:06 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp005) with SMTP; 13 Apr 2009 09:22:06 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+OLaJYFU2O3RFGopUdZ2Nh66kLkcCoO1GxT8Ldlm
	SfX4B+GymP/M7a
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id DAA9B1ACD6; Mon, 13 Apr 2009 09:26:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CDAC8304-EADC-4481-96C9-968DCC4E61A5@orestis.gr>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116414>

On Mon, Apr 13, 2009 at 02:58:45AM +0300, Orestis Markou wrote:
> And I also realised that I don't need to rewrite the history itself. I  
> was confused because gitk was caching something and I had to restart it 
> to see the updated info.

The rewrite is done by git filter-branch and this *will* be necessary if you
ever want to clone/push/fetch from/to this heavily grafted repo. Grafts are
only repository local and using filter-branch, you could make them permanent.

-Peter
