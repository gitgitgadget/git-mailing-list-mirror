Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E891F405
	for <e@80x24.org>; Fri, 21 Dec 2018 15:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbeLUPtH (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 10:49:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:54117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbeLUPtH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 10:49:07 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOTRh-1gUcHj2nxN-005t2G; Fri, 21
 Dec 2018 16:48:54 +0100
Date:   Fri, 21 Dec 2018 16:48:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>, szeder.dev@gmail.com,
        Jan Palus <jpalus@fastmail.com>
Subject: Re: [PATCH] t5570: drop racy test
In-Reply-To: <20181220171438.GA6684@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1812211638180.41@tvgsbejvaqbjf.bet>
References: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de> <20181125220138.GK4883@hank.intra.tgummerer.com> <20181126164252.GA27711@sigill.intra.peff.net> <20181220164150.GB25639@hank.intra.tgummerer.com> <20181220171438.GA6684@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Wl/xEgZKWV9eb7232YoSXjJ1LJDAW75cd7wl45EFWPqvSBG1zys
 leNbMwRaVTZpjtrIQYUu3n+i1XcPf/xxuWlg9sax5CABLrbXl5J3JCFonQP+qMRA1PvHY+r
 ViFqT96DxPs6aRPMTDeeKknznKXwJmUF1RnuGB9oZqHD5PmlXIvpQ8fTUkVDzAuFdtViBBq
 N8njxZ+eGxQkLGBsFax7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8KlpTgvoeew=:ExP/wjho3EVeZMxLveBW6T
 sfnsf6VlLEE+yu+jO2SfSfwpKGSDrtFAdeSAM1JpH2hPpRU3ZlyMYEX5iMNv73i8eszG4O4wT
 nduz2qPKii/o6jw6U/lRETvcgfv03AGhxor7Hd7YF3j8qmBDpo3svnqlBmpyCo4ljRLI8s+kQ
 wVOoHJPcdG2M0zAAdvGdaoitTGudkQ3bICjr5g+b9MymV4tCi8SMyOPxL/rF09Nqan7fqgZU0
 Mv30CXyxh19cvpog1B7DJYmC9QPdpX1UiLz5SFkVTNGZes4dP+wSgxpKnfG0egM2Cw0fAgqXV
 S0iW9hasJOKtFYaNPBFr10kRLIN1kRhh5dI8nG+INUJ/LDF16hYBeTemXjfdodF1tuzEgiGqb
 mN7xjP5G561EG8i2FBMo3CvDWKW12Chb0j5Ye/ZKdXde0vhl/W3bOV9eiIdSvBDZa4RKCsuqg
 nE6Ti3EGeTmpHcifgOngpHntJ+U/5jVLcPxf9DuN5x7KCGews3PYQMmGrfIB53JF/7tUh36SC
 Z+SpanSZ7RHuNLGqb7ofNLrpBBP12UfF2zI1voS0BAR3TAAxwrUP0PMIz1MsdqS/MojP3TrkJ
 iIWq3iToTHvUDOIngVxMV0jRXZYtvP5lB0IOcdBxLdZpkIjV9Yunn6IBLekqSNtOyVjS9404x
 bUzpC3L+9CvXtnHzPxx8zmv7bn63lo9j1cz/7lYjh9pse5W4eOe011mFI3Xuzi4LCcvTgBbO6
 4Hjk47CFd/oYVjDbnvltabXO/MccRv42jQVhXBt7MZeuBjjnuecVpAH7vbAJ+dBOU0tzVuKlL
 cvLUFDKR+kGgDd66ihrx8H7xxur6WIOmb5ouV15d2JDXQCLgeHtEEXgCTNuLIePhJ+zrFy7Lp
 05LViciJkcKpZYjFVDdfU6P74Wcd6QHfafJTbIuexwdoWj30XkHrF5OutsWgPlpOAiBpLMV9f
 IDwnymCUhOw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas & Peff,

On Thu, 20 Dec 2018, Jeff King wrote:

> On Thu, Dec 20, 2018 at 04:41:50PM +0000, Thomas Gummerer wrote:
> 
> > > That doesn't really fix it, but just broadens the race window. I dunno.
> > > Maybe that is enough in practice. We could do something like:
> > > 
> > >   repeat_with_timeout () {
> > > 	local i=0
> > > 	while test $i -lt 10
> > > 	do
> > > 		"$@" && return 0
> > > 		sleep 1
> > > 	done
> > > 	# no success even after 10 seconds
> > > 	return 1
> > >   }
> > > 
> > >   repeat_with_timeout grep -i extended.attribute daemon.log
> > > 
> > > to make the pattern a bit more obvious (and make it easy to extend the
> > > window arbitrarily; surely 10s is enough?).
> > 
> > I gave this a try, with below patch to lib-git-daemon.sh that you
> > proposed in the previous thread about this racyness.  That shows
> > another problem though, namely when truncating 'daemon.log' before
> > running 'git ls-remote' in this test, we're not sure all 'git deamon'
> > has flushed everything from previous invocations.  That may be an even
> > rarer problem in practice, but still something to keep in mind.
> 
> Right, that makes sense. Making this race-proof really does require a
> separate log stream for each test. I guess we'd need to be able to send
> git-daemon a signal to re-open the log (which actually is not as
> unreasonable as it may seem; lots of daemons have this for log
> rotation).
> 
> I think getting rid of the "cat" would also help a lot here.
> Unfortunately I think we use it not just for its "tee" effect, but also
> to avoid startup races by checking the "Ready to rumble" line. So again,
> we'd need some cooperation from git-daemon to tell us out-of-band that
> it has completed its startup (e.g., by touching another file).
> 
> > Dscho also mentioned on #git-devel a while ago that he may have a look
> > at actually making this test race-proof, but I guess he's been busy
> > with the 2.20 release.

And GitGitGadget. And working on the Azure Pipelines support. And
mentoring two interns.

This is what I still have in my internal ticket:

	Try to work around occasional t5570 failures in Git's test suite

	Seems that there is a race condition in
	https://github.com/git/git/blob/master/t/lib-git-daemon.sh#L48-L69
	that could possibly be solved by writing to the daemon.log
	directly, and showing the output only via `tail -f` (and only when
	running in verbose mode, as it simply won't make sense otherwise).

However, if the preferred route is to go ahead and just remove that test
altogether, I'm fine with that, too.

The only reason, in my mind, why we still have `git-daemon` is that it
allows for easy standing up your own Git server, e.g. as an ad-hoc way to
collaborate in a small ad-hoc team. If we ever get to the point where we
can stand up a minimal HTTP/HTTPS server with an internal Git command (not
requiring sysadmin privileges), from my point of view `git-daemon` can
even go the way of the Kale Island (but for much better reasons [*1*]).

> > I'm also not sure it's worth spending a lot of time trying to fix this
> > test, but I'd definitely be happy if someone proposes a different
> > solution.
> 
> Yeah. I'm sure it's fixable with enough effort, but I just think there
> are more interesting and important things to work on.
> 
> > --- >8 ---
> > Subject: [PATCH] t5570: drop racy test
> 
> So yeah, I'm still fine with this. But...
> 
> > ---
> >  t/t5570-git-daemon.sh | 13 -------------
> >  1 file changed, 13 deletions(-)
> 
> This is the only user of daemon.log, so we could drop those bits from
> lib-git-daemon.sh, too. That would also prevent people from adding new
> tests, thinking that this was somehow not horribly racy). I.e.,
> reverting 314a73d658 (t/lib-git-daemon: record daemon log, 2018-01-25).

Indeed, that would be good.

The only reason to keep daemon.log that I can think of is to make
debugging easier, but then, if it should become necessary, it is probably
easier to freopen() stdout or stderr into a file in `git daemon`, anyway.

Ciao,
Dscho

Footnote *1*: Kale Island, along with Rapita, Rehana, Kakatina and Zollies
is prominently featured in a scientific article at
http://iopscience.iop.org/article/10.1088/1748-9326/11/5/054011 that is on
my "important papers I read in 2018" list.
