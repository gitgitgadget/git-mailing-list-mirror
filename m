From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Support for configurable git command aliases
Date: Sun, 28 May 2006 23:58:58 -0400
Message-ID: <20060529035857.GA7641@coredump.intra.peff.net>
References: <torvalds@osdl.org> <Pine.LNX.4.64.0605262007230.5623@g5.osdl.org> <200605271252.k4RCqZhR003192@laptop11.inf.utfsm.cl> <20060528215945.GD10488@pasky.or.cz> <e5d9sm$5d4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 29 05:59:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkYuN-0000oB-6F
	for gcvg-git@gmane.org; Mon, 29 May 2006 05:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWE2D7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 23:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWE2D7A
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 23:59:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:31991 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751154AbWE2D67 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 23:58:59 -0400
Received: (qmail 21821 invoked from network); 29 May 2006 03:58:58 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 29 May 2006 03:58:58 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 May 2006 23:58:58 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e5d9sm$5d4$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20916>

On Mon, May 29, 2006 at 12:57:26AM +0200, Jakub Narebski wrote:

> Well, if [alias] would be used also for giving default options for git
> commands, e.g.
> 
>         [alias]
>             log = log --pretty

A funny side effect of that would be that "git log" and "git-log" would
now have completely different defaults (unless the alias mechanism
starts intercepting direct calls to git-*, which seems invasive). I
wonder if it might be simpler to just add 
  core.defaults.log = "--pretty"
or similar.

-Peff
