From: Moe <moe@signalbeam.net>
Subject: Re: [PATCH] Introduce the GIT_CONFIG_EXTRA environment variable
Date: Sat, 19 Dec 2009 04:06:08 +0100
Message-ID: <4B2C4320.6060007@signalbeam.net>
References: <4B2C0828.4010505@signalbeam.net> <20091219013246.GD25474@genesis.frugalware.org> <20091219020947.GB10687@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 19 04:06:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLpeQ-0007ey-R6
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 04:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbZLSDGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 22:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792AbZLSDGM
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 22:06:12 -0500
Received: from s2.mbox.bz ([85.214.91.204]:35053 "EHLO s2.mbox.bz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754762AbZLSDGL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 22:06:11 -0500
Received: from mini.local (unknown [92.206.21.223])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by s2.mbox.bz (Postfix) with ESMTPSA id 975EDE04B6E;
	Sat, 19 Dec 2009 04:06:09 +0100 (CET)
User-Agent: Postbox 1.1.0 (Macintosh/20091201)
In-Reply-To: <20091219020947.GB10687@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135457>

Shawn O. Pearce wrote:
> Miklos Vajna <vmiklos@frugalware.org> wrote:
>> This is like GIT_CONFIG but it is not read instead of .git/config, but
>> in addtition to it.
> 
> What file does `git config --add` modify?  Should we be able to
> modify the GIT_CONFIG_EXTRA file?

>From my use-case corner: Yes, this would basically be used
to divert ~/.gitconfig and should behave in all the same ways.

> What order is GIT_CONFIG_EXTRA applied in relative to other files
> that git config would also have read?

This is up to Miklos to answer but again from my use-case angle it would
make the most sense to read the usual config files first
and GIT_CONFIG_EXTRA last - that way the user config gets the
last word in terms of overriding global and repository defaults.

And btw, thanks for the fast action Miklos!


Kind regards,
Moe
