From: Raimund Bauer <ray007@gmx.net>
Subject: Re: [PATCH] Fix 'crlf' attribute semantics.
Date: Mon, 16 Apr 2007 08:21:10 +0200
Message-ID: <1176704470.5966.16.camel@localhost>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
	 <200704131033.15751.andyparkins@gmail.com>
	 <7vejmm78qp.fsf@assigned-by-dhcp.cox.net>
	 <7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
	 <7vr6qm5r73.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0704142103210.5473@woody.linux-foundation.org>
	 <7vr6ql1ben.fsf@assigned-by-dhcp.cox.net> <20070415233722.GA20222@hermes>
	 <7vd52519vj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Tom Prince <tom.prince@ualberta.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 08:21:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdKaT-0008R8-VZ
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 08:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbXDPGVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 02:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbXDPGVO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 02:21:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:42121 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752274AbXDPGVO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 02:21:14 -0400
Received: (qmail invoked by alias); 16 Apr 2007 06:21:12 -0000
Received: from p54988CFB.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.152.140.251]
  by mail.gmx.net (mp019) with SMTP; 16 Apr 2007 08:21:12 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX19VTIgqlzlVrNCqbXTT6ofICIwaGHDXjPUsTgWNlv
	QlGH2Q0LcItoDB
In-Reply-To: <7vd52519vj.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44593>

On Sun, 2007-04-15 at 16:44 -0700, Junio C Hamano wrote:

> > This change means there is no way to enable the automatic heuristics for a
> > specific pattern once it has been disable for a more generic pattern. Would it
> > make sense to make the attributes more than simply boolean?
> 
> I do not think that is a problem in practice.  Do not set
> something to "false" explicitly with a generic pattern, if you
> might want to override it.

I also don't think it's a problem, but I think it would generally be a
good idea to have values for attributes. So you can say

crlf=yes|no|auto
diff=yes|no|my-xml-diff|...
merge=3way|...

In the yes/no case we could keep the existing syntax on just add the
attribute=othervalue for those that need more than a boolean decision.

-- 
best regards

  Ray
