From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Sun, 9 Nov 2008 13:02:48 -0800
Message-ID: <20081109210248.GF2932@spearce.org>
References: <20081031170704.GU14786@spearce.org> <4915939B.1070306@gmail.com> <4915A3CB.5010909@op5.se> <20081108172759.GA31655@artemis.corp> <4916B8AA.2080602@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Steve Frrrcinaux <nudrema@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Nov 09 22:04:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzHS7-0005CM-W5
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 22:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbYKIVCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 16:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755771AbYKIVCt
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 16:02:49 -0500
Received: from george.spearce.org ([209.20.77.23]:42672 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbYKIVCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 16:02:49 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B0C03381FE; Sun,  9 Nov 2008 21:02:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4916B8AA.2080602@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100470>

Andreas Ericsson <ae@op5.se> wrote:
>
> Well, I suggested putting "src/public/public_header.h" quite early on,

I must have missed that suggestion.  Its not a bad idea.

> with private headers next to the source. AFAIU, the private and public
> headers both are now located in the same directory, and that directory is
> separate from the .c files.

Currently there are only public headers, and the public headers are
all under include/git/.  Private headers are going to be under src/
so they are isolated from the public headers.

But I haven't had a chance to touch libgit2 in over a week.  :-\

I've simply got too many projects going on at once.  This is one
I really want to work on though, so I'm going to try and make time
for it next week.  But I'm also in the middle of a major overhaul
of Gerrit, so it can run on non-Google infrastructure and thus is
usable by pretty much anyone.

-- 
Shawn.
