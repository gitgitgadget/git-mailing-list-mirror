Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE78207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 21:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034333AbcIWVNZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 17:13:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:56081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965453AbcIWVNY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 17:13:24 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lbuo0-1b4Lak2nnI-00jIH8; Fri, 23 Sep 2016 23:13:19
 +0200
Date:   Fri, 23 Sep 2016 23:13:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Haller <lists@haller-berlin.de>
cc:     Stefan Beller <sbeller@google.com>, Kevin Daudt <me@ikke.info>,
        Anatoly Borodin <anatoly.borodin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
In-Reply-To: <1mu0zrn.cs3kf31kttpjkM%lists@haller-berlin.de>
Message-ID: <alpine.DEB.2.20.1609232305590.129229@virtualbox>
References: <1mu0zrn.cs3kf31kttpjkM%lists@haller-berlin.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u7adewc50HEBDYs1VHDkFbjFpvnZA0RN3enDo0jmgGVgZgPn5RR
 1VbEmjpSYZhEa4/nFOkFHBnDzMctRCiI8r6+naoO8jNAgZhhvtBHQ+z+iJ/gXkhRsCMKdLX
 nmV0qB+YMYR0Go5aH6MnQwM406Fcrwzc+86JwxZWBKeaLxQlnDby9OIdr+vvgYHyu5fk3Cp
 vW7dW6veybRmeCtDxSVKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8zBN815Yauo=:GT586sZEdowYNELsRfxdMV
 e5EO10pWABsKc5KFuFUdKS72c7RZTHkqnrcGFZ0MPd/qfKQF3GzE8wF4WX89448kSk7J2x5ji
 u26vyJ1ly4HF7TyucQ9uEjZPcBtGdsRdffEb/wl3jnqTsuLZX1xScKyxHTBEdHu+8q6MoFY6O
 WILDqKZFPVZ7LwLf6v5vCdeFnuMDp2/F242Ci+FMkX8jH4dXRwmSZ+x0zlni6Su5mil+ZUSQH
 RT/4M/sJmD2PeLrloS8zcFKYInKcD7mTA+RMLnXwYiLGcjJJ5pbn4XC9lgu7xIka6m/M5k1Or
 bk6yPZZI338GcOPiXdpiUsOUm5UNh2JYaVbKNxGu4/u2rfgjYuLuC8hdVzq6YtHuwupboic7O
 m3JtxdsckPI8+2brMJ5AgCSxSNGP5jqDWK6wqJjzaKkeLM3P2qq3SGBIWF9RA2jYlEf6+ePNe
 c18h0HkQUmp3HbbaXKSzcz7MyVzaSyv9Y5ImIVbO8aLUIMa8Zx15iO56h5TzQC/S1ST4FNEd9
 eTLhBUWLjZWSO3kbGgsDeEChoNZcBcswaT8aYvzizt2eOobtCDbY7dl5nag8cNloIXsjofR+G
 1XDen2as5UJ6TwXuV5S3a++L/8uEEzZLjz/I5b3kFtaB0JrY5AA3VX63FH/zt+Mj+EF9lk8Cn
 w6uj6BjAIO6NB1oZ/6Ea71l/BeP71u6O3Yv00IK6mgX0Q7n+qyxVYqQo9zUWLIXGIUDhuO8H6
 jPJd42LUb9VvOXnI84FXNWbVo74yX0XVYQ8wpBlr9C135ihVCPqNE7vvK1zCtACtqfMkVxEwf
 aBNPneR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 23 Sep 2016, Stefan Haller wrote:

> Stefan Beller <sbeller@google.com> wrote:
> 
> > On Thu, Sep 22, 2016 at 12:48 PM, Kevin Daudt <me@ikke.info> wrote:
> > > On Thu, Sep 22, 2016 at 07:33:11PM +0000, Anatoly Borodin wrote:
> > >> Hi Stefan,
> > >>
> > >> this section was added to the manual in the commit
> > >> cddb42d2c58a9de9b2b5ef68817778e7afaace3e by "Jonathan Nieder"
> > >> <jrnieder@gmail.com> 6 years ago. Maybe he remembers better?
> > >>
> > >
> > > Just to make it clear, this section explicitly talks about 'bugs' with
> > > preserve-merges and interactive rebase.  Without the --preserve-merges
> > > option, those operations works as expected.
> > >
> > > The reason, as that section explains, is that it's not possible to store
> > > the merge structure in the flat todo list. I assume this means git
> > > internally remembers where the merge commit was, and then restores it
> > > while rebasing.
> > >
> > > Changing the order, or dropping commits might then give unexpected
> > > results.
> > >
> > 
> > The commit message may help as well:
> > 
> >     rebase -i -p: document shortcomings
> > 
> >     The rebase --preserve-merges facility presents a list of commits
> >     in its instruction sheet and uses a separate table to keep
> >     track of their parents.  Unfortunately, in practice this means
> >     that with -p after most attempts to rearrange patches, some
> >     commits have the "wrong" parent and the resulting history is
> >     rarely what the caller expected.
> > 
> >     Yes, it would be nice to fix that.  But first, add a warning to the
> >     manual to help the uninitiated understand what is going on.
> 
> Thanks, but all of this still talks about the issues in very generic
> terms ("most attempts to rearrange patches"). I'm interested in more
> details as to exactly what kind of attempts do or don't work. In
> particular, I'm interested in fixup/squash commands (without reordering
> anything else), or dropping (non-merge) commits.
> 
> I could of course experiment with these and try to find out myself, but
> I was hoping someone would just know the answer off the top of their
> head, saving me some time.

The fundamental problem here is the underlying design of bolting on the
"recreate a merge" functionality onto the "pick" command.

That is, if you try to rebase non-linear commit history, it will still
generate a linear list of "pick <commit-name>" lines, as if it were
linear, except that it will include the merge commits, too.

It then will try to guess what you want to do by recording which commit
was rewritten as which commit. And when it encounters a "pick" with a
merge commit, it will try to merge the *rewritten* commit.

In other words, the design does not allow for changing the tip of any
merged branch. Not reordering, not dropping.

And I do not think that there is a way to fix that design. That is why I
came up with the Git garden shears (see the link I sent elsewhere in this
thread).

Ciao,
Johannes
