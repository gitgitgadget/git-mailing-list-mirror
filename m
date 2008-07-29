From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 11:30:55 -0700
Message-ID: <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
	 <20080729170955.GK32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 29 20:32:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNtzL-0003je-5a
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 20:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbYG2Sa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 14:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbYG2Sa6
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 14:30:58 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:41030 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbYG2Sa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 14:30:57 -0400
Received: by an-out-0708.google.com with SMTP id d40so1013203and.103
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1RtrEQq1zNogaxIFi15dZkOh6Mk896wJv8LdWa9WC6s=;
        b=fY66A/q2QoJXkSQ+VtpMcP5gckz1YcLbDzIb6vI6PndgODI93hxRXAhKtj5MZjeFvK
         ZT0w95Pkj/io7CsBFDkJfuipIUbA2PMiyWoWIElfoBE6iEmRHZ/UqM2YR314JQh9mp/a
         6zXyert1U+yCF0pYjQZCLq118mcxDZdw9gy9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rABTdL02T86y7lmE+Bhl38g04dJgzu2IfdsurAwOXFaFlpagL6AMjsQg4kjNWGnNTj
         3mJ6PZb+n6QNmFOWly7TdVUGlpyxu1zfC2IsH3n/9qF84vYiNVoAs8KvkQoW2ej+RqVd
         9b/RsETu4M2b6c2iT65PFo1qLvO9Jls3uSNYI=
Received: by 10.100.153.6 with SMTP id a6mr10938467ane.7.1217356255970;
        Tue, 29 Jul 2008 11:30:55 -0700 (PDT)
Received: by 10.100.165.5 with HTTP; Tue, 29 Jul 2008 11:30:55 -0700 (PDT)
In-Reply-To: <20080729170955.GK32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90665>

>
> There is no license in the source code - what are the copying terms?
>

I copied in the COPYING file from Git - GPL2.

> It is maybe somewhat unfortunate that this is in a different format that
> the standard git choice asciidoc, but the formats do look rather similar
> so I assume it should not be hard to even convert from one to another if
> needed.

I simply didn't want to get asciidoc working locally - it's always
been a bit of a pain to compile (I've heard it referred to more than
once as the only 'nightmare dependancy' in git), and I don't need to
make man pages or anything, so it seemed Markdown would be a better
choice for my output targets.  There are a number of good Markdown
interpreters and they're easy to get running.

>
> Unfortunately, I probably won't have enough time to review the content
> in details anytime soon, so I can only say that that the site looks
> pretty. :-) I have skimmed through the Introduction part only, but
> frankly, my feelings are somewhat mixed; I think the "direct dive-in"
> you take in the Database and Index section is controversial at best, and
> I personally much prefer the gentle approach of user manual, which does
> not hurl details on git's objects model on the user right away. To me,
> it would make sense to move this all somewhere between chapter four and
> five. (Incidentally, only after writing this, I have looked at the
> actual structure of the User Manual and I think it makes more sense than
> your approach.)
>
> So my confusion still is - where does this stand wrt. the user manual?
> Why didn't you just start with the manual and work on that? I thought
> you were planning to do that, but apparently we misunderstood each other
> in the last mails.
>

I was originally planning on doing that, but the problem is the
graphics, diagrams and screencasts.  Unless I am mistaken, there is
not a single outside media reference in any of these guides - the
diagrams that are there are all ascii drawings.  I'm assuming there is
a reason for that. If I wanted to add images and screencast embeds
into the guide, how would that work?

Also, the user guide seems much more technical than I wanted - I
wanted to simplify a lot of the explanations, especially at the
beginning, and I don't want to screw up all the existing text.  I
thought that the best solution would be to have the Community Book as
more of a book format, and the User Guide as more of an advanced
technical guide.  We don't want to put 'Git and Capistrano' or 'Using
Git in Perl' in the User Guide, do we?  I just wanted to copy the
sections that were already well written that need to be in both, so
that I don't have to re-write them.

> Which goals are different between the Git Community Book and the User
> Manual? It seems to me that the intent is the same in both cases, and if
> the User Manual is not sufficiently digestible and easy to understand
> for a newcomer, wouldn't it make more sense to make it so?

I think the goals are a bit different.  I think the User Manual is
helpful for people coming from the Linux/Perl hacker communities that
are more used to guides like that - who like things explained more
technically and possibly even think screencasts are stupid and an
ascii graph is just as understandable as a pretty one with rounded
corners and pastel colors.

I think my goal with the book is to create a book.  The length of a
book, readable one chapter at a time over several days, etc.  Also,
eventually, I want to make it bookmarkable, maybe add some interactive
quizzes at the end of each chapter, maybe add a comments section to
the end of each chapter, add a live search box, etc.  That just seems
so much different than the User Guide and Tutorials that it warrants a
different project, but so much of the content in the Guide is quality
that I didn't want to reinvent the wheel yet again.

> The thought of yet another Git resource _in addition_ to the existing
> ones just makes me nervous. This isn't only about your time that I feel
> is being spent unnecessarily ineffectively by not building upon the
> existing text, but also about the _community_ resources - the user
> manual has a great benefit that it was actually reviewed by the mailing
> list so it will probably have quite smaller error rate than anything
> you or me would write on our own, no matter how big Git expert you are.

Well, that's what the point of this is - to ask everyone to help me
review it, and possibly help me add to it.  The user manual is great,
but even I don't reference it very often because I find it difficult
to find content in it I need quickly.  As Git becomes more and more
popular, more and more resources will continue to come out - I did the
Peepcode mini-book, which sold over a thousand copies already, and
Pragmatic Programmers and O'Reilly both have Git books in the works,
too.  I was planning on a second book with Peepcode, but I thought it
would be better to do this instead.

I would love to develop a book that is totally open and rivals all of
those and is consistently up to date and allows the community to
interact.  I don't think it's really possible to get the User Guide
there very easily except in this way.


> So, one of your arguments is that the current material are huge long
> documents that are difficult to come back to and remember where you
> were. But if I'd split the User Manaul TOC to the same layout you use
> for the Community Book, what is the difference here? It seems to me that
> both would appear pretty much the same. Should I do a proof of concept?
> ;-)

Again, I started to do this, but the image references, screencast
embeds, and general different goal of the book, both in length and
scope, makes me think that is not the best way to go.

> So, right now you are basically taking existing material and rearranging
> it? By what rules? What is the underlying idea of your approach, and why
> is it better than the current structure of the user manual? Have you
> considered how to perform this all so that you can easily get further
> updates and corrections to the user manual?

I have thought about this a lot, and it comes from the talks and
training I've done with Git and the feedback I've gotten from that.
For one, I think it's very helpful to split up the chapters into
sections ('First Time', 'Basic Usage', 'Advanced Usage', etc) so users
of different skill levels can easily see which chapters may have
something for them at a glance.

The specific order I choose is very different from the User Guide and
is likely to bother a number of people, which you mentioned (and I'm
sure Dscho will _hate_) because I introduce the object model at the
beginning.  (I'm still working on that section, trying to simplify it
and add in some other diagrams and a short screencast I have that I
think will be helpful)  This is because I have had a lot of positive
feedback that primary frustration from people comes from them thinking
of Git as a super-better Subversion.  I would venture to say that
_most_ of the users coming to Git now are currently fluent in
Subversion.  Even if they are from Perforce or CVS (the other two ones
I will occasionally run into), their mental model of what an SCM does
is the same - delta storage.  I've found that by ridding them of that
notion off the bat, they have _far_ fewer problems and frustrations
with Git than when I just try to show them the first 10 commands in
sort of a cookbook style.  It's not a complicated model, it doesn't
take long to teach, and in _my personal_ experience (which is not to
say it's necessarily correct), it helps people the most in picking it
up and really loving the tool.

The book is built so that it is just as easy to start in the 'Basic
Usage' section and go back later, but if you're going to sit down and
just start reading, I think it would be better to explain why Git is
different at a fundamental level right off the bat.

Scott
