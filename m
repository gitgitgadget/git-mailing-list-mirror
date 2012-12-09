From: "Matthew Ciancio" <matthew.ciancio16@gmail.com>
Subject: RE: Feature Request - Hide ignored files before checkout
Date: Sun, 9 Dec 2012 19:10:46 +1100
Message-ID: <000001cdd5e4$b3e98da0$1bbca8e0$@gmail.com>
References: <000301cdd4dd$f8554090$e8ffc1b0$@gmail.com>	<CAEUsAPaHJ+N0EnxGuVkRqcmY0fUy+4myMiWtd1_vu1vRL763JQ@mail.gmail.com>	<000001cdd5a0$fd23adf0$f76b09d0$@gmail.com> <CAEUsAPaqSQVSNaiJUO3Sfms3Rt2vzsciczXK0impHnXQ52u7mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Chris Rorvick'" <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 09:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThbzV-0005rh-UT
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 09:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386Ab2LIIKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 03:10:54 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:44487 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030308Ab2LIIKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 03:10:53 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so798347dak.19
        for <git@vger.kernel.org>; Sun, 09 Dec 2012 00:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-type:content-transfer-encoding:x-mailer
         :thread-index:content-language;
        bh=EjOWd41ov2FGZ2pGAVA3ClQhdrSxFwdcJpS7yX0V0hg=;
        b=ktsqoc8QUW10WZwRFITU+GVIPlvIW9ZnET5VLRlzyrnh2XrZxQHGlNViBxwANb8e4S
         c0qalOUHI+ApyVi09iSbLi1UuXgl5QI+HrNFVxv+JmZ8TzjYqe2e2I34FvmxM+netwOH
         fte3/4ifRdHYILGzSRFeHSbRDL/ljpIok91/tOqhHwyg4vZULpNyd3nRdV4nN8oriW7+
         P4YvrTzF8tsFcX+GCxXfDMceNGpe6SPaWE2DUA4QWL+TI10d+py0ioMS8P5MjgD1mzjQ
         uEJK37jhIvVqq+pP5euHlQcC/ia+QjkdnFi42W6x908v2gH3tzZUwdl6xH68WF75Dl/Z
         lZ5A==
Received: by 10.66.76.10 with SMTP id g10mr26303790paw.80.1355040652492;
        Sun, 09 Dec 2012 00:10:52 -0800 (PST)
Received: from MattPC (CPE-60-225-40-254.nsw.bigpond.net.au. [60.225.40.254])
        by mx.google.com with ESMTPS id hc4sm9731749pbc.30.2012.12.09.00.10.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Dec 2012 00:10:51 -0800 (PST)
In-Reply-To: <CAEUsAPaqSQVSNaiJUO3Sfms3Rt2vzsciczXK0impHnXQ52u7mA@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHMNWi7KxtTHnq09qgMXBkE3T5YpgFvr262AqeDwjsCP3D4nZfgpTIg
Content-Language: en-au
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211227>

I'm glad we are on the same page now and thanks for bringing in others.

" Not wanting the files in the repository seems to be in conflict with the
desire to have them under its control (i.e., disappear/reappear behavior.) "
Sorry, when I said I didn't want them in the repository, I meant I wanted
them there (in the repository folder), but not within Git commit logs and
not being tracked, etc.
Committing binary/OS specific files just doesn't sit right with me and I am
sure many others.

"... but why do you need them to disappear?  Why not just put them somewhere
where they can be used when needed and left alone when not?"
I could do that (keep them in a folder that will be left alone), but in my
specific case it would mean the executable files (ignored files placed in
this new folder) will not execute because of the change in location and
hence would require a lot of code change to suit.

>From my perspective I don't see the harm in having this as a new feature
(via flags in the .gitignore file, if you don't want to make it default
behaviour). Is there some reason I don't know about, maybe to do with the
Git source code?

-----Original Message-----
From: chris.rorvick@gmail.com [mailto:chris.rorvick@gmail.com] On Behalf Of
Chris Rorvick
Sent: Sunday, 9 December 2012 4:54 PM
To: Matthew Ciancio
Cc: git@vger.kernel.org
Subject: Re: Feature Request - Hide ignored files before checkout

On Sat, Dec 8, 2012 at 6:06 PM, Matthew Ciancio
<matthew.ciancio16@gmail.com> wrote:
> Hi Chris,
>
> Yes, I don't think I have explained myself well enough.
>
> When I say "disappear" I do not mean "get deleted", I mean: go out of 
> view just like foo.txt does, as it is committed to branchB and not 
> merged into branchA.
>
> So I am saying that I think .gitignored files should behave partly 
> like committed and un-merged files, in the sense that they disappear 
> when checking out to a different branch.
> I don't want to commit these files (which would give me the behaviour 
> I want), because they are binary/OS specific and really do not belong 
> in the repository, BUT I need them to run/build certain committed files.
>
> To be concrete: I want ignore.txt to be ignored in branchB and hence 
> disappear (in the same way that foo.txt will), when checking out to
branchA.
> When I checkout back to branchB I want ignore.txt to reappear (in the 
> same way that foo.txt will).
>
> I understand why this behaviour is not happening (because my 
> .gitignore files are different between the branches), but I am saying 
> that I would like to have the option to keep my .gitignore'd files 
> local to the branch they are in.
>
> E.g. I currently have a branch with all these binary files that are 
> required to run an application on my OS, but when I checkout to 
> another branch I do not need or want those binary files anymore (at 
> least not until I checkout back into the branch I just came from).
>
> Please tell me if that still doesn't make sense.

Hi Matthew,

Cc'ing the list to benefit from the review of others.

Not wanting the files in the repository seems to be in conflict with the
desire to have them under its control (i.e., disappear/reappear
behavior.)  I understand not wanting to commit dependencies, but why do you
need them to disappear?  Why not just put them somewhere where they can be
used when needed and left alone when not?

If you do want this behavior, it seems like you should just commit the files
on the respective branch.  Maybe someone else will have a better idea,
though.

Chris
