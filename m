From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: call external editor from git-gui?
Date: Tue, 14 Aug 2007 00:55:11 -0400
Message-ID: <20070814045511.GF27913@spearce.org>
References: <20070810153008.GA31759@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 06:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKoRH-00026G-RP
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 06:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S940028AbXHNEzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 00:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939958AbXHNEzU
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 00:55:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55384 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936624AbXHNEzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 00:55:16 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IKoQz-0002so-3Z; Tue, 14 Aug 2007 00:55:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BCAE420FBAE; Tue, 14 Aug 2007 00:55:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070810153008.GA31759@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55805>

Karl Hasselstrm <kha@treskal.com> wrote:
> git-gui is very good at composing commits. But for writing the actual
> commit message -- especially if it's long and needs paragraph
> reflowing, indentation, and so on -- I vastly prefer emacs over
> git-gui's text field.

Yea, I've been thinking about adding fancy features like those.
But been lazy.  Spawning the user's preferred editor would be a
nice way to get some of that.
 
> It seems to me like it would be straightforward to have a button or
> something to launch the user's favorite editor for editing of the
> commit message -- after all, git even knows what editor that is!

Probably.  git-gui already has the data from .git/config loaded in
memory, it should be fairly simple.

> Unfortunately, with my tcl expertise, this is likely a whole-weekend
> project, so I probably won't try to build it myself in the near
> future.

With my busy schedule its unlikely to happen anytime soon either.
But I've added it to my todo branch.  Sometimes things on that list
get accomplished.  ;-)

An annoying work-around would be to run your editor to create/edit
.git/GITGUI_MSG (or .git/MERGE_MSG) then hit Rescan in git-gui.
It loads that file into its editor buffer if the editor buffer is
empty or has not been modified from within git-gui since the last
time the file was read.

-- 
Shawn.
