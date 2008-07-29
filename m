From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 12:24:57 -0700
Message-ID: <d411cc4a0807291224h65e4746cgda94ee66a4ab5da0@mail.gmail.com>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
	 <7vmyk0fux8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:26:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNupe-0006kB-By
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbYG2TY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbYG2TY7
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:24:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:26746 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbYG2TY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 15:24:58 -0400
Received: by wa-out-1112.google.com with SMTP id j37so11527waf.23
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NZaePN7JLvxE3WTH50wvqu7ziNJWbv3i76DhBV2q8ek=;
        b=Z8HnRAcQJNLptN+3JkY19kGP0M7q/JIDS3NFS/zjySKdI4gVvmwaYqH4zkzR5PzVd3
         6ybtLsOEYqUj8EB3dvNOfB/36X5/ARNw4y3+H0b96Y8Tv0AV5AucMRzAAkzu3cC4meSh
         dVono9DEoBDeIXWDLS6kgXobX8drGj9ZvA3GM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YmD+LdUPPKlMP+FGOzKGToX4rC763RbV3znppgOrem5Nd4P7f3ChTg1lGIYIqAWtCD
         C3c2VfMIXK4IdVhBQqUTtmxe/+iGBPFiTJoet2HmRARDJTKqoj0tMLx/m9kY+KVN21yW
         KjiWpbx/841GwWZ58EoGgWBbXXv5HsBAz+3K0=
Received: by 10.114.148.2 with SMTP id v2mr7156417wad.173.1217359498016;
        Tue, 29 Jul 2008 12:24:58 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Tue, 29 Jul 2008 12:24:57 -0700 (PDT)
In-Reply-To: <7vmyk0fux8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90670>

On Tue, Jul 29, 2008 at 10:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Scott Chacon" <schacon@gmail.com> writes:
>
>> So I wanted to develop a really nice, easy to follow book for Git
>> newcomers to learn git quickly and easily.  One of the issues I
>> remember having when learning Git is that there is a lot of great
>> material in the User Guide, Tutorial, Tutorial 2, Everyday Git, etc -
>> but they're all huge long documents that are sometimes difficult to
>> come back to and remember where you were, and I didn't know which one
>> to start with or where to find what I was looking for, etc.
>
> Interesting.  A few comments, before I get dragged into my day job fully.
>
> [overall]
>
>  - Some people mentioned that the necessity of reading through large
>   volume of documentation can be reduced if they were divided by
>   developer roles (similar to how Everyday does), e.g. people in
>   individual contributor role does not have to learn integrator tools
>   such as "am" in their first pass on the documentation.  Has the
>   approach considered while developing this book?
>

Not really - I'm assuming that everyone will have to be one of those
roles at some point - I'm mostly aiming at the smaller developers like
myself, and probably 90% of the Git users, who have 20 git projects
that they work on with 1-5 other people.  I am not aiming at the Linux
or Git developers that have to deal with a project with hundreds of
users - everyone is going to have to be a developer, participant,
integrator and administrator to some degree, so I wanted to introduce
those commands when you need them.  IE, 'gc' and 'fsck' are rarely
_needed_ by most users - you can work just fine for a really long time
without ever needing to run them, but they are first in the Everyday
list.  I'm ordering it roughly in the order that I've seen people need
certain commands.  I could be convinced otherwise on any of them,
though.

>  - The order of sections in "Working with Git" chapter somehow does not
>   feel quite right, except that I'd agree that "Git on Windows" at the
>   beginning is a very good idea (disclaimer. I do not use Windows
>   myself). "StGIT" coming next was very understandable, but then
>   "Capistrano"????  And no CVS section next to Subversion section?  Ruby
>   before Perl or Python (I would have listed Perl, Python and then Ruby
>   to avoid language wars.  That's the language age order, and it is even
>   alphabetical)???
>

This is basically just notes at this point.  I will likely re-arrange
them as they are written.  However, I would argue that there are
likely more Git people using Ruby than there are using Python, though
Perl might rival it.  Nearly every major Ruby project out there is now
using Git, whereas very few Python ones seem to be (possibly because
Mercurial is written in python) - however, in all honesty, I don't
really care what order they are in.

As for the Capistrano section - again it is demand.  I have had tons
and tons of questions about Capistrano and Git, and many thousands of
people use that combination or are beginning to.  Again though, I
don't care where it is - I would be happy to put it at the bottom of
the section.

>   Above "Capistrano" and "Ruby" comment shows the bias this TOC has (and
>   my bias being different from the TOC's bias).  I'd imagine that
>   Ruby-minded folks won't share the same reaction as I had.  What's the
>   target audience of this book?  Git users in general, or primarily
>   Ruby-minded subset?  If the latter, labeling this as "Community Book"
>   may be misleading.

The target audience are users being convinced by their friends to use
Git and I want to impress them with a well thought out and laid out,
comprehensive, easy to use website and book as their first experience,
and show them an easy and smooth path to switch their mind from
thinking in SVN/Perforce to thinking in Git.  The Ruby community is a
very large part of the current surge to Git right now, but I want the
book to be easily accessible and acceptable to all communities that
are doing that.

> [http://book.git-scm.com/1_the_git_object_database.html]
>
>  - The color of "blob" does not match the blob that is committed to eat
>   trees at the top of your site ;-)
>
>  - In a recent thread on the list, quite a lot of people seem to have
>   found that teaching the low level details and plumbing first to the new
>   people is detrimental.  Do you have response to that thread?
>

I think I addressed this in a previous response.  As for the blob
color, a number of diagrams I am planning to introduce initially are
from a talk I gave at RailsConf on Git, and I will likely go back over
them a bit later.

Thanks,
Scott
