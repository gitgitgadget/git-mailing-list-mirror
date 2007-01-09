From: Yann Dirson <ydirson@altern.org>
Subject: Re: Getting gitk to display all refs but stgit logs
Date: Tue, 9 Jan 2007 20:41:08 +0100
Message-ID: <20070109194108.GC17093@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070108213259.GB17093@nan92-1-81-57-214-146.fbx.proxad.net> <e5bfff550701090417g3f8ab697n709721939ab36f5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 20:41:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4MqV-00073M-ER
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 20:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbXAITlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 14:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbXAITlQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 14:41:16 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:40489 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932186AbXAITlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 14:41:16 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id C90F427B5F;
	Tue,  9 Jan 2007 20:41:14 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id B3EF21F0A3; Tue,  9 Jan 2007 20:41:08 +0100 (CET)
To: Marco Costalba <mcostalba@gmail.com>
Content-Disposition: inline
In-Reply-To: <e5bfff550701090417g3f8ab697n709721939ab36f5d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36389>

On Tue, Jan 09, 2007 at 01:17:57PM +0100, Marco Costalba wrote:
> On 1/8/07, Yann Dirson <ydirson@altern.org> wrote:
> >Since v0.11, StGIT creates references to keep a hand on patch logs.
> >This has the unfortunate side-effect that "gitk --all" suddenly shows
> >all those very annoying, and soon becomes unusable on
> >repositories for which was very convenient.
> >
> 
> Normally you only need branch names
> 
> gitk/qgit --all  --> practically equivalent to --> gitk/qgit <list of
> branch names>

Not exactly.  While qgit has knowledge of StGIT stacks and displays
unapplied patches [1], gitk does not, and requesting a branch only
shows the applied patches.  I have no opinion whether gitk should be
taught about them, but I'd like it to be usable on them anyway.

One thing that qgit also does not show, but which I regularly use when
viewing StGIT stacks in gitk, is the ancestry of unapplied patches
(eg. you can see at first glance whether an unapplied patch is
uptodate, or has not been ported yet atop the currently-applied ones.

[1] BTW, as of 1.5.3 it displays them backwards, causing all sors of
problems - I've not yet collected all of my comments for you, but at
least that one is sent now ;)

Best regards,
-- 
Yann.
