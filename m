From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-recursive: do not report the resulting tree object
 name
Date: Sat, 13 Jan 2007 00:36:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701130034000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
 <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
 <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
 <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
 <20070112184839.9431ddff.vsu@altlinux.ru> <7vr6u0t87q.fsf@assigned-by-dhcp.cox.net>
 <7v8xg8t3aj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergey Vlasov <vsu@altlinux.ru>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 13 00:36:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5VwW-0000so-SZ
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 00:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbXALXgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 18:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbXALXgO
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 18:36:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:56260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161170AbXALXgN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 18:36:13 -0500
Received: (qmail invoked by alias); 12 Jan 2007 23:36:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 13 Jan 2007 00:36:11 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xg8t3aj.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36730>

Hi,

I like this patch. merge-recursive is very talkative, to the intimidating 
astonishment of unsuspecting users.

The real information is in the conflict markers now, which tell the user 
where what hunk came from. And the names in the markers are _really_ 
useful now.

Ciao,
Dscho
