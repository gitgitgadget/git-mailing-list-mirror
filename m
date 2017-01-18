Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9039F1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 16:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753936AbdARQfW (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 11:35:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:55315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752766AbdARQfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 11:35:21 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQQzk-1c0I2g3S4S-00TnHv; Wed, 18
 Jan 2017 17:35:15 +0100
Date:   Wed, 18 Jan 2017 17:34:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Marc Branchaud <marcnarc@xiplink.com>
cc:     Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Subject: Re: [RFC] stash --continue
In-Reply-To: <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com>
Message-ID: <alpine.DEB.2.20.1701181725130.3469@virtualbox>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net> <alpine.DEB.2.20.1701161153340.3469@virtualbox> <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hZFirVaUg0NmErcGX8QREOMYq73G39Fp44zKWQXNXjeTyhHJpA3
 4ykhuCwpS7VT4kp4TEbb7he/qw9pLCikFQPIPWFkSeYG0OU/8VNe9kln8xb35rSSVvb6/bD
 BSl+MVx5ea+PX6GIICCcBF9pV3bJauoYZQwk1Sh5uU21Y9eoaHiflQ1nX3aOUixv8YuJNVj
 YZ0n9tfCAdwUKRzzbTuew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1KM7IKgr6HQ=:yHeWW1Op4mRWCnDWLREpj/
 VmCgWMPh9fLiKNIsz1jxcoT7jg3AObpGEGkaYvd7+aONa5LB+DS8EYd7UWWklePUHE+isrLQE
 y127Gjltshi2X7NKqnXpZ+pd+eRclnTgE5pRrtFfizHv6bfRmNnXjJnCszSDP/6bJzCHflZFB
 EQvOZWlxBXb3sWiJN0F4FApVlOTPVFvLor97KSu/Pd2b91bqZrtKCkULBUEdCtuJ52dABDDn2
 PUi3f2KtYl0CTd58nHiecj7oVjQhxKtk/9FL1yz2uWNNZaOLJ3Yi4jpCt5/vDrWeT1Ifznbk4
 qHIG3nXNhnXiAOQdYrCgwOqYhrr1j6SU/iCnS3WDJKpFpULnyO5puCfoxDWgcg2/rvvmsuvPt
 XpTngEWPGfKHQb8yFdK4FK0MxHLqGxQuJtM5y3NZSqydjdgyxJzzpu+WgB+D64FDvrYxd6Bkt
 fPBPFIMF/S0GNty8x3+rSU8bbhZXGfUSWpftGD5Js4B6kjCNtRlnSCa3AeB9ZITLzSyrUjs+3
 646EB7YXbI8I3YoJ/atwIl8DJtWS6brjgVNDHikhFUweB2mrlL2X0GwJcV6NfmYMm07WBJ0FJ
 Mllj/ymSsU67Yvb3QFLZq4sjLF5m4nD78U3x0ztSD1XSNKEorgmGfyWigSV0LqqEHrdPv/Qjt
 DUQccBDU+VoKBwrIGAyL17ulBQeuGBcsbPBqIHLqihLGjmMCt5bfJmmkATq/yE4ER0pPA2UKg
 dmKCzzsE9EkLTBrdjb2dIHQouKXkg8wjasOk7WtA/sso83fjoUlyNCxZLcksQjdjr/J93w5oF
 cf/a6mT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marc,

On Wed, 18 Jan 2017, Marc Branchaud wrote:

> On 2017-01-16 05:54 AM, Johannes Schindelin wrote:
>
> > On Mon, 16 Jan 2017, Stephan Beyer wrote:
> >
> > > a git-newbie-ish co-worker uses git-stash sometimes. Last time he
> > > used "git stash pop", he got into a merge conflict. After he
> > > resolved the conflict, he did not know what to do to get the
> > > repository into the wanted state. In his case, it was only "git add
> > > <resolved files>" followed by a "git reset" and a "git stash drop",
> > > but there may be more involved cases when your index is not clean
> > > before "git stash pop" and you want to have your index as before.
> > >
> > > This led to the idea to have something like "git stash
> > > --continue"[1]
> >
> > More like "git stash pop --continue". Without the "pop" command, it
> > does not make too much sense.
> 
> Why not?  git should be able to remember what stash command created the
> conflict.  Why should I have to?  Maybe the fire alarm goes off right when I
> run the stash command, and by the time I get back to it I can't remember
> which operation I did.  It would be nice to be able to tell git to "just
> finish off (or abort) the stash operation, whatever it was".

That reeks of a big potential for confusion.

Imagine for example a total Git noob who calls `git stash list`, scrolls
two pages down, then hits `q` by mistake. How would you explain to that
user that `git stash --continue` does not continue showing the list at the
third page?

Even worse: `git stash` (without arguments) defaults to the `save`
operation, so any user who does not read the documentation (and who does?)
would assume that `git stash --continue` *also* implies `save`.

If that was not enough, there would still be the overall design of Git's
user interface. You can call it confusing, inconsistent, with a lot of
room for improvement, and you would be correct. But none of Git's commands
has a `--continue` option that remembers the latest subcommand and
continues that. To introduce that behavior in `git stash` would disimprove
the situation.

With every new feature, it is not enough to consider its benefits. You
always have to take the potential fallout into account, too.

At least `git stash pop --continue` would be consistent with all other
`--continue` options in Git that I can think of...

Ciao,
Johannes
