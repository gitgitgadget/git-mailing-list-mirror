From: Mirko Stocker <me@misto.ch>
Subject: Re: Working with Git and CVS in a team.
Date: Sun, 15 Jun 2008 22:22:49 +0200
Message-ID: <200806152222.50119.me@misto.ch>
References: <200806131633.34980.mirko.stocker@hsr.ch> <200806132247.03947.m1stocke@hsr.ch> <20080613205525.GA21165@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Stocker Mirko (m1stocke@hsr.ch)" <m1stocke@hsr.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 22:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7ypS-0005LT-Ts
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 22:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbYFOU1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 16:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYFOU1D
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 16:27:03 -0400
Received: from luc80-74-131-252.ch-meta.net ([80.74.131.252]:56207 "EHLO
	lucius.metanet.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751459AbYFOU1B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 16:27:01 -0400
Received: (qmail 11195 invoked from network); 15 Jun 2008 22:20:18 +0200
Received: from 84-72-93-108.dclient.hispeed.ch (HELO ?192.168.1.127?) (84.72.93.108)
  by luc80-74-131-153.ch-meta.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 15 Jun 2008 22:20:18 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080613205525.GA21165@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85115>

On Friday 13 June 2008 22:55:26 Jeff King wrote:
> Ah, I hadn't thought of that. Apparently git-cvsimport doesn't
> understand bare repos. There is even a Debian bug reported:
>
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=472873
>
> You might be able to hack around it with:
>
>   mkdir bare.git && (cd bare.git && git init)
>   mkdir cvsimport-hack && ln -s ../bare.git cvsimport-hack/.git
>   git cvsimport -C cvsimport-hack

Uh, ok.. :) Thanks. 

I just wondered, do I even need the additional bare repository? If I use 
git-cvsimport with -i, then it creates only the .git without doing a 
checkout, then we could just clone this one from the clients and pull/push to 
it?

Thanks

Mirko
