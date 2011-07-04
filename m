From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Mon, 4 Jul 2011 22:05:09 +0200
Message-ID: <20110704200509.GA783@book.hvoigt.net>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com> <1309112987-3185-3-git-send-email-iveqy@iveqy.com> <7v1uydvmh0.fsf@alter.siamese.dyndns.org> <20110628193034.GB3700@book.hvoigt.net> <7viprpu1p5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 04 22:05:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdpOR-0008PY-Ly
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 22:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab1GDUFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jul 2011 16:05:13 -0400
Received: from darksea.de ([83.133.111.250]:44327 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751834Ab1GDUFM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2011 16:05:12 -0400
Received: (qmail 27599 invoked from network); 4 Jul 2011 22:05:10 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 4 Jul 2011 22:05:10 +0200
Content-Disposition: inline
In-Reply-To: <7viprpu1p5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176603>

Hi,

On Tue, Jun 28, 2011 at 01:43:18PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> >> What if
> >> 
> >>  (1) you are binding somebody else's project as your own submodule, you do
> >>      not make any local changes (you won't be pushing them out anyway),
> >>      and you do not have remote tracking branches in that submodule
> >>      project?
> >
> > In this scenario the superproject can not be cloned that way that it
> > would contain the submodule right? I would consider this a rather exotic
> > way to work since pushing means to share your work somehow.
> 
> Sorry, I don't follow. Isn't this the classical example of an el-cheapo
> router firmware project (i.e. superproject) binding unmodified Linux
> kernel project as one of its submodules without you having any push
> privilege to Linus's repository, which was one of the original examples
> used in the very initial submodule discussion?

But in such an example the Linux submodule (if used with git submodule)
would have remote tracking branches even though they are not directly
pushable.

Cheers Heiko
