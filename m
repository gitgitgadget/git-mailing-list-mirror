From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/2] contrib/git-candidate: Add README
Date: Tue, 10 Nov 2015 15:19:11 -0500
Organization: Twitter
Message-ID: <1447186751.20147.24.camel@twopensource.com>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
	 <1447160198-23296-3-git-send-email-richard.ipsum@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Richard Ipsum <richard.ipsum@codethink.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 10 21:19:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwFOA-0002eK-L8
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 21:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbbKJUTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 15:19:19 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36153 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbbKJUTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 15:19:13 -0500
Received: by qgad10 with SMTP id d10so7869475qga.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 12:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=FlsNV39R9ZySQwejQhd5MPjTKIj4hEUPWj1nYtpDwF4=;
        b=JViWHIrzvn5CkgbO1a/v15SzYeEYa0ajaRtcv2/pTgwoO05ekofpA0vfL1EVyLVFzl
         mWXN30k+V8d1hv9JMKZjljqRL+5NBvgnyQz1ZhBS5qyzqAY3Beefb8Hlae/BHOBdNE53
         lZg89fZDrzuBZ1XSFk10GTaVx8Op7qXCierwblPNt51Zl69jdRr0lNbhwiZz+FrfMLkh
         t1z4OSY5jByCQRu7WagiELBHIC/A8VfcYOW99Gr90ZRs68bVq1FBtCi5nx3j1VQVcmQ8
         ZUg/hk/+E7oveFvuyUtOILk9jOzdOx4eAgaCWoqJAcGvplpZ0Dyiq2kHPSWcWLg1oxB4
         8OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=FlsNV39R9ZySQwejQhd5MPjTKIj4hEUPWj1nYtpDwF4=;
        b=jMa3orQ2T+1FxnFCQ3EO7X7HpLA1h1j0P6RYVixbmeQ4TyStF0GP9Oh8xLSTwOnqA6
         e11DkrGcZ5f51r1Tw8Zd6Aosuaq216dBvUKUl8RSi4u90AuRB24ymVuIjQTcR2q7GC9G
         K5sEkJwY/SVm636FKsDg3k4BRKs+at1fDot472fBO7YcEwJwrWtQqHyoVyLVDea9BXyS
         C98xVcCrjOK6jOqebwg+vvObUE8pxhlj/bnd2SERCEv2tmToONpynIall/BEGabIFWgL
         uqP8M3vQno33FHyESF06Nl8rYPM/1GvCfbQl8PhBL8KdA1KmXL5IJ5aw1YxxDPzAmpQF
         UkWQ==
X-Gm-Message-State: ALoCoQkqHCs+BjVtmGUeup25Cpl63relzpJwjklCeJEFMANFXfgwc7WOF5UFqQiUslZ2YTDZC+f9
X-Received: by 10.140.31.161 with SMTP id f30mr6767257qgf.95.1447186752835;
        Tue, 10 Nov 2015 12:19:12 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 76sm1966716qhj.2.2015.11.10.12.19.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Nov 2015 12:19:12 -0800 (PST)
In-Reply-To: <1447160198-23296-3-git-send-email-richard.ipsum@codethink.co.uk>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281131>

I didn't actually read the code.  Instead, I started with the README and
decided to provide both text and UX comments all mixed up.  These are
mostly my personal preferences; take them or leave them as you choose. 

I'm really excited about this tool and I think it's got great potential!

On Tue, 2015-11-10 at 12:56 +0000, Richard Ipsum wrote:
> Describes motivation for git-candidate and shows an example workflow.
> 
> Signed-off-by: Richard Ipsum <richard.ipsum@codethink.co.uk>
> ---
>  contrib/git-candidate/README.md | 154 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 contrib/git-candidate/README.md
> 
> diff --git a/contrib/git-candidate/README.md b/contrib/git-candidate/README.md
> new file mode 100644
> index 0000000..d2d4437
> --- /dev/null
> +++ b/contrib/git-candidate/README.md
> @@ -0,0 +1,154 @@
> +git-candidate

I have not heard the name "candidate" used this way.  What about "git
codereview"? 

> +=============
> +
> +git-candidate provides candidate review and patch tracking,
> +it differs from other tools that provide this by storing _all_
> +content within git.
> +
> +## Why?

I've made a few suggestions below that you might think are out of scope.
If they are, it might be good to have a "non-goals" section so that
people know what the scope of the tool is.

> +Existing tools such as Github's pull-requests and Gerrit are already
> +in wide use, why bother with something new?
> +
> +We 

who?  

> are concerned that whilst 

Today I learned: "whilst" can be used in the sense of "although" (I had
previously thought only "while" could be used this way, but I was wrong!
)

> git is a distributed version control
> +system the systems used to store comments and reviews for content

insert comma after "system"

> +under version control are usually centralised,

replace comma with period.

> +git-candidate aims to solve this by storing
> +all patch-tracking data in git proper.

s/tracking/tracking and review/ ?  Or something

> +## Example review process
> +
> +### Contributor - Submits a candidate
> +
> +	(hack hack hack)
> +
> +	(feature)$ git commit -m "Add archived repo"
> +	(feature)$ git candidate create archivedrepo master
> +		-m "Add support for archived repo"
> +	Candidate archivedrepo created successfully.
> +	(feature)$ git candidate submit origin archivedrepo
> +	Candidate was submitted successfully.
> +### Upstream - Reviews candidate

What happens if a third party wants to review candidate?  OR is this
just the same as if upstream does it?

> +	(master)$ git candidate fetch origin
> +	(master)$ git candidate status origin/archiverepo
> +	Revision: 6239bd72d597357af901718becae91cee2a32b73
> +	Ref: candidates/origin/archiverepo
> +	Status: active
> +	Land: master

Could this be "Merge: master"?  Or something that doesn't invent a new
term?

> +	Add archived repo support
> +
> +	 lib/gitano/command.lua | 28 ++++++++++++++++++++++------
> +	 1 file changed, 22 insertions(+), 6 deletions(-)
> +
> +	(master)$ git show candidates/origin/archiverepo
> +	commit 2db28539c8fa7b81122382bcc526c6706c9e113a
> +	Author: Richard Ipsum <richard.ipsum@codethink.co.uk>

Probably better to use example.com addresses in the README rather than
real people.  Git traditionally uses "A U Thor" as the fake name.

> +	Date:   Thu Oct 8 10:43:22 2015 +0100
> +
> +	    Add support for archived repository masking in `ls`
> +
> +	    By setting `project.archived` to something truthy, a repository
> +	    is thusly masked from `ls` output unless --all is passed in.
> +
> +	    Signed-off-by: Richard Ipsum <richard.ipsum@codethink.co.uk>
> +	....
> +	....
> +
> +
> +	(master)$ git candidate review origin/archiverepo --vote -1
> +		-m "Sorry, I'll need to see tests before I can accept this"

Are per-line or per-commit comments supported?  If so, please add an
example of this.

> +	(master)$ git candidate submit origin archiverepo
> +	Review added successfully

Is the contributor automatically (optionally) emailed on this? If not,
consider this a feature request for this.

> +### Contributor - Revises candidate
> +
> +	(master)$ git candidate fetch origin
> +	(master)$ git candidate status origin/archiverepo
> +	Revision: 6239bd72d597357af901718becae91cee2a32b73
> +	Ref: candidates/origin/archiverepo
> +	Status: active
> +	Land: master
> +
> +	Add archived repo support
> +
> +	 lib/gitano/command.lua | 28 ++++++++++++++++++++++------
> +	 1 file changed, 22 insertions(+), 6 deletions(-)
> +
> +	--------------------------------------------------------------------------------
> +	1 review
> +	--------------------------------------------------------------------------------
> +
> +	    Author: Emmet Hikory <persia@shipstone.jp>
> +	    Date:   Tue Oct 13 10:09:45 2015 +0100
> +	    Vote:   -1
> +
> +	    Sorry, I'll need to see tests before I can accept this
> +
> +	--------------------------------------------------------------------------------
> +
> +	(hack hack hack add tests)
> +
> +	(feature_v2)$ git log --oneline -1
> +	Ensure the `ls` yarn checks for archived repos
> +
> +	(feature_v2)$ git candidate revise origin/archiverepo
> +		-m "Add archived repo support with tests"
> +	Candidate archiverepo revised successfully.
> +
> +	(feature_v2)$ git candidate submit origin archiverepo
> +	Candidate was submitted successfully.
> +
> +### Upstream - Merges candidate
> +
> +	(master)$ git candidate fetch origin
> +	(master)$ git candidate status origin/archiverepo
> +	Revision: 4cd3d1197d399005a713ca55f126a9086356a072
> +	Ref: candidates/origin/archiverepo
> +	Status: active
> +	Land: master
> +
> +	Add archived repo support with tests
> +
> +	 lib/gitano/command.lua      | 28 ++++++++++++++++++++++------
> +	 testing/02-commands-ls.yarn | 19 +++++++++++++++++++
> +	 2 files changed, 41 insertions(+), 6 deletions(-)

"git candidate diff" might be nice too to show the diff between v1 and
v2.  You might even have "git candidate commit-diff" (or some better
name) so you can see which commit has changed in a changeset containing
multiple commits. 

> +	(master)$ git candidate review origin/archiverepo --vote +2
> +		-m "Looks good, merging.  Thanks for your efforts"
> +	Review added successfully

Is that +2 "+1 because I like it, +1 because I previously -1'd it?" If
so, it might be nice to have --replace-vote so you don't have to track,
"wait, I did -1, then +1, then -1 again..."

> +	(master)$ git candidate submit origin archiverepo
> +	Candidate was submitted successfully.

I don't understand what the verb "submit" means here. Is it "mark this
as accepted"?  If so, "accept" might be a better word.  

> +	(master)$ git merge candidates/origin/archiverepo

I would like "git candidate merge" to do a submit+merge the way that
pull does a fetch+merge.  It seems like the common case.  Also, if it
turns out at this point that there's a merge conflict, I might want to
back out the acceptance.

> +	(master)$ git push origin master
> +
> +### Contributor - Observes candidate has been accepted
> +
> +	(feature_v2)$ git candidate fetch origin
> +	(feature_v2)$ git candidate status origin/archiverepo
> +	Revision: 4cd3d1197d399005a713ca55f126a9086356a072
> +	Ref: candidates/origin/archiverepo
> +	Status: active
> +	Land: master
> +
> +	Add archived repo support with tests
> +
> +	 lib/gitano/command.lua      | 28 ++++++++++++++++++++++------
> +	 testing/02-commands-ls.yarn | 19 +++++++++++++++++++
> +	 2 files changed, 41 insertions(+), 6 deletions(-)
> +
> +	--------------------------------------------------------------------------------
> +	1 review
> +	--------------------------------------------------------------------------------
> +
> +	    Author: Emmet Hikory <persia@shipstone.jp>
> +	    Date:   Tue Oct 13 10:35:00 2015 +0100
> +	    Vote:   +2
> +
> +		Looks good, merging.  Thanks for your efforts
> +
> +	--------------------------------------------------------------------------------

You should include here "git candidate remove archiverepo".  And
somewhere an example of "git candidate list".
