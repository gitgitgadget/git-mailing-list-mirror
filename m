From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Configuration overrides via environment variable
Date: Mon, 28 Jan 2008 21:58:37 +0100
Message-ID: <20080128205837.GB5788@efreet.light.src>
References: <ee77f5c20801271708k124dc9d7n942b3c95299cb7fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 21:59:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJb4Y-00078w-52
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 21:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbYA1U6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 15:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbYA1U6q
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 15:58:46 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:55732 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbYA1U6p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 15:58:45 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 7B92557386;
	Mon, 28 Jan 2008 21:58:43 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 9Jj76-ZxQnZ8; Mon, 28 Jan 2008 21:58:40 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 68AA45737B;
	Mon, 28 Jan 2008 21:58:39 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JJb3t-0001eG-QK; Mon, 28 Jan 2008 21:58:37 +0100
Content-Disposition: inline
In-Reply-To: <ee77f5c20801271708k124dc9d7n942b3c95299cb7fb@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71899>

On Mon, Jan 28, 2008 at 12:08:10 +1100, David Symonds wrote:
> Hi,
> 
> I'm using Git in some scripts, and wanted to get its colorised output
> even when it is not going to a tty. I don't want to permanently change
> ~/.gitconfig or the per-repo config; I just want to set color.status
> (and perhaps others) to "always" for a one-off run. I suppose I could
> munge the config files, storing the previous value and restoring it
> later, but that's messy.
> 
> Ideally, an environment variable like GIT_EXTRA_CONFIG or something
> would be nice, so I could just do:
> 
> GIT_EXTRA_CONFIG="color.status=always" git status | ...
> 
> Thoughts? Does this already exist, and I've overlooked it?

Quickly looking at the git-config manpage, there does not seem to be a way to
provide alternate config file via GIT_CONFIG and/or GIT_CONFIG_LOCAL
variables. I don't know how good match for your problem that would be.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
