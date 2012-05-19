From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sat, 19 May 2012 01:00:32 -0500
Message-ID: <20120519060031.GB23799@burratino>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr>
 <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
 <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
 <CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 08:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVcjA-0006A3-HL
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 08:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab2ESGAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 02:00:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64462 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab2ESGAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 02:00:39 -0400
Received: by obbtb18 with SMTP id tb18so4940812obb.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tOBRq55ItTZnCDjM8k/zfUYgG/UjURYhF8117uHYSAk=;
        b=g4j3ZZvBFCzrAzhSW5KgoFjesKHDibXvq6Te6Jwra+rnFa7oVJWLuKG/LqUnULxfAK
         haQaapaSCmxgvZjhNihZelKjhTLZ32IPH4CZ0LSWKiM85wCERu0DFxzPwJ9/G4MwMYiU
         34Oyl09Clfy8GFb+PrWiEyLJuEuxbv5gJ6Rcx5enNRkt0JHoELtvw3EzI8uJrqm5V61O
         KpZicitot6JvfOqIEwpo59icz6QuspCqsP4bKWq/nWjHcQ8DQKZ+syqRa7+4SgMBwMAk
         V1mmKG8BNZrOE84H9OeNxkg9NUJxC13BRCFsUj1fYmIPdHRor+JPtKX4tDj+2+cJKg0o
         Bcmw==
Received: by 10.50.42.130 with SMTP id o2mr2543125igl.37.1337407238442;
        Fri, 18 May 2012 23:00:38 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gj10sm2164502igc.9.2012.05.18.23.00.36
        (version=SSLv3 cipher=OTHER);
        Fri, 18 May 2012 23:00:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198017>

Hi Mark,

Mark Lodato wrote:

> I agree with Felipe that "staging" is the most appropriate term for
> "adding to the index" in git.  As a native English speaker, I have
> never thought of "to stage" as relating to shipping in any way.  To
> me, by far the most common usage is in real estate.  The seller of a
> home "stages" it by setting up furniture and decorations to make the
> home as appealing to prospective buyers as possible.

I think staging a home does not fit very well here, actually.  As you
said, staging a home is like staging a play, creating an illusion and
putting on a production.  It is not obvious how this concept would
help me understand what it means to add content to the index.

By contrast, if you run an image search for "staging area", you will
see examples in all sorts of fields --- shipping, military logistics,
data warehousing, disaster relief.  It is a familiar, non
domain-specific term for native English speakers.  In all these
fields, staging means to put everything needed in one place before
deploying.  This matches the concept of a file that tracks the content
of the commit being prepared very well.

"aire de rassemblement" doesn't get as many hits from a web search,
alas, so I guess the idiom is not as popular in other languages.

For the sake of having a proposal: :)

 - the file representing the content of the next command would still
   be called .git/index and not be renamed

 - adding and removing content to and from the index is "staging a
   change".  Since it is not safe to assume the reader already
   knows what that means, when working on the manual authors should
   try to imagine themselves as a new user and make the text
   unambiguous enough to help such a person.

   For example, the first sentence of the "git add" manual:

	This command updates the index using the current content found in the
	working tree, to prepare the content staged for the next commit.

   should not be changed to:

	This command updates the staging area using ...

   because that just makes it less clear.  Before, it said "the index"
   and I could look in the glossary or the .git directory to at least
   find what file it was talking about.  Afterwards, it is using an
   everyday term and the new user wonders "which staging area?".

   Instead, it would be better to change it to something like:

	This command modifies the content staged for the next commit
	using content found in the working tree.  It typically adds ...

	The "index" file (see gitindex(5)) typically holds a snapshot of
	the content of the working tree, and it is this snapshot that is
	taken as the content of the next commit.  Thus after making any
	changes to the working directory, and before running the commit
	command, you must use the add command to add any new or modified
	files.

Sensible?  If so, patches welcome. :)  If not, what sort of changes
would you like to see instead?

By the way, I don't mean that "the .git/index file will not be
renamed" above to be non-negotiable.  I didn't get the impression
anyone wanted it to be renamed, but if someone does want to rename it
to .git/staging-area, then I suppose we could discuss that.

Hope that helps,
Jonathan
