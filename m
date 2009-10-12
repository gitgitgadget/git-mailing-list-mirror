From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git refuses to work with gvim
Date: Mon, 12 Oct 2009 07:25:23 -0700
Message-ID: <20091012142523.GH9261@spearce.org>
References: <20091012134312.236d250e@gzip.coli.uni-saarland.de> <vpq8wfgg4u1.fsf@bauges.imag.fr> <20091012141334.GE9261@spearce.org> <94a0d4530910120720pccaa920n7ab407494473ac7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	sebastian@coli.uni-sb.de, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:40:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxM4D-0002uT-27
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822AbZJLO0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756807AbZJLO0A
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:26:00 -0400
Received: from george.spearce.org ([209.20.77.23]:50603 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbZJLOZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:25:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B07DC381FE; Mon, 12 Oct 2009 14:25:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <94a0d4530910120720pccaa920n7ab407494473ac7b@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130019>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> On Mon, Oct 12, 2009 at 5:13 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> >
> > Someone needs to whack gvim upside the head and fix that program
> > to behave correctly.
> 
> Huh? What is wrong about 'gvim --nofork'?

The fact that its a command line option that isn't the default.
gvim's UI here is as bad as pre 0.99 git.

People do:

	export EDITOR=gvim

and things work OK for a while, as they always open a new editor,
work with the file, and then close it, killing the only running gvim
session.  Since gvim waits if its the only gvim process running,
things seem fine.  But days later when you leave a file open,
suddenly the command calling $EDITOR starts failing.

I've seen it happen to a lot of people.  They just start complaining
about how one day "git commit" is fine, and the next day its
not working.  But its been weeks since they selected gvim as their
$EDITOR and they can't connect the open editor window as the problem
with that Goddamn Idiotic Truckload of s**t they are forced to use.

-- 
Shawn.
