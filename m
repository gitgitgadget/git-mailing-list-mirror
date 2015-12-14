From: Stefan Beller <sbeller@google.com>
Subject: Re: Questions about GIT
Date: Mon, 14 Dec 2015 08:22:33 -0800
Message-ID: <CAGZ79kYhBh0qLXR3GAFSGKtO3ZLb008G+59tdJbT==kSabiHCg@mail.gmail.com>
References: <HE1PR09MB044194E1689C460D0B1C7D06B1ED0@HE1PR09MB0441.eurprd09.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jack McLear <mclear7@hotmail.co.uk>
X-From: git-owner@vger.kernel.org Mon Dec 14 17:22:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8VtX-0006iu-F7
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 17:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbbLNQWf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2015 11:22:35 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:36316 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbLNQWe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 11:22:34 -0500
Received: by iofo67 with SMTP id o67so48692101iof.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 08:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XHyqOt5FbcvwGqSfCPPwAVUSeAYI6dFh40prJPGTO9M=;
        b=nhcUTzJAhnUhk1PFKRafxuNJgxIoXQmt+PEQkb9SlPR5IHLsxEKKrhzcy2L+smijRI
         X0Ij3lJBuACzBViYln0HEuLPXJUEIEND62duwRJETjLC0kCj3XjwCi2oQfRvLTXX0alr
         +L9rC7eoMmSVNuzKNLtgUkGFo2U7ipWvfhw2QtZX+BJJPM5fmRjU/LpV38J1tZz4CqpS
         d/yYRx+4sa4mt/+/Tbio7ztloaalfjGbrr1fg+2bf1vV0cpx7WnQ4t5c7JXTp55JuYs0
         KzotqzNTgup4vdKfzEYUGEcya2BIawupj0djkeHhqeIAb032tD09QwVRYbCpSCzj9259
         TPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XHyqOt5FbcvwGqSfCPPwAVUSeAYI6dFh40prJPGTO9M=;
        b=ID/PKenTqcJmyuOYrmlYTEkT3xaZ08SXVIfBQrLw8s1iUZkQ9hk6BzcoFjj5d4CMJm
         eC4+D9MpC9VAi5wPGhVRpocWNLeoSqRLLD48kQPeUx4Eljztsdu1ppqGhAt9Wyg3O79C
         iXP7Zqb3Nw1bbUKQDYhP5OkKRYRNg6+OES3FP0j35St1ilfZ40iD1o/x/nGH+d0AHelM
         PJYyx8HFvFOohivo/sBlPLGoaIhw17LhsXDfPJmWPx7g7BKFb3+xVQNTQeDzgB1KLyzM
         pNc4cdC4clPoHU+4PhXdTY8E8HXy5DLOma13UoykqSMyqMsxYHElFHvQEorNgbfD2JZv
         +IAw==
X-Gm-Message-State: ALoCoQk5KUfVU3My9IaZedUu4mkvg3yHG+mJHpm7tcmZe9/SAWl+FFNNqKu4i5CI42uhr609FIxuzS7W3nKbGzjDpprpFg6DJD5jau9aWVCGjgilK7lOtJk=
X-Received: by 10.107.168.157 with SMTP id e29mr29581990ioj.96.1450110154055;
 Mon, 14 Dec 2015 08:22:34 -0800 (PST)
Received: by 10.107.8.84 with HTTP; Mon, 14 Dec 2015 08:22:33 -0800 (PST)
In-Reply-To: <HE1PR09MB044194E1689C460D0B1C7D06B1ED0@HE1PR09MB0441.eurprd09.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282368>

On Mon, Dec 14, 2015 at 2:48 AM, Jack McLear <mclear7@hotmail.co.uk> wr=
ote:
> Hi
>
> I=E2=80=99ve recently been made aware of GIT and had a few questions.
> I=E2=80=99m currently working on creating a middleware between FORAN =
(a CAD system) and Teamcenter.
>
> Do you know if GIT would work between the two?

Git is designed to track any kind of contents, so yes, it will work
with FORAN and Teamcenter.

However! Git is optimized for files which are text. Tracking binary
files is not as pleasant
as text files. (E.g.: There is no merge driver available, as any
binary file has a different format.
Also file sizes may be a concern)

>
> We=E2=80=99re currently using a Centralised version control system.

You may or may not want to change the workflow. Git as a distributed ve=
rsion
control system allows for more freedom w.r.t. workflows, but a
centralized workflow
is supported just as well. See [1] for examples (Just a quick search,
there are many more
articles out there covering workflows)

[1] http://blog.endpoint.com/2014/05/git-workflows-that-work.html

>
> So to check my understanding, using GIT to create a distributed versi=
on control would have the following benefits
> The CAD designer who has design a pump assembly for example could cre=
ate an additional branch and =E2=80=9Cplays around=E2=80=9D with the pu=
mp to make improvements without editing the main pump branch?

Branches are cheap to create. Specially in Git. But other version
control systems also allow for
creation of branches. The big issue is the merging back to mainline.
And in case you have binary
files, which have been edited in both branches to merge, you're out of
luck unless you
write a merge driver yourself.

> Could more than one user create independent branches?

Branches are local. So everybody who has a copy of the repository can c=
reate
branches. Depending on the configuration of the server, people may or m=
ay not
push new branches (or are only allowed to update existing ones).

> If both users wanted to merge their independent branch with the main =
branch, what would happen? Would one take priority?

In case of text files, they just merge if they were edited at
different positions of the file (plus some margin for error). If they
were edited at the same position, you need to resolve the merge
conflict manually.
Binary files are not merged automatically as Git has no idea of binary
file formats. You need to provide your own merge driver[2].

[2] https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
see "Defining a custom merge driver"

>
> Is that the main benefit in terms of a CAD system, the branching abil=
ity?
>
> Thanks
>
> Jack
>
