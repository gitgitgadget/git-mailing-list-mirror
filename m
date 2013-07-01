From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH] git-daemon: have --no-syslog
Date: Mon, 1 Jul 2013 22:04:19 +0200
Message-ID: <20130701200419.GA22234@inner.h.apk.li>
References: <20130622174122.GA6496@inner.h.apk.li> <7v38s9jqk0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 22:04:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtkKu-0001bh-7W
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 22:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab3GAUE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 16:04:27 -0400
Received: from continuum.iocl.org ([217.140.74.2]:48538 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab3GAUE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 16:04:26 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r61K4Jg22474;
	Mon, 1 Jul 2013 22:04:19 +0200
Content-Disposition: inline
In-Reply-To: <7v38s9jqk0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229326>

On Sat, 22 Jun 2013 23:21:03 +0000, Junio C Hamano wrote:
...
> Are there examples of other daemon programs outside Git that have
> this particular support to help such inetd implementations?

Unfortunately I only know one server that exclusively uses this
interface, and isn't even capable of running under inetd.

> I would like to know how widely this kind of workaround is done, and
> also what they call the option, as a quick sanity check.

The only open-source inetd-like server I know of that does this is Dan
Bernstein's tcpserver (which also passes the remote IP addresse and simile
in envvars), and it's probably more to the point to introduce
a --tcpserver in parallel to --inetd instead of doing --no-syslog.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
