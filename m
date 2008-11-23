From: nadim khemir <nadim@khemir.net>
Subject: Re: Git.pm
Date: Sun, 23 Nov 2008 21:09:01 +0100
Message-ID: <200811232109.01436.nadim@khemir.net>
References: <200811191856.44252.nadim@khemir.net> <m363mhlw92.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 23 21:09:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4LHA-0002p1-47
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 21:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbYKWUIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 15:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbYKWUIS
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 15:08:18 -0500
Received: from mail1.perspektivbredband.net ([81.186.254.13]:37806 "EHLO
	mail1.perspektivbredband.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751811AbYKWUIR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Nov 2008 15:08:17 -0500
Received: from khemir.net (h51bafc0a.c46-01-06.sta.perspektivbredband.net [81.186.252.10])
	by mail1.perspektivbredband.net (Postfix) with ESMTP id 591AD940098
	for <git@vger.kernel.org>; Sun, 23 Nov 2008 21:08:16 +0100 (CET)
Received: from naquadim.khemir.lan (naquadim.khemir.lan [192.168.1.234])
	by khemir.net (Postfix) with ESMTP id 39AA41264ECF
	for <git@vger.kernel.org>; Sun, 23 Nov 2008 21:08:16 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <m363mhlw92.fsf@localhost.localdomain>
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL,UNPARSEABLE_RELAY
	autolearn=ham version=3.2.5-gr0
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr0 (2008-06-10) on firewall
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101576>

On Friday 21 November 2008 03.56.51 Jakub Narebski wrote:
> Actually there are one and a half of Perl interfaces to Git: Git.pm
> created by Pasky (who, as far as I understand is not a Perl hacker)
> which is in git.git repository, and Git::Repo and friends created by
> Lea Wiemann during her work on "gitweb caching" project at Google
> Summer of Code 2008 (you can find her repository at git wiki page
> http://git.or.cz/gitwiki/SoC2008Projects).
>
>
> If I remember history of Git.pm correctly, it was first created as a
> way to collect together and uniquify various versions of safe_pipe and
> safe_qx which were used by various Perl scripts in git; something like
> Perl version of git-sh-setup.sh for shell scripts... At first it even
> used XS in parts, but the build system was deemed too unportable (it
> depended on -fPIC). One of design decisions was to use Error.pm for
> throwing errors; I'm not a Perl hacker, so I cannot say if this was a
> good decision, and if implementation of this part is good.

Using Error.pm is not a bad decision even if more simple mechanisms do the 
job.

> Lea Wiemann work on Git::Repo and friends was created as object
> oriented interface. It was build from ground up instead of reusing
> Git.pm to be not encumbered by Git.pm cruft... unfortunately it means
> also abandoning all the work that went in Git.pm to make it portable
> (read: make it work with crippled ActiveState Perl). You can find
> discussion on the design of Git::Repo and decision of it being clean
> state implementation at link given by Pasky.
>
> P.S. I have "[RFC] Git Perl bindings, and OO interface" half-written
> (well, more like a third), a bit stalled. I'll try to find time to
> finish it and send it to git mailing list.

That would be very usefull. the  relevant information should be integrated in 
the module itself.

Thank you for your input on the history of Git.pm.

Cheers, Nadim
