From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a simple option parser.
Date: Thu, 4 Oct 2007 17:39:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710041736080.4174@racer.site>
References: <1191447902-27326-1-git-send-email-krh@redhat.com>
 <20071003231145.GF28188@artemis.corp> <1191509878.29379.2.camel@hinata.boston.redhat.com>
 <20071004151532.GB5083@artemis.corp> <20071004163156.GD5083@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 18:40:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdTk6-0004Gn-9D
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 18:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759020AbXJDQj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 12:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758974AbXJDQj4
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 12:39:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:39824 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758384AbXJDQj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 12:39:56 -0400
Received: (qmail invoked by alias); 04 Oct 2007 16:39:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 04 Oct 2007 18:39:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1yU8+gcK1AVMgfwI0LVoZKO5wbjBo4THxXVjpnw
	g1cRy5q7QrTaBZ
X-X-Sender: gene099@racer.site
In-Reply-To: <20071004163156.GD5083@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59982>

Hi,

On Thu, 4 Oct 2007, Pierre Habouzit wrote:

>   Okay, popt seems to be quite complicated, and depends upon gettext

... which makes me vote against popt ...

> (which we may require as per survey results, but right now it seems a
> useless dependency).

Nope.  git-gui got a script doing the job of msgfmt, which was the only 
part of that beast known as gettext anyway.

So we will not require it for git-gui.

And I do not see core git being i18n'ised.  Ever.

Ciao,
Dscho
