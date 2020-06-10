Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971BAC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 13:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F79B206F7
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 13:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgFJN7x convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 10 Jun 2020 09:59:53 -0400
Received: from elephants.elehost.com ([216.66.27.132]:28332 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgFJN7x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 09:59:53 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05ADxkoi097671
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Jun 2020 09:59:46 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Martin Langhoff'" <martin.langhoff@gmail.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com> <20200609231336.GQ6569@camp.crustytoothpaste.net> <CACPiFCK0h0LfdyE6Q=UJkuX+Qdb=rULcgDJwgxQ0w-1O0zpMew@mail.gmail.com> <20200610000358.GR6569@camp.crustytoothpaste.net> <CACPiFCKEGXK+TJtQiPub3dW6dYKJ7a=mXL+UCDP57N-3XtRYLg@mail.gmail.com>
In-Reply-To: <CACPiFCKEGXK+TJtQiPub3dW6dYKJ7a=mXL+UCDP57N-3XtRYLg@mail.gmail.com>
Subject: RE: osx autocrlf sanity?
Date:   Wed, 10 Jun 2020 09:59:34 -0400
Message-ID: <027001d63f2f$622f2d00$268d8700$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGyMiyOmCQRS4rWDdFA5xfDLakkSQIOl3dXAjNbPgYBcBFZWQJiStfaqNlXd4A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 10, 2020 9:55 AM, Martin Langhoff wrote:
> To: brian m. carlson <sandals@crustytoothpaste.net>; Martin Langhoff
> <martin.langhoff@gmail.com>; Git Mailing List <git@vger.kernel.org>
> Subject: Re: osx autocrlf sanity?
> 
> On Tue, Jun 9, 2020 at 8:04 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On 2020-06-09 at 23:31:23, Martin Langhoff wrote:
> > > good question! There is a .gitattributes file, all the files
> > > affected have these attributes
> > >
> > > *.py     text diff=python
> >
> > By default, Git will check out files with the text attribute with the
> > native line ending, and it will check them in with LF endings.  That
> > can be controlled by core.eol and core.autocrlf
> 
> Why is core.autocrlf false not working for me?
> 
> I want to work on a repo that has a mix of newlines. I'd like git to completely
> ignore them. Treat all files as a bag'o'bytes.
> 
> Assume I am running git rebase over commits that have .gitattributes, so I
> can't "just remove it".

We use core.autocrlf=input on all our platforms for source files, including OSX.

Does that work for you?

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



