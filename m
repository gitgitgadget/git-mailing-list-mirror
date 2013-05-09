From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [PATCHv2] CodingGuidelines:  make it clear which files in Documentation/ are the sources
Date: Thu, 9 May 2013 16:18:35 -0400
Message-ID: <201305092018.r49KIY5N024319@freeze.ariadne.com>
References: <201305082024.r48KOH55003964@freeze.ariadne.com> <7vy5bpdx64.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 22:25:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaXPV-00070P-Rk
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 22:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab3EIUZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 16:25:46 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:48310
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752815Ab3EIUZn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 May 2013 16:25:43 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 May 2013 16:25:43 EDT
Received: from omta21.westchester.pa.mail.comcast.net ([76.96.62.72])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id ZvCP1l00L1ZXKqc53wJctp; Thu, 09 May 2013 20:18:36 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta21.westchester.pa.mail.comcast.net with comcast
	id ZwJc1l00G1KKtkw3hwJccD; Thu, 09 May 2013 20:18:36 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r49KIZdT024320;
	Thu, 9 May 2013 16:18:35 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r49KIY5N024319;
	Thu, 9 May 2013 16:18:35 -0400
In-reply-to: <7vy5bpdx64.fsf@alter.siamese.dyndns.org> (gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1368130716;
	bh=v0F3pHQ1nztXRkl9pMXc18vcSTQEI6OCLpso2PzznLE=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=OtSI7GYLrstto2PqSlKFgros2Jy4pBfMhy7yE4UoqLUmrmMBjP2qtjKy5hn1++yXb
	 LA0HIFPeXOvDt3ZNBxWbQrpifTG4COk56sNrju68XZwjN/M83kpGvORiuUYy+XaASw
	 ehWTCsBJCtaBz1NOm/opnj+29Rw7j7dCI4WJk4EdMAnXNnsugtgTJ1P7aRJnWdzr7q
	 Q9HLqiazzUnJkmcewo+RIUHbcecmcpAF2LzoNl8SDnv1hDGlIWiofUUrmO6qsqsG7d
	 3E/sMr5J1AVPkT/NafwY4EMcnIxUu3WkD9zQAPW4Y/YIQ6zK0L9k4+Yliq+GBqUd1g
	 LL7tpRuyTswkQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223777>

> From: Junio C Hamano <gitster@pobox.com>
> 
> > From e87227498ef3d50dc20584c24c53071cce63c555 Mon Sep 17 00:00:00 2001
> > From: Dale Worley <worley@ariadne.com>
> > Date: Tue, 7 May 2013 13:39:46 -0400
> > Subject: [PATCH] CodingGuidelines:  make it clear which files in
> >  Documentation/ are the sources
> 
> These five lines are present in the output of the format-patch only
> to help you fill in the MUA's mail header (instead of typing the
> subject, you can cut and paste from here, for example); after you
> are done with the MUA headers, remove them and do not leave them in
> the body of the message.

I was thinking that that was the intention.  But SubmittingPatches
makes it sound like the *entire* output of "git format-patch" is
intended to be the *body* of the e-mail message:

    "git format-patch" command follows the best current practice to
    format the body of an e-mail message.  At the beginning of the
    patch should come your commit message, ending with the
    Signed-off-by: lines, and a line that consists of three dashes,
    followed by the diffstat information and the patch itself.  If
    you are forwarding a patch from somebody else, optionally, at
    the beginning of the e-mail message just before the commit
    message starts, you can put a "From: " line to name that person.

In particular, while the line "From e87227..." appears to be the
typical Unix mailbox start-of-message line, it wasn't clear to me
whether it was supposed to be sent or not:  If I do the obvious
cut-and-paste of the "From:", "Date:", and "Subject:" lines into the
headers of the e-mail message and copy the following lines into the
body, the "From e87227..." line will have no place to go.  And perhaps
it is an important part of the patch, since "git format-patch" outputs
it?

If you could give me some guidance in regard to the "From e87227..."
line, that would be helpful.  (I suppose I should try to improve that
paragraph of SubmittingPatches to prevent anyone else from having the
same misunderstanding.)

> > Signed-off-by: Dale R. Worley <worley@ariadne.com>
> 
> The title looks a bit too long.  For a small and obviously correct
> patch like this, I do not think you would need anything in the log
> message, some of what you wrote below the three-dash line may
> deserve to be said here.  Perhaps:
> 
>     Subject: [PATCH] CodingGuidelines: Documentation/*.txt are the sources
> 
>     People not familiar with AsciiDoc may not realize they are
>     supposed to update *.txt files and not *.html/*.1 files when
>     preparing patches to the project.
> 
> But it invites a question.  Why do people patching Git not to know *.txt
> are the sources in the first place?  Generated *.html files are not
> even tracked.

Now that you mention it, I see the mistake I have made.  I had
forgotten that I did a build of Git from that working copy, and so the
*.html and *.1 files might be generated files rather than tracked
files.  And I hadn't yet learned that "git ls-files git-submodule.*"
would do about the same thing that "svn status git-submodule.*" does,
that is, tell the natures of the various files that are present.

> >  Documentation/CodingGuidelines |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > index 7e4d571..b8eef7c 100644
> > --- a/Documentation/CodingGuidelines
> > +++ b/Documentation/CodingGuidelines
> > @@ -238,7 +238,9 @@ For Python scripts:
> >  Writing Documentation:
> >  
> >   Most (if not all) of the documentation pages are written in AsciiDoc
> > - and processed into HTML output and manpages.
> > + and processed into HTML output and manpages.  This means that the *.txt
> > + files in this directory are usually the sources from which the
> > + corresponding *.html, *.1, and *.xml files are generated.
> 
> Whenever you see somebody writing "This means that" or "In other
> words", it is a good habit to ask if the existing text can be
> improved so that it does not need such a follow-up clarification.

That's true.  But it also appears to be a less risky approach to
someone who is editing the text and does not know its history.

>     Most (if not all) of the documentation pages are written in the
>     AsciiDoc format in *.txt files (e.g. Documentation/git.txt), and
>     processed into HTML and manpages (e.g. git.html and git.1 in the
>     same directory).
> 
> >   Every user-visible change should be reflected in the documentation.
> >   The same general rule as for code applies -- imitate the existing

Thank you for your help.  I will revise my patch (and learning
exercise) and resubmit it.

Dale
