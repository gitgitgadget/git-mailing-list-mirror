From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: working out where git-rebase is up to?
Date: Mon, 22 Feb 2010 11:19:56 +0100
Message-ID: <1266833879-sup-7619@nixos>
References: <2cfc40321002220209pe1942ecucb3716f60bf05d32@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 12:19:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjVOb-0007OY-SW
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 11:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab0BVKUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 05:20:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:46624 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751592Ab0BVKUA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 05:20:00 -0500
Received: (qmail invoked by alias); 22 Feb 2010 10:19:57 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp011) with SMTP; 22 Feb 2010 11:19:57 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX18XfCUpUIwXXHVouZmwW02qgwlCZ7Xv9uAn1nR42S
	GWqvXT4PO9kUq2
Received: by mail.gmx.net (sSMTP sendmail emulation); Mon, 22 Feb 2010 11:19:57 +0100
In-reply-to: <2cfc40321002220209pe1942ecucb3716f60bf05d32@mail.gmail.com>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140660>

> No doubt rebase is tracking this info, but is there a supported way to
> discover it?

I may be mistaken. But git-rebase basically applies patches on top of a
branch. And the branch it's operating on is checked out.
So can't you just do 

  git rev-parse HEAD

to find out?

Also have a look at the output. git rebase tells you which patch it is
applying.

Marc Weber
