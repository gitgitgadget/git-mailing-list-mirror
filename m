Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA8A1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 18:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeH3XAZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 19:00:25 -0400
Received: from mout.web.de ([212.227.17.12]:39855 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeH3XAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:00:25 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWB8f-1gOKhF2miX-00XLDT; Thu, 30
 Aug 2018 20:56:48 +0200
Date:   Thu, 30 Aug 2018 20:56:48 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     jrnieder@gmail.com, Git <git@vger.kernel.org>
Subject: Re: Automatic core.autocrlf?
Message-ID: <20180830185648.GA10427@tor.lan>
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
 <20180830045407.GB140348@aiede.svl.corp.google.com>
 <CAHd499BCk4Q4oPY=CXK=YrUbNUbz4J_KoeQngfz=92Qfc6q=eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd499BCk4Q4oPY=CXK=YrUbNUbz4J_KoeQngfz=92Qfc6q=eA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:Genh75rdbpJ88kFyK9o/74tHqxFBzLA2XgG4xEhtcr9ZjSiyFPS
 vGovgKnrwnz8TDFF1rNwlpUshTWVuLuSbaSXu00ASD8oESERsqvL/HKz+aXOf+1HkbTjBT9
 SjzHj093hdfKZ6ePAUmIasKpLxdJAxAvpRdQsTn2NGTaE9PQyH2bY17eByYaqRjHK7UIp9K
 kQZztjuSNNn1s94k0Ak9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0QM4VImwvz4=:+9q25Y2b3EUOZoCUbfApwP
 oKyMB6JEPvI40zsUmarRGTgaLV7dsCBi7a4EkZDe/YZHKCINm/n3fqLD9R2ASN/yEPkNwbo6F
 F7Ykmzhbtajox/xwafMO+BAU2YYj11Qe/tTQJLuHmxXZTTBufE5E55JrM3kVXWAVBLsWGNdEL
 be11/CIOto/qQr7eqx5Ij3qLFdKjOKztXw8Z/57Adt0clgwcdmCXa+gPyYMAvVVpUYWjtxq91
 ZXxvhWQQ1pSGj8/eRVB4/aN+ZG0qNkNYwiaaj31DrCFWzWOoC8FLNlprehjZZtbK5Jnh1569/
 bQhD01Dmn/P4Fsb9M9g4SCVtywMBLVfIpubkjGYmfQRW9wRg2b2Vn8z+E5nOIyvLgJnr8taXc
 Z2HDX7nWIUlzW+hHoi0hAGEgqbRYVbl+6vXwZzNRWYzpW8jzH7byZj7SkXU6JJ5v+c26EEqI3
 QnT2a6nbzR5SqvWm+QCkGizH4JzGSxQi2fqr5hzwxCBVLbolk0Tu6lj+c2ZRe9wSncHLzaM2y
 bx6wDSsrZzf67uCnb3Jorbaqsh/F6BtHOesE2bONndYloIEU6YzSa5WxqeBkp30ZyVc6+FIJW
 c/kHtTaI7gWCAU58nZ4KxAa4IvMorrImhQ1TL7HllTz2jClUJdlCfdyPVAqnlbLvMahxKsxPR
 mDSbSN3TZPihP+TIRees6zmQeCOFhd+IQNO/X9/+b1f0N0nkzZesjhYaO1QC40VOO6pJKikNX
 BkM079wlvjujQHleRLScZwVahdYrSzvjClxWYZ29BwJJ+0lfLnXCPkZtkG8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 09:57:52AM -0500, Robert Dailey wrote:
> On Wed, Aug 29, 2018 at 11:54 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> >
> > Hi,
> >
> > Robert Dailey wrote:
> >
> > > Is there an 'auto' setting for the 'core.autocrlf' config? Reason I
> > > ask is, I want that setting to be 'input' on linux but 'true' on
> > > Windows.
> >
> > Others are exploring your question about the configuration language,
> > but I want to emphasize some other ramifications.
> >
> > Why do we still have 'core.autocrlf'?  Do 'core.eol' and related
> > settings take care of that need, or is autocrlf still needed?  If
> > core.eol etc do not take care of this need, what should we do to get
> > them to?
> >
> > Thanks, after having run into a few too many autocrlf-related messes,
> > Jonathan
> 
> From my perspective, the confusion is due to the evolution of the
> feature. There's multiple ways to control EOL handling but most of it
> is legacy/backward compatibility, I think. core.autocrlf is a
> fall-back for repos that do not have a .gitattributes. Because
> .gitattributes is optional by design, I'm not sure if getting rid of
> the config options is a good idea.

Good summary. My original plan was to try to "make obsolete"/retire
and phase out core.autocrlf completely.
However, since e.g. egit/jgit uses it
(they don't have support for .gitattributes at all) I am not sure if this
is a good idea either. Opinions are welcome.


> But your point did make me think
> about how `core.autocrlf = true` should probably be a system config
> default for the Git for Windows project. The default for that value
> should be platform-defined. That would make it automatically work the
> way I want, and might solve a lot of the issues where people are
> committing CRLF into repositories on Windows.

Unless I am wrong, that had been the default a long time ago:
Git for Windows (at that time msysgit) had core.autocrlf=true
by default.
While this is a good choice for many repos, some people prefer
core.autocrlf=input.
Others just commit files for Windows-based repos with CRLF,
and the advantage is, that "git diff" doesn't show "^M" somewhere.

I allways encourage people to set up a .gitattributes file.
Does anybody thinks that we can make core.autocrlf obsolete ?


