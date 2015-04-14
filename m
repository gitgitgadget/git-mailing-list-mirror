From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: When and how to to contact the Git developers (gist)
Date: Tue, 14 Apr 2015 13:38:30 +0200
Message-ID: <CAEcj5uUzGfqCUwR+bEjDCF4W8+oL5TjbfBFfG6xRgPUn94Ktvg@mail.gmail.com>
References: <CAEcj5uW2Shh4QvtmenW2h6KXYUCoEe5bHYNv_HVFQgUit=cJ0w@mail.gmail.com>
	<20150413211002.GD5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 13:38:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhzAr-0004R3-Pv
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 13:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbbDNLie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 07:38:34 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33007 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbbDNLic (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 07:38:32 -0400
Received: by lbbzk7 with SMTP id zk7so5808678lbb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HIylGALv6NmWb6S7Qrm0NmqQawM0mOorTfICwbBc9v8=;
        b=H6IGUtHd+XRhyh17Qb8YxoCshLkNK07J2m3DFoKhHIwVAQXGxXKqIECUB8se63fP6z
         5g0YS3Kl8+PebG3FcVgMDU9bF8naPobz0tv5k48+Fx4L4Y/ZyFdq1+z5FtrijrokzKIl
         QLjcSA3dADGsq44C6DVOa6LYgDI1l1LbJh57VeJJyOCPkpfZxVUnXl1efjdmPyTwgDKN
         q/TtsR1JrJwb6Y5a4GzKIYhNy+L/lk7pqOmuPczJitt1k6AkkY7Xp6YVOn+DFZW+NsJ8
         Hatdob8cPOaTEx4ykqHnMig8QXnMuyhKRhMMWpE8sT+8uG8pt/DoqIqGUvB7llxN3l5K
         4zCw==
X-Received: by 10.152.2.130 with SMTP id 2mr17437808lau.120.1429011510454;
 Tue, 14 Apr 2015 04:38:30 -0700 (PDT)
Received: by 10.25.159.10 with HTTP; Tue, 14 Apr 2015 04:38:30 -0700 (PDT)
In-Reply-To: <20150413211002.GD5467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267136>

On Mon, Apr 13, 2015 at 11:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Thomas Ferris Nicolaisen wrote:
>
>>              Perhaps someone here would prefer to use my gist when
>> redirecting people with "user questions" away from this list, or
>> inspire them to write better bug reports.
>
> This won't come as a surprise given what I said at Git Merge: I'd
> rather we don't redirect people with user questions away from this
> list.  The current volume has been pleasant and manageable.
>

I see your point. And I do see this working out well for freshly
created open-source projects with low traffic mailing lists.

However, this is a high traffic list, and that has the disadvantage of
blending user questions into a majority of patch- and expert
discussion.

This makes it (a) harder for the user needing help to recognise
existing contexts, and (b) harder for "amateurs" like myself to spot
other users that I can easily help out.

And then there is the whole Majordomo blocking emails for various
reasons issue, HTML being one of several, ref
<http://vger.kernel.org/majordomo-info.html>. Here are some examples
of when we tried helping people on the Google Groups user list with
sending mail to this list:

https://groups.google.com/d/msg/git-users/iiNBWq3_uUs/ke2eDiumPEsJ
https://groups.google.com/d/msg/git-users/eT_UDv7TpjY/CfYE8jHQ_vYJ
https://groups.google.com/d/msg/git-users/qibnKchBf6I/UPtv1_Ctxm4J
https://groups.google.com/d/msg/git-users/4KXBwBXNd5Q/4yuBELlc8lUJ
https://groups.google.com/d/msg/git-users/Tl141kCJ45Q/-ToWHYfdmXEJ

And then there is the mental hurdle: I mean, I still consider it
intimidating to send mails to this list. A new user could in some
cases be terrified.

My personal reference are Apache projects: they always have one
dev-list, and a separate user-list. The key there is that the
user-list is adjacent to the dev-list, and all the devs (who are
interested) monitor the user-list closely.

So I'm historically/personally biased towards the dev/user split.
Perhaps you see this differently, and it is up to you (the consensus)
to choose what kind of traffic you want, or which behaviour you want
to discourage/encourage.

I'll also note the trend of how modern users are becoming less and
less users of email, turning to web-based forums instead for
assistance, and I enjoy the fact that Google Groups is an alternative
that offers seamless web- and email-based interaction.

To summarize: I think that usability problems of Majordomo have lead
you into a situation where you could consider embracing a user-list
like the one found at Google Groups.

Unless, of course, you believe that the users that make it through
here are a good representation of your user-base, and they provide
just enough input for you to steer the project forward. The rest of
the users in need of help, and I think that is a vast majority, will
find another outlet.

My own motivation is that I want all Git users to figure out their
problems as soon and as efficient as possible, and directing them to
the Google Group seems to be the best way IMHO.

> I especially disagree with
>
>         Generally speaking, Git has very few bugs, and if you're not
>         sure what you are doing, it's probably a user-issue, and not
>         an issue for the Git developers.
>
> User issues are an issue for git developers.  The hardest part of
> making git work well is getting it to match how humans work, not
> getting it to be technically correct or theoretically bug free.
>
> So if I were writing it, I'd drop everything up to "If you believe
> you've found a bug in Git for Windows".

I've removed that sentence, and reformulated the part below. I'll keep
the link to the Groups list and StackOverflow for reasons mentioned
earlier.

> Another alternate forum to point people to is #git on freenode.  It is
> reachable from https://webchat.freenode.net, so a person seeking quick
> help doesn't even have to set up an IRC client.

Thanks, I've added this.

> It might be nice to add a note to the "If you can find no existing
> discussions" paragraph: if there's been a previous discussion, it's
> fine to raise the subject again.  A good practice is to link to and
> summarize the previous discussion so people can learn from what has
> happened before.

OK, added.
