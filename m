From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] make --color-words separate word on ispunct
Date: Sat, 12 Apr 2008 16:23:32 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804121621560.16366@eeepc-johanness>
References: <1207996421-29651-1-git-send-email-sgala@apache.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Santiago Gala <sgala@apache.org>
To: sgala@hisitech.com
X-From: git-owner@vger.kernel.org Sat Apr 12 17:24:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkhaV-0001GU-If
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 17:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbYDLPXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 11:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbYDLPXe
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 11:23:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:51546 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752204AbYDLPXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 11:23:34 -0400
Received: (qmail invoked by alias); 12 Apr 2008 15:23:32 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO eeepc-johanness.home) [86.165.92.90]
  by mail.gmx.net (mp024) with SMTP; 12 Apr 2008 17:23:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lbWA6YzNlqRMJNG5hYjBdC6yAuXfbQ5M9Jee5yX
	S6dsK7xrsxMbns
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1207996421-29651-1-git-send-email-sgala@apache.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79363>

Hi,

On Sat, 12 Apr 2008, sgala@hisitech.com wrote:

> Note that this may actually be harmful when trying to spot punctuation 
> changes, but for this use case I don't think color-words is helping now 
> either.

I do not know how commonly supported ispunct(), therefore I do not like 
the patch too much.

Besides, since long ago I want to make the list of boundary characters 
configurable, preferably as a tr(1) style list, but I have not come around 
to do that yet.

Ciao,
Dscho
