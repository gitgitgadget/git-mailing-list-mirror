From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Allow fetch-pack to decide keeping the fetched pack
 without exploding
Date: Tue, 23 Jan 2007 11:32:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 11:33:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Ixp-00053L-B6
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 11:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939AbXAWKc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 05:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbXAWKc6
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 05:32:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:54539 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932939AbXAWKc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 05:32:56 -0500
Received: (qmail invoked by alias); 23 Jan 2007 10:32:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 23 Jan 2007 11:32:55 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37494>

Hi,

On Mon, 22 Jan 2007, Junio C Hamano wrote:

> With --keep-auto option, fetch-pack decides to keep the pack without 
> exploding it just like receive-pack does.

I like both patches. (Did not have time to test yet, but from looking at 
the patches, it seems indeed to be mostly code moves.)

> We may want to later make this the default.

You have my vote for sooner rather than later.

Ciao,
Dscho

P.S.: These patches make me dream of yet another diff format enhancement: 
code moves! Of course, for this to be really usable, you'd also have to 
automatically determine indent changes... You may say I'm a dreamer. But 
I'm not the only one...
