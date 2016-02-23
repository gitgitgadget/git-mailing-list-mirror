From: John Keeping <john@keeping.me.uk>
Subject: Re: Git Daemon Dummy: 301 Redirects for git:// to https://
Date: Tue, 23 Feb 2016 10:51:59 +0000
Message-ID: <20160223105159.GJ1766@serenity.lan>
References: <CAHmME9rTpGNHMKbXD48oBYm136=u79YiHjX5hm8ZYC4xSThJsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 11:57:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYAZq-00084z-8G
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 11:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbcBWKwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 05:52:17 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:49971 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbcBWKwO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 05:52:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C09DACDA58D;
	Tue, 23 Feb 2016 10:52:12 +0000 (GMT)
X-Quarantine-ID: <HEvdQxcKz46c>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HEvdQxcKz46c; Tue, 23 Feb 2016 10:52:09 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 63334CDA62B;
	Tue, 23 Feb 2016 10:52:01 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAHmME9rTpGNHMKbXD48oBYm136=u79YiHjX5hm8ZYC4xSThJsA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287042>

On Tue, Feb 23, 2016 at 03:32:02AM +0100, Jason A. Donenfeld wrote:
> In case anyone else finds this useful, I wrote this:
> 
> https://git.zx2c4.com/git-daemon-dummy/about/
> 
> It's an epoll-based responder for git:// that simply returns an error
> telling users of a new URI. The purpose is to phase out git-daemon in
> favor of more secure TLS/HTTPS endpoints. With HTTPS certificates now
> being free, seems like this could be useful.
> 
> My personal motivation is that I'd like to just totally kill the
> git-daemon service, but somebody hard coded a URI of mine into a real
> printed textbook [1], so I don't want it to go stale suddenly. So, I
> need some way of informing users of the new URI.
> 
> Let me know what you think.

There's no license specified in the repo, it just says "All rights
reserved" in the .c file.  I'm sure you intend it to be open source, but
it isn't unless a license is specified.
