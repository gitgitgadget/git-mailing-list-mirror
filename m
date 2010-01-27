From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git notes: notes
Date: Wed, 27 Jan 2010 21:01:22 +0100
Message-ID: <201001272101.22870.chriscool@tuxfamily.org>
References: <20100120050343.GA12860@gnu.kitenet.net> <201001210305.05309.johan@herland.net> <1264442884.14641.33.camel@cp-jk-linux.corp.on2.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, Joey Hess <joey@kitenet.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
To: john.koleszar@on2.com
X-From: git-owner@vger.kernel.org Wed Jan 27 20:58:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaE23-0007HF-Vp
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 20:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346Ab0A0T6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 14:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270Ab0A0T6W
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 14:58:22 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36643 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244Ab0A0T6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 14:58:21 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9FBE6818220;
	Wed, 27 Jan 2010 20:58:14 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 30AFF8181C9;
	Wed, 27 Jan 2010 20:58:11 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1264442884.14641.33.camel@cp-jk-linux.corp.on2.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138190>

On lundi 25 janvier 2010, John Koleszar wrote:
> On Wed, 2010-01-20 at 21:05 -0500, Johan Herland wrote:
> > On Wednesday 20 January 2010, Joey Hess wrote:
>
> > In any case, I would not use "git notes" to maintain the bisect hints.
> > Rather, I'd add subcommands to "git bisect" that would take care of
> > maintaining the notes tree @ "refs/notes/bisect". Much more
> > user-friendly than telling the user to write their own bisect-notes by
> > hand.
>
> I haven't read up on notes more than enough to know its in the pipe, but
> I had a similar idea for using them to store bisect hints. I've been
> doing a lot of bisecting lately into a range that had a couple dormant
> bugs where I'm trying to bisect bug B but bug A prevents me from making
> a determination. Rather than skip what I know is an interesting commit,
> I cherry-pick the bugfix commit(s) A' and test that, then reset and
> continue bisecting.
>
> Teaching bisect to consistently skip a commit, or to automatically
> squash in A' if we have A and not A', would be a desirable feature. I
> will have to read up some more on notes.

Perhaps you can read about "git replace" in my article:

http://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.html

and/or my related presentation:

http://www.linux-kongress.org/2009/slides/fighting_regressions_with_git_bisect_christian_couder.pdf

I think in the long run it's much better to use git replace rather than 
notes, especially as replace refs for bisecting could be in their own 
refs/replace/bisect namespace. I may take the time to implement that soon 
if you or other people are interested.

Regards,
Christian.
