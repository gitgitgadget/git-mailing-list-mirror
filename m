From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH 0/5] ff-refs: builtin command to fast-forward local refs
Date: Tue, 17 Nov 2015 10:36:36 -0500
Message-ID: <CANoM8SXrRmXPZQotQgJNNonJcb3rs5LM=JwOYoh4mX4nw2XB-g@mail.gmail.com>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
 <56431B69.9010007@drmicha.warpmail.net> <CANoM8SV77Jg8qYsn7UZ=a18WvrA_ayAWCnAjN9Tf6Re=r1Ggsg@mail.gmail.com>
 <CANoM8SWxMeDjwy-GwVc+En8D7N8LyzzsBKtX_MbiS4Z49DjD7g@mail.gmail.com> <564B47AC.7070609@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 17 16:38:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyiJb-0002hZ-Bu
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 16:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbbKQPg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 10:36:58 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35865 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbbKQPg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 10:36:56 -0500
Received: by obdgf3 with SMTP id gf3so9384202obd.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0bSHmyRkSEn6gto8d8JRPm+gEgSQBl0NgPX9bEzGm98=;
        b=G5cv1RXWEXtr9c/RBtzbBr5yuNrcfLqINEG0ifa/sQaTeI3zrwNCFYtsOX9KEcu0fh
         W1t8ISkcYJ03g4Q866Ov0VQsxRt4FjgPWrisjID/o2gCLtlLZq8HIoCqvCFlIy3MNiRh
         5mHN8N6m3s+RhPpm0lNAqlQfFxTVNC7liVKCYGFrXvvP2BVliqusm3jeV0cO92d/Y+tl
         4q1IJBYIJq19OSj0cdC/Bc6C+D6ygiirMvw7VL6CKA8zmJP4S5hpsemmpZFHXlEnmPvx
         v2125llCOF1BN5F9WlLq+yBaADN3ODyvoaPu+MuwTiUc0PM6jcBAuA/0w3LNe7KtwIAV
         +K+Q==
X-Received: by 10.182.60.37 with SMTP id e5mr25786406obr.22.1447774615489;
 Tue, 17 Nov 2015 07:36:55 -0800 (PST)
Received: by 10.202.78.206 with HTTP; Tue, 17 Nov 2015 07:36:36 -0800 (PST)
In-Reply-To: <564B47AC.7070609@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281411>

On Tue, Nov 17, 2015 at 10:28 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Mike Rappazzo venit, vidit, dixit 17.11.2015 14:58:
>
> I still don't like the idea of having a new command just for the purpose
> of fast-forwarding local branches from specified upstreams.
>
> What's wrong with "git merge --ff-only" once you check them out? We have
> all the gory messages when you checkout a branch or use the git prompt
> or "branch -vv". And if you don't - how is forgetting to "ff-refs"
> better than forgetting to "merge --ff-only"?
>
> In short, I don't see a problem that this is solving, but maybe it's
> because we use local branches differently, I dunno.

For me I use this command more as a post-fetch:

git fetch --all --prune && git-ff-refs

I imagine that the big difference is in the number of branches that I
maintain, and perhaps in the way that I use gitk to visualize them.  I
would be happy to add another option to git-fetch for --ff-refs as an
alternative if that would feel better than a full-on builtin.

>
> If other people were interested they should or would have come up with
> comments, I think (as a general rule).
>
> Cheers,
> Michael
