From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: gitweb: charset problem
Date: Mon, 24 Oct 2005 17:55:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510241743280.25300@iabervon.org>
References: <200510241356.j9ODuAHn005060@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Gierke <ch@gierke.de>,
	Peter Portmann <peter.portmann@sygroup.ch>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Oct 24 23:57:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUAIb-0003SV-Dp
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 23:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVJXV4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 17:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVJXV4F
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 17:56:05 -0400
Received: from iabervon.org ([66.92.72.58]:10760 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751307AbVJXV4E (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 17:56:04 -0400
Received: (qmail 9117 invoked by uid 1000); 24 Oct 2005 17:55:30 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Oct 2005 17:55:30 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200510241356.j9ODuAHn005060@laptop11.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10563>

On Mon, 24 Oct 2005, Horst von Brand wrote:

> > But we also have another problem: Sometimes we have umlauts in the commit
> > messages.  Those are also displayed incorrectly. When I switch to
> > iso-8859-1 encoding in mozilla, the characters in the username and in the
> > commit message are ok.
> 
> I believe the Emperor Penguin decreed messages have to be ASCII, or else
> UTF-8. Please don't add to the mess by using non-portable encodings!

Should we possibly reject non-UTF-8 input to commits?

IIRC, we actually define that to be UTF-8, unlike most of the other stuff, 
for which we don't actually insist on a policy.

	-Daniel
*This .sig left intentionally blank*
