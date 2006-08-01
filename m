From: Junio C Hamano <junkio@cox.net>
Subject: Re: A few more fixups to gitweb
Date: Tue, 01 Aug 2006 01:04:47 -0700
Message-ID: <7vd5bk3mqo.fsf@assigned-by-dhcp.cox.net>
References: <200607292239.11034.jnareb@gmail.com>
	<200608010259.13721.jnareb@gmail.com>
	<7vzmep2icr.fsf_-_@assigned-by-dhcp.cox.net>
	<ean0a1$irf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 10:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7pFF-0000YZ-54
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 10:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161369AbWHAIEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 04:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161371AbWHAIEu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 04:04:50 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:65509 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1161369AbWHAIEt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 04:04:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801080448.OTHV554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Aug 2006 04:04:48 -0400
To: jnareb@gmail.com
In-Reply-To: <ean0a1$irf$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	01 Aug 2006 09:36:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24581>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, I wonder why git when cloning/fetching via http protocol
> uses e.g. "git/1.4.2.rc2.ge0bed" as User-Agent: string when fetching objects
> and packs, and e.g. "curl/7.15.4 (i486-pc-linux-gnu) libcurl/7.15.4
> OpenSSL/0.9.8b zlib/1.2.3 libidn/0.6.5" as User-Agent: when fetching refs
> (heads and tags) and info/refs.

"Why?", meaning if we deliberately do so for some good reason?

There isn't.

git-http-fetch uses its own User-Agent string, but the shell
script wrappers that use curl executable do not bother setting
customized User-Agent string; that is why.
