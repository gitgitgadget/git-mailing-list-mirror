Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783181F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 12:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753783AbdARMoT (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 07:44:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:64991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbdARMoS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 07:44:18 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6730-1ceNEE3zzu-00yACG; Wed, 18
 Jan 2017 13:44:05 +0100
Date:   Wed, 18 Jan 2017 13:44:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] describe: teach describe negative pattern matches
In-Reply-To: <CA+P7+xqFHG52Xo8ncUwa3owDn3OOz+rr3ZaGwfcUDCiXJmh80Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701181340530.3469@virtualbox>
References: <20170112001721.2534-1-jacob.e.keller@intel.com> <20170112001721.2534-6-jacob.e.keller@intel.com> <5f723a0d-623f-bf97-00de-29d430484fed@kdbg.org> <CA+P7+xrmAmCPOzuaKcm+WxceXnowkM4gKz05tSpdC=CDwpCEug@mail.gmail.com> <5c8401ef-9609-f235-9228-be980a13edf1@kdbg.org>
 <CA+P7+xq1LMkRG_aSyamrsPUQE+rDv4A9Qd19tDMgx-_a5OHsqQ@mail.gmail.com> <97d4105c-0fa6-41c5-e456-30cebd93dc36@kdbg.org> <CA+P7+xqFHG52Xo8ncUwa3owDn3OOz+rr3ZaGwfcUDCiXJmh80Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u17Fm0LwiS56H3sUJKr9ySk36VtoYzCw6TRHSBcXfOIkiMxs1JF
 /oanE4t07fc996rHDH+7fNKruVhfABoM0knCU/vuHtxdRiXpbD7WOOVct5RIGSdUN022RgI
 BIY+tAJ7Uouh+9SY/mpq5KVWrOIkc0Ibfre8p9mN8qPzJFzoyveCJKn4AZAWKngh+S83jq0
 dz1YgJFR668ItJVhtq8Bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:esba2xXvCok=:eVNA/6DJpefrySivrKhiqt
 E30dBNqBEV9zY9Z8f1CSkgx/inKBJ9bx8Xq1W2dN93K8Zol4DiZ7LPWI037yRNMR1NxBvbl0I
 bKu8LJm4mTR6lcvE/XzZTK3rcVLAEaKeuX6M2b/Mar1ry6DF5LTsBGqrdIMk5KF34eLQQC17y
 FoiU64Z5QJvaydh8ogC3JPjdpem3Ha8Vt6qFCRcaiDQ2wz4eDlP2EluvOX6pgW2eqH39zdrYQ
 JwI4APjcqNXfZLMtTLvISrXA8qsmqkWuA5AiWLDJ4VW9Zplbn9IHl3VnA4FIaC5+iPaQhrVxD
 Jr+6MivAjmx1RHZn0hjydvLttThKCteYZtlk2XnpBF3dcwpDHBt4xqXYT8vqc5JmiwcvX7fAw
 /6CfuAWX7ckzPOPT5Y4yt7xpr1WhZqSLWgRLptPVBhDPbdD05uZlilh9XdZnDOGTEahQ9CT2V
 QTR8/kDYTWvNsAEkNWpMPVajLuPznqMsLF/evJW8+F79DNokPavQDv2N1wSOx9LBcToYuIC3k
 WkcyFeLwnUwoML6M7LUhJuj12Cjl3pa16KwtQ0c+5kqepexdNLuHozHsyK9u+QySSJHRybl8K
 T+K7J/Bqm3uiRg6K6j1fm1moVxRWV4gduC3QUZ/r7Q4LhCGx4SxDb4ud9eU+spa/j6uZ0fiD8
 0ilNxmWetWQZq34uqyK/ZPzvmWkSPMLUx7p+xeZCPN8P4BYcobf749Dfpsq8uY3Ku+gcxZhpW
 rAHoEywiWT2ESDxy6RvsuFyCOxJgy9vfR8RMKgh4bqGZ1FBJ2jwyyg2DD/e9VMieqcrOOQ7g5
 T+eYUtrza2JEVs6awJMV8hf7pN3zcEfDY5LI0V8uvOfH648TJU5f7OiF0ELxXl0Dkd2L5p64d
 kv4c3uelikLw7dgZIzhLuVZI4XYYrb/BoxBUMqBcfquUOD2r88a3IzKL2D6ad6ObqfRXQssjy
 4Zloh5kk8/sV+8p6M0PuK1HGPR4m6XjQjKmkBbi2ErTcaPfW0mEsPhixhyzMGJhNrBLCLYfEo
 EnI0XsH8OEaZnNQGMoBVRbs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Tue, 17 Jan 2017, Jacob Keller wrote:

> On Fri, Jan 13, 2017 at 1:31 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > Am 13.01.2017 um 07:57 schrieb Jacob Keller:
> >>
> >> On Thu, Jan 12, 2017 at 10:43 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> >>>
> >>>  When you write
> >>>
> >>>   git log --branches --exclude=origin/* --remotes
> >>>
> >>> --exclude=origin/* applies only to --remotes, but not to --branches.
> >>
> >>
> >> Well for describe I don't think the order matters.
> >
> >
> > That is certainly true today. But I would value consistency more. We would
> > lose it if some time in the future 'describe' accepts --branches and
> > --remotes in addition to --tags and --all.
> >
> > -- Hannes
> >
> 
> I am not sure that the interface for git-log and git-describe are
> similar enough to make this distinction work. --match already seems to
> imply that it only works on refs in refs/tags, as it says it considers
> globs matching excluding the "refs/tags" prefix.
> 
> In git-describe, we already have "--tags" and "--all" but they are
> mutually exclusive. We don't support using more than one at once, and
> I'm not really convinced that describe will ever support more than one
> at a time. Additionally, match already doesn't respect order.

I agree that it would keep the code much simpler if you kept the order
"exclude before include".

However, should you decide to look into making the logic dependent on the
order in which the flags were specified in the command-line, we do have a
data structure for such a beast: we use it in gitignore and in
sparse-checkout, it is called struct exclude_list.

Just some food for thought,
Johannes
