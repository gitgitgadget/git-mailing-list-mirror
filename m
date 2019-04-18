Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3067020248
	for <e@80x24.org>; Thu, 18 Apr 2019 10:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbfDRKD2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 06:03:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:53213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDRKD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 06:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555581800;
        bh=SP+3Up+9wOK07bvQvOLGR3ZswhYU4BS1DKz5Erckbl8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QjA7f/CDUBwirZyCMJN6NrNZMSl4nD/PkVc9e0YUcYd9Z5H8E6mf2ySk3xOxWvlbf
         vPgEgOUTVN79RMMAzCzt7+b09t9ftE+spocH8mbPEINPjX8TsQH2LzvXx/Tak65gwJ
         2fbNVq7TSqSXNGmqHEvnZbF/SOTATpzwbh4eingk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8m7Q-1h7Byu1zwq-00CBjz; Thu, 18
 Apr 2019 12:03:20 +0200
Date:   Thu, 18 Apr 2019 12:03:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 00/16] Add new command 'restore'
In-Reply-To: <xmqqa7gojggg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904181201180.46@tvgsbejvaqbjf.bet>
References: <20190308101655.9767-1-pclouds@gmail.com> <20190411131218.19195-1-pclouds@gmail.com> <CACsJy8A9xfR7FheOHUoywNz_D7W1X1fv=mUBz-uu82CGZqYfVA@mail.gmail.com> <xmqqa7gojggg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-471645941-1555581806=:46"
X-Provags-ID: V03:K1:mtVaawEJgFn8HlD2kjQWDEptDmXzE8zztd7V8fRSs502+zfeV9/
 Haaa6Tzczy/uokTjNfaQ58wjd7gxB2Qrs+g+DDLVxZ0nb9nARGpWi+s0I8E4ThaSYytNfZ2
 VVGVvAg2bEOzomy2Ey+P8yP6FiocomItfSJHg2/dolFgk+pdMQ5u1gqNqw7INT95KzcSkI0
 Oa9OJRlXfcsN4uH966tyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dBYJ68nkfe4=:4wNdqrP/jOn8fNy0s09GU+
 izDlneBMQ6Zf0B/WU7xNJaKgnBOtXmenMd0wD87uZQicfY/Wyq6/EANUCZA36v90nInjE38Qj
 yrm6FrrGQxlhQMZQe0pwWSCMvH38AQkKlSQvmUngdtcnK2DG/xUyXsQOFugrU47Xmh24Sq3kv
 Uj7SmZM1Is3DV/CcB0AyYtpptHJa+x1aN7B99Z5bPNxsoe+3QnXQe5DpKDiGLLM/jW1mdbOik
 582mVmkgiXr5P35I1azbKV/WPO88uNR08543ycBeTQXEUFiazl5PrTroE8orXamrByyW4jKJ4
 K3ZBPkiB3EUW20TUqkZw2534hOqLCoEuEHvJNFuIsVLclAm4wr7cZaUvrfV8vl9P6Xs42yjAX
 chQ4NIgfANfXIMJlHmUN9zO3bWmel34qWMbvha9xnZ8GDS9qKnaTXQDiSj3Ji9ZAZMc6b/B9W
 h3yPat8BZ1nwXiYIh9EKCitosBpazaivkGyRg4Gpx/5VZgWNO1zT6REtT4J5vXBsqI5FVYqfZ
 I3OmahX4ADx3/mHGLpIbXav29CS1QWRwpFd/PsYS9wBVqG77K/om3f1B9DFJjXnM7wV0p7dKI
 mrEzznmAgtov58mkJXCDGXU8mHtGP9G+kfzpa60Pi0TId6IfWXnJ2jCL2foejYQY/3X+PswWh
 MDPSitM56aL2X4eRINkBXWZiIwt7mQdJMNoI4qpg3/UG7m0cToQChmx5O18LEldjb88f2p/Vm
 oqxWf2p055ftSDoigztZ5+XqZ/W8tVVGeVAD0z8lYVGFRze/hc6LmXzJbviniAXddQoG2OJ+C
 jsUF6BBGCvq0OsjPF0HM1u7gZzeozeEerORjAMJ8mi3ib3wnnbIA/o3JOynDoVBOxSSoQ9jUT
 qXmiUS23MjooQVHE2bhmeNmEbxnyedKlv4eus0rcnKLDDIH+z1Sznpn2uOnVRiln22XnWFqeS
 4B6R7HeQfqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-471645941-1555581806=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 18 Apr 2019, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Thu, Apr 11, 2019 at 8:12 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> >>
> >> This is the companion of "git switch" and is based on that topic.
> >> This command peforms the "checkout paths" from git-checkout, git-rese=
t
> >> and also has a third mode to reset only worktree, leaving the index
> >> alone.
> >
> > It does not have to be done now. But I'm just wondering, does anyone
> > think adding --dry-run is a good idea? This command is destructive by
> > default, so careful people might want it, I dunno.
>
> Yeah, "give --dry-run for anything potentially destructive" may be a
> good general principle, although we'd need to know where to stop.
> For example, I am not sure if "git reset --hard -n" would make all
> that much sense, as the sole point of running "reset --hard" is "I
> made an unrecoverable mess---get me back to a clean and known state
> no matter what" and in that context, "let me see which files in the
> working tree will be removed and checked out of the tree-ish and
> which paths in the index records a different blob than what is in
> the tree-ish, before deciding if I still want to stay in the
> unrecoverable mess or I want to get out of it" is something you
> could request, but at the same time, there is not much point in
> actually asking it.  Of course, a --dry-run that is not used often
> simply because it is not all that useful in practice is fine to have
> as long as it works correctly---I am saying that it's not something
> I'd personally prioritize myself.
>
> It would be an excellent addition to "restore-path" (and also to
> "checkout [<tree-ish> [--]] pathspec") to give "--dry-run".  Not
> just because it is destructive, but because unlike "reset --hard",
> it is selectively destructive.  Having a way to make sure that the
> given pathspec touches only the paths that the user intends to
> recover from the tree-ish or the index would be valuable.
>
> But it is a new feature, and I'd think it can (and probably should)
> be done as a follow-on series outside the main series you have been
> working on.  Let's make sure that we have the basics ready by the
> end of this cycle.

Since this command is supposed to make our not-quite-user-friendly
command-line interface a lot more user-friendly, I think that we should
take a step back and think very hard about a way to make this recoverable
an action.

The recently discussed project to make `git stash` handle unmerged index
entries should be a good step in that direction.

And I do not think that it would make a lot of sense to advance this
feature prematurely, i.e. without this safety hatch firmly in place.

Ciao,
Dscho

--8323328-471645941-1555581806=:46--
