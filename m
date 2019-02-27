Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207C620248
	for <e@80x24.org>; Wed, 27 Feb 2019 18:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfB0Su3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 27 Feb 2019 13:50:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:37750 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfB0Su2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 13:50:28 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1RIoO6o058264
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 13:50:24 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Michal_Such=C3=A1nek'?=" <msuchanek@suse.de>
Cc:     <git@vger.kernel.org>
References: <001e01d4ce9c$eff07400$cfd15c00$@nexbridge.com>     <20190227150836.495f1692@kitsune.suse.cz>       <000001d4ceb4$b930df50$2b929df0$@nexbridge.com> <20190227171103.4cbc735a@kitsune.suse.cz>       <000a01d4ceb8$3cd19720$b674c560$@nexbridge.com> <20190227172841.3a74fa60@kitsune.suse.cz>       <000b01d4ceba$39cfddf0$ad6f99d0$@nexbridge.com> <20190227175135.4392e9d7@kitsune.suse.cz>       <001101d4cebe$7119a080$534ce180$@nexbridge.com> <20190227181458.4f019d91@kitsune.suse.cz>       <001b01d4cec3$364149e0$a2c3dda0$@nexbridge.com> <20190227185044.120c0ba7@kitsune.suse.cz>       <002501d4cec6$2a5e5a20$7f1b0e60$@nexbridge.com> <20190227191814.054c2f3c@kitsune.suse.cz>
In-Reply-To: <20190227191814.054c2f3c@kitsune.suse.cz>
Subject: RE: Need multibyte advice - Shift-JIS
Date:   Wed, 27 Feb 2019 13:50:18 -0500
Message-ID: <003301d4cecd$4bced250$e36c76f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHTicsscbHaF10FfRV1Fywnm3yWvQI6Vn4cAU1TeogAvaPrzgJNYIqVAiFSY3EB0BWivQJ1IT1oAi/nFNcBwefUwQCu/1jjAZLyU/0BVY4EjQHabncGpUOeWVA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 27, 2019 13:18, Michal Suchánek wrote:
> On Wed, 27 Feb 2019 12:59:15 -0500
> "Randall S. Becker" <rsbecker@nexbridge.com> wrote:
> 
> > On February 27, 2019 12:51, Michal Suchánek wrote:
> > > To: Randall S. Becker <rsbecker@nexbridge.com>
> > > Cc: git@vger.kernel.org
> > > Subject: Re: Need multibyte advice - Shift-JIS
> > >
> 
> > I'm sorry if I was not clear about all this. NonStop is not a Linux platform. It
> is POSIX. Not all utilities are available and not all utilities have all capabilities.
> lv is not available for the platform. less considers the data binary and displays
> what usually is displayed when you try to use it for binary multibyte. You get
> @^@- and such. It does not present the data in the correct character set for
> the user.
> >
> > This was only one part of my original question. I am searching elsewhere
> for support on pagers, because this really is not an appropriate discussion for
> the git group to focus on, do let's drop this, please, as not worth continuing.
> My original request was more about how to set up the file attributes,
> difference engine, and the rest of the git infrastructure. The partner I am
> working with is doing this with git hooks, which I am not really happy about.
> Let's prune this discussion as not worthy.
> >
> 
> Yes, this is totally unclear. Setting git hooks is possible but setting
> LESSCHARDEF is not?
It can enter the environment simply through .profile, where we can change GIT_PAGER. We have established that separately.

> Is patching git acceptable or is that out of question too?
I have done a bunch of git patching, where specifically.

> What are your requirements, exactly?
Source code and comments contain SJIS content. The requirement is to be able to move seamlessly in and out of git, and have git show/diff/log display SJIS as well as ASCII content. How that happens is open. The UTF-16 is a red-herring, only as an attempt at getting at SJIS content differently than the limitation imposed by less.


