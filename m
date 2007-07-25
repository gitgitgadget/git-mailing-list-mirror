From: Russ Dill <Russ.Dill@gmail.com>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 17:56:05 +0000 (UTC)
Message-ID: <loom.20070725T195200-46@post.gmane.org>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>  <693D0FFF-B271-4781-BCE2-3BF00C8BF426@zib.de> <316a20a40707250958w1fe9f6fdn41d75ca704aeb9cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 20:00:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDl9l-00007h-4D
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 20:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765276AbXGYSAM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 14:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764081AbXGYSAL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 14:00:11 -0400
Received: from main.gmane.org ([80.91.229.2]:60361 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760813AbXGYSAK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 14:00:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IDl9W-0005Gy-D0
	for git@vger.kernel.org; Wed, 25 Jul 2007 20:00:02 +0200
Received: from 64-42-117-11.atgi.net ([64.42.117.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 20:00:02 +0200
Received: from Russ.Dill by 64-42-117-11.atgi.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 20:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 64.42.117.11 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.5) Gecko/20070713 Firefox/2.0.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53704>

Stephen Cuppett <cuppett <at> gmail.com> writes:

> I actually have no problems with cygwin and find it works pretty well
> with git repositories.  Starting the xserver to run git-gui is pretty
> annoying though.  Windows-based development teams are going to expect
> easy access to those kinds of tooling.  Otherwise, the champion will
> be pushing a type of workflow change that would hinder adoption anyway
> and leave a sour taste for a long time.

I have the version of git that came with cygwin, and I never have to run an X
server to run git-gui or gitk.

Personally, I can't imagine running git without cygwin. Course, I want my
desktop to feel as much like unix as possible. My experience with git under
cygwin has been excellent. My only gripe has to do with CRLF. The repository has
everything checked in with dos line endings, I'd like to check everything out
with unix line endings, and then check it back in with dos line endings. I hate
seeing the ^M's everywhere.

> In addition, performance is atrocious.  In my particular case I have
> an older P4 running F7 and a newer machine running Windows and cygwin.
>  On a pserver based cvsimport of a large, enterprise project, Linux
> was able to generate the full history in 4 hours, cygwin took 3 and a
> half days.  When I sync up every now and then, typical times for
> windows are 25 minutes and Linux is around 4.  That should give you an
> idea of what kind of multiplier we are talking about.

Granted, the performance isn't equal to git running on a real unix, but compared
to working with SVN under win32, I would say it performs quite well.
