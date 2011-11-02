From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Antw: Re: Q: "git diff" using tag names
Date: Wed, 02 Nov 2011 08:31:06 +0100
Message-ID: <4EB0FFCA020000A100007DE2@gwsmtp1.uni-regensburg.de>
References: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
 <20111028165943.2cc8253d@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Alexey Shumkin" <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 08:31:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLVI6-0008Ul-Fi
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 08:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab1KBHbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 03:31:13 -0400
Received: from rrzmta2.uni-regensburg.de ([194.94.155.52]:41458 "EHLO
	rrzmta2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab1KBHbN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 03:31:13 -0400
Received: from rrzmta2.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 4F8984CCD
	for <git@vger.kernel.org>; Wed,  2 Nov 2011 08:31:10 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta2.uni-regensburg.de (Postfix) with ESMTP id 22F134621
	for <git@vger.kernel.org>; Wed,  2 Nov 2011 08:31:09 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Wed, 02 Nov 2011 08:31:10 +0100
X-Mailer: Novell GroupWise Internet Agent 2012.0.0 Beta 
In-Reply-To: <20111028165943.2cc8253d@ashu.dyn.rarus.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184612>

Hello Alexey,

thank you very much for your reply. I felt I did something wrong, but couldn't find out what it was. Actually it turned out that I had just mistyped one tag name.

Also it seems that both syntaxes work:
git diff v0.4..v0.5
git diff v0.4 v0.5

The question is: How does git disambiguate between tag names, commits and file names? (All may start with a letter)
This seems to work automagically, and I was desparately looking for an option like "--" to separate revisions from file names. I found "SPECIFYING REVISIONS" in git-rev-parse(1), so you don't really have to answer.

Regards,
Ulrich

>>> Alexey Shumkin <Alex.Crezoff@gmail.com> schrieb am 28.10.2011 um 14:59 in
Nachricht <20111028165943.2cc8253d@ashu.dyn.rarus.ru>:
> Tag is a pointer to a commit (if to say simply)
> 
> e.g. in my repo
> $ git show-ref --tags --abbrev=7
> -->8--
> 676f194 refs/tags/v2.6.7
> b23c481 refs/tags/v2.6.8
> -->8--
> 
> so
> 
> $ git diff v2.6.7..v2.6.8
> is equivalent to
> $ git diff 676f194..b23c481
> 
> etc
> > Hi,
> > 
> > when using a somewhat older git (of SLES11 SP1 SDK), I could not find
> > a way to "git diff" between two tag names; I can only diff between
> > two commit numbers. I can display a changeset using "git show", but
> > that's not what I wanted. Is it possible to get the diff I want using
> > older versions, and is such a feature implemented in the current
> > version? If so, since when?
> > 
> > As I'm not subscribed to the list, I'd appreciate CC'ed replies.
> > Thank you.
> > 
> > Greeting
> > Ulrich
> > 
> > 
> 
> 

 
 
