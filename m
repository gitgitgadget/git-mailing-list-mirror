From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Enhanced git branch list (proposal)
Date: Tue, 24 Jul 2012 12:40:26 -0400
Message-ID: <CABURp0qcisya1MEL=2CMpuERjmpRm=PZ_doUurcwa1MQERTATw@mail.gmail.com>
References: <500D954B.4090007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: John Bartholomew <jpa.bartholomew@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 18:41:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StiAW-0006wZ-Sr
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 18:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab2GXQks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 12:40:48 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36665 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581Ab2GXQkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 12:40:47 -0400
Received: by obbuo13 with SMTP id uo13so11344921obb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PeQBUDsXZqBvOGVlsHd+Py8roCdNlbH3PzIGj2Rsar0=;
        b=NC+6AYBNieJWOjObzloeK0goITiicmxefKfJWV8CU/2KJ0NGKzYaNnFIHOKJPSjntS
         a9nigRrXcUsiCPqKGp10yMVlfaqIMC+3/Hq2H0Okh5S/IYpIyoZSZDA0Sq0jDJSRkQkq
         ZLsKMxwBb7Piuuquc8f/uva1Wsr9WAf9+fj6vguCG0h3I+nati3nTlESKqwBhxFTjN3E
         27XVzpHEoJY7es99Sbyjks8Aa2+2tnxKszMpo6dslnNYjwVfrZwojOMHE1fiqNPoq0Tl
         witY5B9hNCzaKz+5F3ljcsWoB/f5xZb0yZ+MMeJQ7teOBQteO2WvAQhJ739uAVzvxtdf
         tPMQ==
Received: by 10.182.212.36 with SMTP id nh4mr28397723obc.37.1343148046605;
 Tue, 24 Jul 2012 09:40:46 -0700 (PDT)
Received: by 10.182.65.169 with HTTP; Tue, 24 Jul 2012 09:40:26 -0700 (PDT)
In-Reply-To: <500D954B.4090007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202045>

On Mon, Jul 23, 2012 at 2:17 PM, John Bartholomew
<jpa.bartholomew@gmail.com> wrote:
>
> I find the output of `git branch' to be quite bare, and would like to
> see more information; most importantly, what the state of the branch
> is in relation to its upstream. For some time I have been using my
> own script to do this. It produces output like this:
>
> $ git lsb
>   commodity-market-lua [behind 'brianetta/commodity-market-lua' by 2
> commits]
>   filesystem [up-to-date with 'jpab/filesystem']
>   fix-ring-blending [ahead of 'jpab/fix-ring-blending' by 1 commit]
>   galaxy-refactor
>   galaxy-refactor-2 [diverged from 'jpab/galaxy-refactor', by 6
> commits/626 commits (us/them)]
>   hud-pitch-ladder [up-to-date with 'jpab/hud-pitch-ladder']
> = issue-1388
>   issue-695
>   lmr-mtllib-improvements
>   marcel-stations
> * master [up-to-date with 'jpab/master']
>   refcounted-body [up-to-date with 'jpab/refcounted-body']
>   string-formatter [up-to-date with 'jpab/string-formatter']
>
> The first column indicates the relation to HEAD: '*' marks the current
> head, '=' marks a branch which is identical with the current HEAD.
>
> Branches which have a configured upstream (branch.remote and
> branch.merge are set) show the relation to the corresponding remote
> branch.
>
> Some key text ('up-to-date', 'ahead', 'behind' or 'diverged', and the
> name of the current HEAD) is displayed with colour if colour is
> enabled.
>
> Arguments can be passed to show remote branches (for all remotes, or
> for a specified remote), or all branches, and to show each branch
> in relation to a specified target branch instead of the configured
> remote tracking branch.
>
> I would like to know whether there is any interest in incorporating
> this functionality into the main git distribution, either as a
> separate command, or within `git branch'. For my purposes I have it
> aliased under the name `git lsb' for `list branches'.
>
> You can examine the script I'm using for this at:
> https://github.com/johnbartholomew/gitvoodoo/blob/master/bin/git-xbranch

Thanks.  You might also find this one interesting:

http://masanjin.net/blog/label/git-wtf/

Phil
