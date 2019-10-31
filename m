Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84511F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 11:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfJaLbS (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 07:31:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:47719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfJaLbS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 07:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572521468;
        bh=EWoBAtf1MlD4u0r+NgDfBNlRr2PS0W9Ga/Gw+4SDhwk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fZ+J+sa+G7BJ2G0FpxpBybrNZr9s+eiZjrQRi4vHyj86rbzUoiDBL3W6kQ2s5s3uH
         oU6uhj+1kZNr8Ev1yZcGFxsYbX/hX8POcitxwlUvOvlsnaD5TVFNIFL++9x2AIisJa
         xe0hplTlPDBk239P4kOATbRR71VS9gGuMdKxwegA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VD8-1hsRiI14va-016tbi; Thu, 31
 Oct 2019 12:31:08 +0100
Date:   Thu, 31 Oct 2019 12:30:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
In-Reply-To: <8b9021fa-f60c-a2e0-1174-a2fc1f11c476@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910311229150.46@tvgsbejvaqbjf.bet>
References: <20191030183950.GA21277@generichostname> <20191030202835.GB29013@sigill.intra.peff.net> <20191030224328.GB44961@generichostname> <20191031061832.GA20830@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
 <8b9021fa-f60c-a2e0-1174-a2fc1f11c476@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gffMOfHTddt/hu+qK6DF5CYBWaQpKQXyDaIw8iAuTN+4IIjemh7
 NW6uT+/y/+FlF2s6hc2nYoh0ZfJscJYaCYdA/a7014xBZroKkl2pUwyr3Ks9r3pMpo48J4S
 ODJ4yVjB5BBLrcVX47BHQ1CftLmBJ1g5uYM6p2lX6+pDKcFp21sqcjkfIfrKKkxziw40NQn
 je+pad9UxDLRoulu9db+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GKYhUksJQxU=:hOhPFdSbadAGvmH7Z8Xrk0
 HQoE8V+KozY7h/51O9AiI/zQBuI2cqrTqSozRNLdyrAjklDpzaFc/6jn4lxDLAqnKE63KuEYa
 zNy9LIsGRdZ3s/f/Xuf/JTVsje0dj+2Be9L9B3Yr3p5ouR+xmY9za62GJ+7XYW54wcyYcvh77
 77PJ018ZKlsWZVrIHXbWV5oChE+vt3qbpoxQH3YBkM73UEBrhrm0o/2u2Mm06iq42p8XJsVl+
 LbnUhJeG8ycmPreWiyHh4yf5zVCe9nH4oGB4et1eapYtwjv7DS3O0yPOBgQw5oN9dYMJBWcb7
 qHpZqdjD7f8m0VKONR2TqtCIU3WUonFsJoM3eKkRD/PiY9rDRRmPd0evCoExzCV1gvOCVXh4X
 DUrt/ukfPOxTFTkaglxcw/8Ch71JnHo7s04uslI2bGbqPdTI2WfxLb2Jd48A0M8tdvmgEni8c
 kr8zEasUW46jUlf2LdRdjG3mUk8k/ood0QzjNkdC8fun6BM77B8yvLUOknp4uLiAnrjp5n912
 /cAap4XY5vKFL0ke/R9y90Z4QHytJ5qcu8WfcfjDQGLSFIAMWKqzs/9z42QJjCx1HzmiLgphs
 B8JMc6MWQ8ASnk5d8ErL9iTbnzLKrnZikKGUIqSrCLFWmdb+bU7sA+YI9S6I0t0kXnQW4L3ZO
 JtQfvSo8uXd371wsKMn/8U/fTJ80vuJjlWfWwj52Cx7KRrXxUl8ExwgaZS2clEvpdwgV6DDNj
 2sc7DZJnfUTQ35+DAgDjKeXUfidgbXUUYs8ntOSl6ABJod0MQWWdkDzWZiJ169jMrV88Ix+xO
 yimwQ+bejXADqrYR9GFzA2r3R0ka+FxvVxOTuLJUI4CcMEPqUUlnea8BAn5uXRwm/hYNJHHL7
 WjUyYqExest4mj2eJkmXqv+7iiBc++kKv3SNMCGzIZgGFBhIIvLbOZGDeqgrB+4rBqoeWFnHu
 E17Kk3+UFmspaKYnQ5ukG33TnTkuE9Si4K3IPUeGKG3/Bqgoiu9b3t0n5jGhBQLCrXQrmm10M
 do7YNz7aF/AP+R7nt3s7QIvnEftp9rJ2HKLo6/+P7SYk6GAzSPNOvRUw7n7ej6yhc3h5up9bi
 hzNBiN6npG+WYU6XTZ3YxGPdJ2Z5FgJbmxyKZOoVQtkYekbsmuBWvzdVV1YcjO8xZLGciCtL/
 KjzP2S+KOahUFSgFiu4l46yiFTSUXqk9YcJQo+0T4TQVsjP4q1p5dDorbEQl2/WRh2xNgHcD+
 NBeANk3tE5jzib373n3rx8ZfPw0j1/QUyhxZBguVu7ak3IfHdisc00GPl0AE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 31 Oct 2019, Phillip Wood wrote:

> On 31/10/2019 10:22, Johannes Schindelin wrote:
> >
> > On Thu, 31 Oct 2019, Jeff King wrote:
> >
> > > On Wed, Oct 30, 2019 at 03:43:28PM -0700, Denton Liu wrote:
> > >
> > > > On Wed, Oct 30, 2019 at 04:28:35PM -0400, Jeff King wrote:
> > > > Dscho brought up in the GGG thread[1] that perhaps we want to trea=
t
> > > > branch descriptions like notes and have them all under something l=
ike
> > > > `refs/notes/branches`. This would certainly solve my problem of
> > > > having versioned descriptions and it would probably do it in a muc=
h more
> > > > general way than having a versioned included config.
> > > >
> > > > Anyone see any potential problems with this approach?
> > >
> > > I don't think it would be `refs/notes/`, as that is assumed to conta=
in
> > > mappings of object ids (and if I understand correctly, this would be=
 a
> > > mapping of branch names to data.
> > >
> > > You could just have "refs/meta/descriptions/foo" pointing to a blob
> > > which contains the description of "refs/heads/foo". That makes it ea=
sy
> > > to edit descriptions, even if you don't like using "git branch
> > > --edit-description".
> >
> > The only problem with this is that it's not really versioned, as it
> > would be hard to go back to previous versions and/or share the history
> > via pushing to a remote repository.
> >
> > But I guess that a very simple pseudo branch would do it, where
> > `refs/meta/<branch-name>` would point to a commit that has a tree
> > with a single file in it: `description.txt`.
>
> Having some way to share branch metadata would be nice. I like the idea =
of
> using commits so we can merge changes and revert to a previous version. =
There
> is some previous discussion here [1]. I'd really like to be able to shar=
e the
> upstream for a branch between two computers as well. I also use a commit
> containing a tree with a single file stored at refs/todo/<branch> (and f=
etched
> to refs/remote/<remote>/todo/<branch>) to share todo lists with notes an=
d
> ideas for future commits on branches that I'm working on on more than on=
e
> machine. Having them version controlled so they can be merged has been u=
seful.

And while we're dreaming: it would be nice to discern between "push
upstreams" and "base upstreams". Example: when I work on the
`fix-t5516-flakiness` branch, I target `upstream/master`, but I push to
`dscho`, i.e. my "push upstream" is `dscho/fix-t5516-flakiness`.

Ciao,
Dscho

> Best Wishes
>
> Phillip
>
> [1] https://public-inbox.org/git/1519324188.6391.156.camel@mad-scientist=
.net/
>
>
> > I now like that idea a lot better than my original notes idea.
> >
> > Ciao,
> > Dscho
> >
> > >
> > > You could also have "refs/meta/descriptions" to point to a _single_ =
blob
> > > with all of the descriptions. It could even be in the existing confi=
g
> > > format. And then you could include it with "[include] blob =3D ...".=
 That
> > > doesn't exist yet, but it would be easy to add (it was something I h=
ad
> > > always considered when writing the config-include code, but there wa=
s
> > > never really a good use; and you do have to be careful about pointin=
g to
> > > untrusted blobs). That's a convoluted way to get where you want, but=
 I
> > > wonder if integrating to the existing config system would have any
> > > benefits. I haven't really thought it through.
> > >
> > > (Of course that's also only one step away from having a versioned co=
nfig
> > > file in your .git directory, but it might possibly be a bit easier t=
o
> > > manage, since it would always be committed).
> > >
> > > That's mostly off-the-top-of-my-head rambling, so please disregard
> > > anything that seems totally off-base. :)
> > >
> > > -Peff
> > >
>
>
