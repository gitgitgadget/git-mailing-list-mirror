From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Is there a way to control the number of revisions will be	saved
 by git
Date: Wed, 03 Dec 2008 14:04:06 +0100
Message-ID: <493683C6.8060902@gmx.ch>
References: <2f5ea7490812030301p29e944fw5f59943dc352cd09@mail.gmail.com> <1228304226.23167.8.camel@therock.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tzury Bar Yochay <tzury.by@gmail.com>, git@vger.kernel.org
To: Arafangion <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:06:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rQ1-0000cM-9m
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbYLCNEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbYLCNEK
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:04:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:35494 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752417AbYLCNEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:04:09 -0500
Received: (qmail invoked by alias); 03 Dec 2008 13:04:07 -0000
Received: from 242-177.0-85.cust.bluewin.ch (EHLO [192.168.123.204]) [85.0.177.242]
  by mail.gmx.net (mp065) with SMTP; 03 Dec 2008 14:04:07 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1+Ar2E0kneASzv+CDPVa3wFNmQ9uZJLADwwxKIPoH
	8Z5cJIdfZKRbor
User-Agent: Thunderbird 2.0.0.18 (X11/20081123)
In-Reply-To: <1228304226.23167.8.camel@therock.nsw.bigpond.net.au>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102250>

Arafangion wrote:
> On Wed, 2008-12-03 at 13:01 +0200, Tzury Bar Yochay wrote:
> <snip>
>> Say I wish to save only 100 generations back (per branch).
>> Is it possible to configure git so it will save only N records back.
> 
> What would be the advantage in doing that?

That would be a shallow repository, as is already supported by
"git clone --depth 100".  It can be useful for a number of things,
for example developing simple patches on top of HEAD and sending
them somewhere.

What the OP might want is a way to convert a full repository into
a shallow one (can be done by cloning and deleting the original),
and then be able to make it shallower from time to time, to limit
it to 100 revisions; not sure if that is possible.

jlh
