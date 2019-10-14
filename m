Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6045F1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 14:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbfJNOh0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 10:37:26 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34903 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 10:37:26 -0400
X-Originating-IP: 1.186.12.3
Received: from localhost (unknown [1.186.12.3])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 647166000E;
        Mon, 14 Oct 2019 14:37:23 +0000 (UTC)
Date:   Mon, 14 Oct 2019 20:07:21 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?6rmA6rG07Jqw?= <rlarjsdn122@naver.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Is GIT GUI still in progress?
Message-ID: <20191014143721.55hmrqgjpoamrvrt@yadavpratyush.com>
References: <f5eba6e8-b51a-d1a0-0d8f-0aed76d803c9@naver.com>
 <CANYiYbF3T=1e-ro5mOBWYjhvRWyr8--mZCa8JQMoPB52w505vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANYiYbF3T=1e-ro5mOBWYjhvRWyr8--mZCa8JQMoPB52w505vQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/10/19 10:55AM, Jiang Xin wrote:
> 김건우 <rlarjsdn122@naver.com> 于2019年10月10日周四 上午12:02写道：
> >
> > Hello.
> >
> > I have a question whether the GIT GUI project still in progress or not
> > because I want to contribute to translating GIT GUI into Korean. I asked
> > prati0100 who is a maintainer of GIT GUI on
> > Github(https://github.com/prati0100/git-gui), but he doesn't know the
> > project is on.
> > If the project is in progress, please reply this E-mail with how to
> > contribute the GIT GUI for translation.
> >
> > Thank you.
> >
> > --
> > Signed-off-by: Kim Geonwoo (김건우)<rlarjsdn122@naver.com>
> >
> 
> Git GUI is a stand-alone project which is periodically merged to Git
> project by a subtree merge. According to the latest
> SubmittingPatches[1] documentation, git-gui is managed by Pratyush
> Yadav in a separate project[2].
> 
> As a separate  project, the git-l10n project will merge l10n
> contributions into itself and then merge them to Git as a whole
> through a subtree merge. As what README.md[3] of git-gui says,
> contributing to git-gui should using mailing list. This means l10n
> contributors for git-guil, have to use git-format-patch and git
> send-email commands to send patches to the mailing list, which is
> inconvenience for git-gui l10n contributors. I suppose using a
> dedicate git-guil l10n coordinator repository or simply using pull
> requests of "prati0100/git-gui" as the l10n contribution workflow,
> @Yadav.

I'd prefer a separate git-gui l10n repo. The translators can use 
whatever workflow they prefer, and then I can just directly merge in 
your pull requests, similar to how it works for Git. Does this work for 
you guys?

Thanks for volunteering to do the translations :)
 
> [1] https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L375
> [2] https://github.com/prati0100/git-gui
> [3] https://github.com/prati0100/git-gui/blob/master/README.md

-- 
Regards,
Pratyush Yadav
