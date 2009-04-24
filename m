From: Jeff King <peff@peff.net>
Subject: Re: auto commit merge using the default merge message
Date: Fri, 24 Apr 2009 13:55:11 -0400
Message-ID: <20090424175511.GA11360@coredump.intra.peff.net>
References: <81bfc67a0904230046j48ed06b7s5693406332ee52dc@mail.gmail.com> <81b0412b0904230057k1653d039vfc3962e6affda584@mail.gmail.com> <49F025E7.7090404@drmicha.warpmail.net> <7vocunwz1n.fsf@gitster.siamese.dyndns.org> <81bfc67a0904231831y31bfb057pa5eaa86d0e153824@mail.gmail.com> <20090424140606.GB10761@coredump.intra.peff.net> <81bfc67a0904241050t26a0ed62vbf17e471ddc10672@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 19:57:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxPdw-0008MW-9X
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 19:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761188AbZDXRzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 13:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761006AbZDXRzU
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 13:55:20 -0400
Received: from peff.net ([208.65.91.99]:49917 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761302AbZDXRzS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 13:55:18 -0400
Received: (qmail 30439 invoked by uid 107); 24 Apr 2009 17:55:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 13:55:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 13:55:11 -0400
Content-Disposition: inline
In-Reply-To: <81bfc67a0904241050t26a0ed62vbf17e471ddc10672@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117476>

On Fri, Apr 24, 2009 at 01:50:57PM -0400, Caleb Cushing wrote:

> On Fri, Apr 24, 2009 at 10:06 AM, Jeff King <peff@peff.net> wrote:
> > export GIT_EDITOR
> >
> maybe I'm being silly, but won't that then affect my interactive shells?

No, because you're putting it in your shell script, not in your .profile
(right?). The "export" command just tells the shell "pass this variable
in the environment to any child processes you spawn". Without it, the
variable is local to that shell.

-Peff
