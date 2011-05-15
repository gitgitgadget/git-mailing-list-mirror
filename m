From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: ACLs for GIT
Date: Sun, 15 May 2011 22:28:06 +0200
Message-ID: <1305490853-sup-1446@nixos>
References: <4DD02876.1040404@bbn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 15 22:28:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhvG-000055-EW
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 22:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978Ab1EOU2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 16:28:14 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:54024 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750929Ab1EOU2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 16:28:13 -0400
Received: (qmail invoked by alias); 15 May 2011 20:28:08 -0000
Received: from p4FEFB13D.dip.t-dialin.net (EHLO mail.gmx.net) [79.239.177.61]
  by mail.gmx.net (mp068) with SMTP; 15 May 2011 22:28:08 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/X9UQJF+nXmcV9pSNDKPZrVL31s3uSpVPsQJTAS1
	gVb7YWZ0++kZQf
Received: by mail.gmx.net (sSMTP sendmail emulation); Sun, 15 May 2011 22:28:07 +0200
In-reply-to: <4DD02876.1040404@bbn.com>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173662>

Excerpts from Martin L Resnick's message of Sun May 15 21:24:38 +0200 2011:
> Is anyone working on adding access control to GIT ?

I don't know git internals very well. But my very basic understanding is
that each commit hash is based on *all* file contents and path names and its history.

If you drop some paths (eg by denying access) there is no way to verify
or recalculate the hashes ?

So even if you can deny access to some path I'd expect the result to be
unusable because all kinds of tools such as gitk will start telling you
about missing paths.


Alternative ideas:

- github supports SVN access to git repos. Maybe you can ask them to
  provide what you're looking for?

- clone the repo and strip off the files. Then allow access to those
  cloned striped repos only.

I don't think there is a simple solution to your request. But others may
know better than I do.

Marc Weber
