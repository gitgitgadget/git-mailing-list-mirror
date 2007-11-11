From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecate git-fetch-pack?
Date: Sun, 11 Nov 2007 22:50:26 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711112247350.4362@racer.site>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org>
 <7v4pftip42.fsf@gitster.siamese.dyndns.org> <74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com>
 <Pine.LNX.4.64.0711111103240.4362@racer.site> <7vd4ugcwkm.fsf@gitster.siamese.dyndns.org>
 <20071111222117.GA7392@thunk.org> <7vabpkbebj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>,
	Ask =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B8rn?= Hansen 
	<ask@develooper.com>, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:50:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrLdm-0000qY-VN
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbXKKWuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756068AbXKKWuj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:50:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:40694 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755959AbXKKWuj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:50:39 -0500
Received: (qmail invoked by alias); 11 Nov 2007 22:50:37 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp040) with SMTP; 11 Nov 2007 23:50:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gXX5AAJJgUd5erlBeeJ7adIl+noKyLCpA9biGOC
	jzk3GzYOcDKvyH
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabpkbebj.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64533>

Hi,

On Sun, 11 Nov 2007, Junio C Hamano wrote:

> Theodore Tso <tytso@mit.edu> writes:
> 
> > On Sun, Nov 11, 2007 at 01:16:09PM -0800, Junio C Hamano wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> > This should be a non-issue.  We really should start deprecating 
> >> > "git-<command>" in favour of "git <command>" for real.
> >> >
> >> > New users should not even be told that this is correct usage.
> >> 
> >> If you can write "git-commit" and "git commit" interchangeably
> >> while you cannot say "git-cat-file" and are forced to say "git
> >> cat-file", I suspect that would lead to a great confusion and
> >> unhappy users.
> >
> > One of the reasons why I use git-diff and git-commit and in particular
> > "git-rebase --interactive master" very often is that it allows my
> > shell's bang completion to work.  (i.e., "!git-rebase").  If we tell
> > people they can not use "git-rebase", and must instead use "git
> > rebase" instead, I would consider that pretty annoying/obnoxious.
> 
> Oh, of course.
> 
> But my impression was that Johannes was talking about
> deprecating git-<foo> form only for plumbing, so that the users
> will only see git-<foo> for the Porcelain.  That would not break
> your bang completion for the porcelain commands.
> 
> If Johannes was talking about deprecating all git-<foo> form,
> then that would indeed break your bang completion, but it has
> conceptually a much bigger problem.  The topic was about fixing
> "a new user sees too many git commands and gets scared" problem.
> Deprecaing all git-<foo> form just replaces the problem with "a
> new user sees too many git subcommands and gets scared" problem,
> without solving anything.

I beg to differ.  The biggest problem with a new user seeing all those 
completions is that this user is scared.

Just taking away that first shock would be helping very much.  I mean, we 
_still_ have the reputation of being more complex than other SCMs, but I 
do not think that this reputation is completely deserved.

However, reputations are formed by first time impressions.  It is _hard_ 
to get rid of a bad first time impression.

But yes, I was only proposing to deprecate all usage of git-<bla> in the 
documentation.

Maybe I'm wrong.  Wouldn't be the first time.

Ciao,
Dscho
