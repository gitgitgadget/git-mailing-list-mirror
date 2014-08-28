From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Using Gerrit to review Git patches (was: Re: Transaction patch
 series overview)
Date: Wed, 27 Aug 2014 22:07:28 -0700
Message-ID: <CAJo=hJv7+iMHC7rO1w2Hmnq4Ho3W0hwh77Z_gRvY4hzE=VnxGQ@mail.gmail.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com> <20140826000354.GW20185@google.com> <53FE5359.4030403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 28 07:07:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMrwC-0007be-0d
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 07:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644AbaH1FHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 01:07:51 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35102 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbaH1FHu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 01:07:50 -0400
Received: by mail-ig0-f171.google.com with SMTP id l13so7459631iga.16
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 22:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dxyJv431PiOfXHvVz4eLZ8jvbPW7r1zbel5PoiN6Zqg=;
        b=AEPjV0fcVkUjOm95dFgQMstjhDYtYX2Ny2fWjmCoL167wOti2yQkbYe/Cqh4k/9KyW
         SgN4VUQHpL9rtUK7VgswdfO8dhkBMjmcQyQKfriLWfMcSjGUWB+3deCjabG1yL7600aD
         9Q7EU6qztC6jikZewXVabqItcmyKGyyDYHrKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=dxyJv431PiOfXHvVz4eLZ8jvbPW7r1zbel5PoiN6Zqg=;
        b=AdfnFXVrbT6/LGHk4fitE8oqMfNO3SpVAUTU6TO2TAMWCbGTDg9lCy5L5NunzmBWYq
         UoJ/hWSYobLeL1oqUA2ECbVnLXb2MP6uQ4vIhQ/KDR4TWACaE3G3Fyg6kZrdVG/Q+H/5
         j8vzHy3RUbk1fHStOX8Dkdbq+pJkQlLODdAUMLTzlsMlPDlPsdE2sUm8f33sjBljbnvn
         uDm1ZB1l35KmVZH2BXrmiNifrxu1zVUPv5k0W0Z3InxkInZomAXzRGjBYGHsZ4iJvMVk
         qONxi9eycA7bXn4igjtaTt6tyNegjyBWiIUz20hBMVv1qoNcCX4UFCoVfI2rcPFocY7k
         KMvw==
X-Gm-Message-State: ALoCoQkzCXEYav13L/fsngCcdLqaBWoTTjc5jjR4bv+HiAyi+LTxVBd0DohobDxk6JKMfOChIRFT
X-Received: by 10.50.103.106 with SMTP id fv10mr742631igb.40.1409202468952;
 Wed, 27 Aug 2014 22:07:48 -0700 (PDT)
Received: by 10.64.245.164 with HTTP; Wed, 27 Aug 2014 22:07:28 -0700 (PDT)
In-Reply-To: <53FE5359.4030403@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256073>

On Wed, Aug 27, 2014 at 2:53 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/26/2014 02:03 AM, Jonathan Nieder wrote:
>> Jonathan Nieder wrote:
>> [...]
>>> I've having trouble keeping track of how patches change, which patches
>>> have been reviewed and which haven't, unaddressed comments, and so on,
>>> so as an experiment I've pushed this part of the series to the Gerrit
>>> server at
>>>
>>>  https://code-review.googlesource.com/#/q/topic:ref-transaction-1
>>
>> Outcome of the experiment: patches gained some minor changes and then
>> [...]
>>
>> I found the web UI helpful in seeing how each patch evolved since I
>> last looked at it.  Interdiff relative to the version in pu is below.
>> I'm still hoping for a tweak in response to a minor comment and then I
>> can put up a copy of the updated series to pull.
>
> Thanks for organizing this "experiment". I was one of the guinea pigs
> :-) I have wanted to review more of Ronnie's patches (actually, all of
> them!) but have been overwhelmed by the number of iterations and the
> number of patch series flying around in parallel. I was also interested
> to try out Gerrit, which I haven't used before. So I took up Jonathan's
> invitation and reviewed the first patch series in Gerrit. Here are some
> of my first impressions.

Thank you for making this writeup. It contains many valuable nuggets
that we should follow up on.

> * Overall, I found it easier to review commits in Gerrit than on the
> mailing list, especially a long patch series like this one that has seen
> so much flux. It was easier to see the comments from all reviewers that
> apply to a patch, which is difficult on the mailing list when comments
> are scattered over the many iterations of the patch series. It was
> easier to incrementally increase the context around a patch. It was easy
> to use the copy-paste commands provided in the "download" menu to fetch
> the commit that I was reviewing into my local Git repository, and from
> there to build it or investigate it using other tools.
>
> * The Gerrit interface is very busy. It was somewhat overwhelming to me
> as a beginner.

Very astute observation. I have been using it for 5+ years so its hard
for me to see things like this.

Unfortunately many parts of the UI have grown over the years.
Contributors come along and want to add X, months later another adds
field Y. Suddenly we have the entire alphabet and we don't know how it
got that way. Sounds like git reset --{hard|soft|mixed|wtf}. :)

Its not an excuse. The UI should be less overwhelming. Its going to be
a challenge.

> On the other hand, the help menus ("?" key) are good and
> the keyboard shortcuts are convenient. I didn't have to read much
> documentation to get started doing review in Gerrit, at least at a basic
> level.

Yay!

> * During two of my big Gerrit sessions the website was very responsive
> and pleasant to use. During the third, it was terribly slow, like 5 - 15
> seconds per page update. If I had only experienced the slow behavior, I
> would have rejected Gerrit immediately. I hope that the slow behavior
> was a rare anomaly.

This third session was a rare anomaly unique to
code-review.googlesource.com. It isn't typical for Gerrit Code Review.

We have a server set in Europe that was mostly answering you in the
first two sessions. During the third session this server set was
temporarily offline. Requests degraded to a server set in the US,
which pushed us into a worst-case scenario due to a misconfiguration
of our load balancers. The lag you experienced was mostly due to this
misconfiguration, not EU-US networking.

Earlier today I brought back up the European server set, so latency
should be reduced again.

Unfortunately I haven't figured out how to fix the load balancer
misconfiguration. :(

> * Gerrit sends out an endless flood of emails that mostly seem pretty
> useless to me. I wish it weren't so chatty and that its emails were
> better organized.

Absolutely agree.

> * At one point a back-and-forth in a line comment grew into a more
> general issue that was more appropriate for the mailing list. The
> transition from Gerrit to mailing list was a bit awkward.

We find this a bit awkward in JGit too. Our solution has been to
(mostly) keep discussion within the code review context. This has to
some extent forced more discussion to be around specific code, and
avoid wandering off into the philosophical weeds. Without concrete
code to talk about, there is nothing to say. :)

A nice feature of Gerrit is another contributor can add their own
iterations to the same commit in the series, offering up alternative
proposals. Like on the mailing list, this allows someone to just say
"what if you did it this way...", and give everyone a concrete chunk
of code to consider and discuss. Again this avoids wandering off into
the weeds.

> So, overall I found it pleasant and efficient to review patches in
> Gerrit. I would welcome more such "experiments". It would have been even
> better if Gerrit would generate more useful notification emails.

One idea has been to just stop sending automatic emails, and instead
require the author to send a message saying "please take another look
at my series". Just disable the #@!(@(! automatic email delivery that
stems out of `git push ...` creating or updating pending reviews.

Unfortunately there are factions within the Gerrit contributor base
that find value in those automated emails. :(
