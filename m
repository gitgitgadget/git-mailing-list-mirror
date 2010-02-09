From: Mark Lodato <lodatom@gmail.com>
Subject: Re: A Visual Git Reference
Date: Mon, 8 Feb 2010 19:18:14 -0500
Message-ID: <ca433831002081618s1e3193c3ge7b637ede540533a@mail.gmail.com>
References: <ca433831002081134m698f531bwa22f0474db0cdcb@mail.gmail.com> 
	<alpine.LNX.2.00.1002081513430.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 01:18:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NedoP-0007tH-Iu
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 01:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab0BIASg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 19:18:36 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:57450 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab0BIASf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 19:18:35 -0500
Received: by mail-pz0-f172.google.com with SMTP id 2so57522pzk.21
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 16:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+dj7lNeYmLHVWeIlxTlU+bKL+yV1CfbczQQlyt76ZnM=;
        b=buZ5EEXzV7yslRHLfm2d0wCcRsi+6oOw+A7cOalWZtmCLbtEfmFBBBI6fonEIB5Smd
         RFUPpv4AiabyTpXFZb5krR1wcfXtyn7klacjjb6l4k/9Zx+DGJ1PnVqN52yOVQCJDuJC
         orQT1Q+x8jKnvgNgYH6vwk+8n/m2hp3N/S1C0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EB5pe13gkLXRqCouUc7OeHg3u17RI3qxIQuQR3I1pZT5wwCZ3xZ9r7oGf6E4LN8yQY
         V06ZOrBAzAqrZXEGp8jIigBFblkriezi1VVuwk7PBfLgbNfGUCr91rKQPr0oDv2gSM0R
         7PObRLQ5zmRhhl0XTOsTMV7VaRIDhFts8vXM4=
Received: by 10.114.165.17 with SMTP id n17mr4852309wae.218.1265674715667; 
	Mon, 08 Feb 2010 16:18:35 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002081513430.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139338>

On Mon, Feb 8, 2010 at 4:57 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> The "3-way merge" node should graphically distinguish the base from the
> two sides, rather than having all three just go in. The "3-way merge"
> operation is tricky to understand visually without some sort of "split and
> rejoin, with specific points" thing.

Yes, I'm not happy with the merge picture at all.  As you said, it's
difficult to draw a nice picture for it that doesn't become too
complex.  I'll have to think of a better way...

> Also, it would probably be worth showing the use of the index in the
> process of a 3-way merge: all three versions go into the blue box, and a
> combination (with conflict markers) goes into the pink box; the user
> cleans up the pink box, and replaces the 3-part blue box content with the
> cleaned-up single result content; then the commit gives the diagram you
> have for "git merge other".

My fear is making the graphic too complicated.  That said, it may be
worth making separate graphics: a simple no-conflict case, and a more
complicated conflict case.

> I think you should introduce the detached HEAD situation early; right
> after "git checkout HEAD~ files", it would be worth showing "git checkout
> HEAD~". It's pretty common for people in the "technical user" part of the
> kernel community to use git to browse history and test different commits,
> and never do a commit at all. This is a pretty common mode across many
> version control systems (e.g., "cvs checkout -D yesterday"), and nothing
> unexpected happens if you don't try to commit while doing it.

Good point.  At your suggestion, I moved up the detached HEAD section
and integrated part of it into the checkout section.  You're right,
this does come up a lot, so I should cover it.

> In fact, you
> could show tracking down a bug introduced between maint and master by
> checking out c10b9 and then da985.

I may add a section on git bisect in the future.

> Then, later, you can bring up the fact that you can actually do commits in
> that situation, and show how that works. That part is the part that's
> novel and could potentially lead to people doing work and having it become
> unreachable. Also, after commiting with a detached HEAD, the normal next
> step is to create a new branch ("git checkout -b new-topic").

Done.  Good idea.

Thanks for the feedback.  If you have any other thoughts, I'd be glad
to hear them!
Mark
