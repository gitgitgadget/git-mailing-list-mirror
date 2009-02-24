From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [EGIT] [PATCH v1 1/1] Add an ignored icon
Date: Tue, 24 Feb 2009 10:22:45 +0100 (CET)
Message-ID: <13520.77.61.241.211.1235467365.squirrel@hupie.xs4all.nl>
References: <42268.77.61.241.211.1235455860.squirrel@hupie.xs4all.nl>
    <49A3BCA3.8010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Ferry Huberts" <ferry.huberts@pelagic.nl>, git@vger.kernel.org,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:24:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbtWU-0001Tg-3S
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbZBXJWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbZBXJWv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:22:51 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:56122 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751663AbZBXJWu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 04:22:50 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id 0742158BDBB; Tue, 24 Feb 2009 10:22:45 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Tue, 24 Feb 2009 10:22:45 +0100 (CET)
In-Reply-To: <49A3BCA3.8010201@gmail.com>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111248>

>> I just checked, TortoiseSVN has the overlay for ignored items on by default
>
> The difference is TortoiseSVN does not come with a set of global default
> ignored files (as far as I know). Eclipse does, see Team->Ignored...
>
> So, a globally ignored file such as foobar.BAK would show up as
> non-decorated if shared using the CVS or SVN plugins, but with an icon
> if shared with Git. That might be confusing to users, especially since
> the minus-sign icon does not have any history in Eclipse as something
> being "ignored" (it actually breaks the convention of using
> non-decoration -- meaning no "untracked"-icon -- to signal ignored).
>
> So, I would still argue that we should leave it off by default.
>

For now I think that's acceptable. However, when I complete the work
on the ignores then we should switch it on:
I plan to let EGit NOT look at the Eclipse global ignore list because
the ignores are defined by .gitignore files for git repositories.
At that point it totally makes sense to decorate ignored resources
because these are configured in .gitignore files
