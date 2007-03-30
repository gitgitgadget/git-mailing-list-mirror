From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-mergetool: de-bashify function declarations
Date: Fri, 30 Mar 2007 00:03:12 -0400
Message-ID: <20070330040312.GB2522@coredump.intra.peff.net>
References: <20070330032645.GA6876@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tytso@mit.edu, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 06:03:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX8Ki-0003xj-3Z
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 06:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbXC3EDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 00:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbXC3EDP
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 00:03:15 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2045 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbXC3EDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 00:03:14 -0400
Received: (qmail 21526 invoked from network); 30 Mar 2007 04:03:45 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Mar 2007 04:03:45 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2007 00:03:12 -0400
Content-Disposition: inline
In-Reply-To: <20070330032645.GA6876@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43493>

On Thu, Mar 29, 2007 at 11:26:45PM -0400, Jeff King wrote:

>  # Returns true if the mode reflects a symlink
> -function is_symlink () {
> +is_symlink () {
>      test "$1" = 120000
>  }

Oops, looks like Ted already fixed this, but it just hasn't been pulled
yet. Sorry for the noise.

-Peff
