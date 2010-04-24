From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: Recent documentation patches, and an RFC on terminology
Date: Sat, 24 Apr 2010 12:56:01 -0400
Message-ID: <l2oc376da901004240956o1af1abeoea0e10a86d8ef277@mail.gmail.com>
References: <20100423215448.1EF5B479E92@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 18:56:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5ieL-0001PV-DJ
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 18:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab0DXQ4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 12:56:06 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:44624 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab0DXQ4E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 12:56:04 -0400
Received: by bwz19 with SMTP id 19so319883bwz.21
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=WwD3c0WSh0Z2nW2ChwLU7NWrGiwfjcjDGXLKF9DsZ0Y=;
        b=ZYHCPsvpunRy8dHuC9WAw+If8hp14fgP3r1sOra6oWkTMYUKwcBEgn/CGlCSoxmdfr
         FCRhPUiMUuq1muCPvrSUPndgIbYcbj1jtCxAuE/MJiBfM3wd58cKpWGLuEapoV8ecFWW
         X3L55EGnls8pj2O5kOTETFSv1pkcxbrO7wDlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SwpvLzAOfeK05anZQg6hVmM/zE7OD8z7VwcNyNPqBr4LHltdLaduYlm8/CtvdkEjux
         6kiXFVund6TYVQF4Dk44jiRA9B94vI+DEhIV+D5pmzD49SsbEtyuksJGF+AbPeXdo67S
         GexxSbWxoZtpA1rnOHnqDzMAjgHok81QDaUrA=
Received: by 10.204.38.82 with SMTP id a18mr1017589bke.126.1272128161226; Sat, 
	24 Apr 2010 09:56:01 -0700 (PDT)
Received: by 10.204.71.20 with HTTP; Sat, 24 Apr 2010 09:56:01 -0700 (PDT)
In-Reply-To: <20100423215448.1EF5B479E92@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145688>

On 4/23/10, Eric Raymond <esr@snark.thyrsus.com> wrote:
> I just sent two documentation patches to the list in quick succession.
> In case they arrive out of order: the first, smaller one - modifying
> only the git-status documentation - should be applied before the
> second one (distinguishing between "staging area" and "index"
> throughout the documentation).
>

I didn't get the patch which distinguishes index vs. staging area, but
I did get 'Typo fixes and minor cleanups for the big "index"/"staging
area patch', so I can see some of what it did.

Based on my limited view, I think it makes things more confusing. I'd
rather see references to the index be replaced with "the staging area
(a.k.a. the index)" than long winded explanations like "the index is
the structure used to store the content of the staging area" or "the
staging area used to be called the index".

> We may have an opportunity to improve on the term "staging area".  As
> I reflect on it, I think replacing that with the term "depot" might
> not be a bad idea.  In English this word has the general sense of
> "warehouse", and the more specialized connotation of a place where
> freight is temporarily held for transshipment, or where military
> supplies and recruits are mustered before field deployment.  That is,
> a depot is a particular kind of staging area.
>

To me, "depot" has connotations of transportation.  A depot is a place
to catch a train or a bus.

Staging area describes exactly how we use the index.  An area where
things are staged (prepared) to be committed.

> Since these terms are so similar, why change?
>
> One reason is that --depot would be a shorter and more graceful choice
> than --staging-area as a long-form option.  It has the same letter
> count as "index", so changing command and option names to use it
> wouldn't add more typing.
>

Why not keep index as a synonym for staging area and use --index?

> Another reason is that "depot" is slightly more distant from normal
> English vocabulary than "staging area" is.  When you need a word to
> co-opt as a technical term of art, thast's an advantage; it reduces
> the chances of collisions between term-of-art and normal usages.
>

I haven't seen such collisions causing problems.

Adam
