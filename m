Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EDEC1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 08:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfJDIxN (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 04:53:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:47425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDIxN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 04:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570179188;
        bh=cUGhtLeTx3htM8ePi8IPLMz+hll/+wZ7KcAUCc8v1R0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QbNh2azs6kT8aKQuGzqacSOef3Fgc+hN1ZVcS1ieUNLSApgq/1P7p/hAUeUH86Mkd
         kpGawod3nEHB6DD4Y0YomqcMKF5AHJpvLUFZ5nnG4mKRfkeQmdG0X5N1uAVV2U4BfK
         WPzU1qTwQb68CTyusXbS1BT15XO+uhRP014gbcDE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.189]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1htRMF4C7I-00wY2y; Fri, 04
 Oct 2019 10:53:08 +0200
Date:   Fri, 4 Oct 2019 10:52:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     gespinoz gespinoz <gespinoz2019@gmail.com>
cc:     Philip Oakley <philipoakley@iee.email>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [Outreachy] Outreachy internship program
In-Reply-To: <CAP_ANikQDyYWKNtfTdH0NMzF5s3=JPzqyiq+ibz98vvb095fDg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910041051370.46@tvgsbejvaqbjf.bet>
References: <CAP_ANik21_mkUdqwd0YQS4VDa80AnqQ+Xa1jWsQ7ihnfyQymYw@mail.gmail.com> <CAJoAoZkq1=VfJ05J8L2AvJjp6GxoTNTF6pNFAzQ1rx+7LKk6bQ@mail.gmail.com> <CAP_ANinzBvysKE6QWUinmNzcvKqsRv10VSjFGChoK-0Nz4KT7Q@mail.gmail.com> <CAJoAoZ=5aK50T9ugMww9Po0whFUSfOYY4djVhUvCU_azn2SABA@mail.gmail.com>
 <6f993a81-9bb5-9d57-0876-45fb2f7e2705@iee.email> <CAP_ANikQDyYWKNtfTdH0NMzF5s3=JPzqyiq+ibz98vvb095fDg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1317389376-1570179188=:46"
X-Provags-ID: V03:K1:JETukfmq7vYxAUbp4xF4EFiU7EIuyOwXa1JW3yWOIM7O+JXL3Tq
 gTp8ZkkTgJVqjN41guRehcr1GhrOgY9kPsf4ibpiCXp3arXx0RIxVAq29ykoVj5sAhIcrTh
 o0hXlCoqm5uQV2lqhJXE03Ts7DMzqRTJTgevxGXSb8FSMqbKNn14NuSz3ZEn5eU9nAvs0s5
 vLbGOG9HdnXULbjsT94Hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cqvHL9PGa5I=:3fjHve6hah9EwXyb1kJQAq
 6k051maJ1FsvQNWNDZVGrAUrmvv8AdgRZJv5nDK9cQ52VVn/OJaI6ifMoxmKvVxtTUWl6j357
 9ZSRDwUCs/iqTbHigNV8R8MMHd5HEnuU8pexPfakqiOhDqdmOKIajKnW1JrAta4/uLYiNoESW
 qVCrD8h/hP1/TV8xg3l41Sp/5ONrto/A5DkJ4tGXtAN/E+aU4e4CGv8/CRwRThB1MbeVSBJUq
 EpNQn+AaJ5enIRiTBc0V1k+sGBpPDzuRwtC+PaX9Bhebk2Kd3B5KUlvMIuvIppsn09F+00PsE
 lNGd8oWbIHhz7naGtygw/23rNOTTq7Vj1rpA2QCFHqB5R7CKkwAcdoIWKLCQMR/S8EaqAZJim
 kx8/VhgXkoGuQmmsgrgNCO21TmeVpf8KsuXByMckUP/cDs01Xtu3xF0M3BKMlQCsdJmb+99j6
 DjN9lQLz6HbGMlusgZN8Z6ht5ShGJ/Za5cPMd3cHn0OdfIH5Ve4wpDeYdyEE0uLmnrgn09Rdn
 Ur7foi+48nGEZW0yJBrvotkEfDOKWayOeG/A2UrROnD7nyiUxOXGSRi9tVNkvsZUulBkqOYb4
 DLqqWhEIx/70sE7/Jy8Qybb4guSKSmUKsxEnFPg70fDv7yDAwypepjQpUlPQKWaAS8pPY+Eax
 fyGd7xvV0qf1XiSQ1f9GY1OkpAjCeOAyDSrY5Sb98NKZXwMLQc8yRnkV/zXMGerj3bZv28Vqf
 aTRLtq8EcS7iSAJOd0ZtrXpDogsyXHqLDHlpxtVc1YB210Pe3e+UQv6DvNCq5sLCcu92sJjE5
 NviJndo/A6mb/9b65wVZLGyYRlj6p7ndFmI6d488GyNAvSE1CEyoxDaHBxJe7xy92yYoL7ujY
 123IjAa3Ws/++jDUPvrGD7XuwxvCqPFdhBXt2WK81XWIjncAo4ajFfS9hY9f+mSBzbcVYfkLk
 lqyZBByA53DPtNLeJKLHQ9cGSh7Y038wPx5AYGT9StKnR0AEM14CWUNOQ3It6ifgS8nrErcqM
 7xpSMTm+3+uYfOIPRMf3tV/looEUfnJEkXnduHy5gYitbwYzljN31X78W8jXLT7DEnfiGx4jU
 39N5mMeHJpDhLj8uBzFPjrgomMWAkQDepQATY4+6V1pHRq5dTcfJLdTt4O5UTHdHilwRJjlEh
 RUrvJQrkBnnxajgwCwb4xST+RhjrCloJj58Wsw2YlABWXOa5kn3UZ2g+9YpXwPG0A3areFrmo
 6Bow9vkcWJRSGKLQoZh0wxoQpD+3Y9lw97t8xz0mLgA8JxvnA0Zh3uVFGvSg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1317389376-1570179188=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi George,

if you have Visual Studio, you could also check out the `vs/master`
branch of https://github.com/git-for-windows/git and build Git inside
Visual Studio. The tests can still be run in Git Bash (the regular one
this time, no need for the Git for Windows SDK in that case).

Ciao,
Johannes


On Thu, 3 Oct 2019, gespinoz gespinoz wrote:

> Wow! Thank you Emily, Johannes and Philip! I was about to reply to Emily=
's
> email with a step by step rundown of what I did. I downloaded it here
> https://git-scm.com/downloads
> but I'll try out the solutions you have all offered me and get back and =
see
> if make will work with the full windows SDK. Once, again thank you!
>
> George
>
> On Thu, Oct 3, 2019 at 2:53 PM Philip Oakley <philipoakley@iee.email> wr=
ote:
>
> > On 03/10/2019 21:35, Emily Shaffer wrote:
> > > Hi George, it sounds like you are probably using Git for Windows
> > > (https://github.com/git-for-windows/git).
> > >
> > > I'm actually not very familiar with how folks who primarily use GfW =
as
> > > their client manage their contributions to the main Git project.
> > > However, I know there are plenty - the GfW maintainer is an active
> > > contributor upstream.
> > >
> > > I'm CCing the Git mailing list as well as the GfW maintainer in the
> > > hopes that you can get some help from somebody who regularly uses th=
e
> > > workflow you're trying to achieve. :)
> > >
> > > Unfortunately I use Linux everywhere and so I can't try to replicate
> > > what you're doing - but once you have a good workflow and are able t=
o
> > > finish the My First Contribution tutorial we should still be able to
> > > work together.
> > >
> > > Can you be specific about which "official website" you downloaded Gi=
t
> > > from (share a URL), and paste the command you run and error message
> > > you receive? Please also share the output you see when you run "unam=
e
> > > -a" in Git Bash.
> >
> > Hi,
> > The top level domain would be https://gitforwindows.org/
> >
> > The download button should give the same pure run-time as the git-scm
> > website.
> >
> > However for this case you should go via the "Contribute" button to get
> > the full Windows SDK that will provide all those missing items for a
> > reasonable compile experience (including 'make' !). The SDK and the
> > regular 'Program Files' Git are independent so can both be used.
> >
> > I tend to develop on to of the patched Windows version of git, and
> > usually there is enough separation that the patches transfer direct to
> > the Linux upstream.
> >
> > HTHs
> >
> > Philip
> >
> > >   - Emily
> > >
> > >
> > > On Thu, Oct 3, 2019 at 12:40 PM gespinoz gespinoz
> > > <gespinoz2019@gmail.com> wrote:
> > >> Hello,
> > >>
> > >> Great! Thanks for the tips Emily! This mentor and internship progra=
m
> > sounds awesome which is why I decided to apply. I=E2=80=99ll look thro=
ugh it to see
> > if there=E2=80=99s a specific micro project available later on today a=
nd run it
> > through you.
> > >>
> > >> I am having one slight issue, I=E2=80=99m not sure why I can=E2=80=
=99t use the =E2=80=9Cmake=E2=80=9D
> > command to run Makefile, I=E2=80=99ve done it at school in the past so=
 I was a bit
> > familiar with Makefile and how it helps compile things. This is what I=
 did.
> > I downloaded git from the official git website, installed it, then I f=
ound
> > the repository link and I cloned it in the git bash client to my deskt=
op.
> > I=E2=80=99m using windows at home but at school I used an iMac and whe=
n I cloned
> > repositories I used iTerm and pushed to git within iTerm. I=E2=80=99m =
guessing the
> > git bash is similar since I was able to open and edit files using vim
> > commands similar in iTerm when I was going through the walkthrough. So=
 now
> > I=E2=80=99m stuck on the =E2=80=9Cmake=E2=80=9D step to see if I added=
 the psuh feature in
> > correctly. I also noticed when I looked at the INSTALL page on github =
it
> > made it seem like maybe installing it through the website wasn=E2=80=
=99t the right
> > idea? Maybe that=E2=80=99s why I can=E2=80=99t use make? I also can=E2=
=80=99t use man correctly.
> > For both I get bash command does not exist. Should I install something
> > similar to iTerm instead on windows and just start fresh? ty.
> > >>
> > >> George!
> > >>
> > >> On Thu, Oct 3, 2019 at 11:14 AM Emily Shaffer <emilyshaffer@google.=
com>
> > wrote:
> > >>> Hi George,
> > >>>
> > >>> Great to hear that you're walking through the MyFirstContribution
> > >>> tutorial - that's a great introduction to how the Git project gets
> > >>> stuff done.
> > >>>
> > >>> This is my first time mentoring for Outreachy, but as I understand=
 it,
> > >>> you will start by doing a microproject so everybody can see if you=
 are
> > >>> a good fit for the project. The community discussed the list of
> > >>> microprojects for applicants to try in this mailing list thread:
> > >>> https://public-inbox.org/git/20190916184208.GB17913@google.com/
> > >>> I don't think you need to wade through the replies on that thread =
to
> > >>> determine whether the microproject you are interested in is availa=
ble,
> > >>> although you're certainly welcome to. You can also ask me if you s=
ee a
> > >>> microproject you are interested in and I will be happy to help
> > >>> summarize it and point you in the right direction :)
> > >>>
> > >>> It is also probably a good idea for you to search that mailing lis=
t
> > >>> archive for "[Outreachy]" so you can see what Outreachy interns ha=
ve
> > >>> done in the past and try to emulate how they submitted finished
> > >>> microprojects.
> > >>>
> > >>> The tutorial you said you're reading covers how to send your
> > >>> contributions for review when you're done, but if you find you're
> > >>> having trouble or want someone to check that you've formatted it
> > >>> right, you can let me know!
> > >>>
> > >>>   - Emily
> > >>>
> > >>> On Wed, Oct 2, 2019 at 9:55 PM gespinoz gespinoz <
> > gespinoz2019@gmail.com> wrote:
> > >>>> Hello Emily,
> > >>>>
> > >>>> How are you? My name is George Espinoza and I am one of the
> > applicants in the Outreachy internship program. I hope you are doing w=
ell!
> > I wanted to introduce myself and connect as I am interested in the Git=
 open
> > source project that you are mentoring. I'm currently creating my work
> > environment and tinkering with the git program while doing the
> > myfirstcontribution walk-through. I have had a bit of experience using=
 git
> > for a school i attended over the summer that used it for clone and pus=
hing
> > repositories. We worked with iTerm and I learned how to use vim as wel=
l. I
> > know some basics, in no way a master yet/ I hope to learn more as I
> > progress in making contributions!
> > >>>>
> > >>>> After I set up my environment I will join the IRC channel and
> > introduce myself in the project's public chat and go from there search=
ing
> > how and what I should first contribute.  I'll also join the mailing li=
st.
> > If you have any tips or advice that would be great! I'm looking forwar=
d to
> > working with you and learning more about Open Source Projects! Thank y=
ou.
> > >>>>
> > >>>> sincerely,
> > >>>> George Espinoza
> >
> >
> >
>

--8323328-1317389376-1570179188=:46--
