From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: optionally read config from GITWEB_CONFIG
Date: Wed, 02 Aug 2006 13:28:04 -0700
Message-ID: <7vu04uubl7.fsf@assigned-by-dhcp.cox.net>
References: <20060802192333.GA30861@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:28:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NKA-0005o7-1z
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWHBU2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWHBU2H
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:28:07 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:27112 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932224AbWHBU2F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 16:28:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060802202805.BKNB12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Aug 2006 16:28:05 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060802192333.GA30861@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 2 Aug 2006 15:23:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24676>

Jeff King <peff@peff.net> writes:

> Configuration will first be taken from variables inside the gitweb.cgi
> script, which in turn come from the Makefile. Afterwards, the contents of
> GITWEB_CONFIG are read, overriding the builtin defaults.
>
> This should eliminate the need for editing the gitweb script at all. Users
> should edit the Makefile and/or add a config file.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is on top of next.
>
> This patch seemed to get a favorable response, so I cleaned it up and
> actually tested it. The main changes are reordering a few of the setup
> statements so that changes introduced in the config file are respected
> as suggested by Matthias (and a few by me). It would be good if other
> gitweb people could check it over and/or try it with their config to
> make sure I didn't miss anything.

Looks good -- thanks.  Further comments from the list are very
much appreciated.
