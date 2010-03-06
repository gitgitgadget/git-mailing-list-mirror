Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 19006 invoked by uid 107); 6 Mar 2010 12:17:23 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sat, 06 Mar 2010 07:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352Ab0CFMQs (ORCPT <rfc822;peff@peff.net>);
	Sat, 6 Mar 2010 07:16:48 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:43802 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab0CFMQr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 07:16:47 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id EF13414270D00;
	Sat,  6 Mar 2010 13:16:45 +0100 (CET)
Received: from [91.19.17.196] (helo=pluto.localnet)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1Nnsvz-00029P-00; Sat, 06 Mar 2010 13:16:43 +0100
From:	Markus Heidelberg <markus.heidelberg@web.de>
To:	Tait <git.git@t41t.com>
Subject: Re: using gvim as editor on Windows
Date:	Sat, 6 Mar 2010 13:17:38 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.30-gentoo-r8; KDE/4.3.3; i686; ; )
Cc:	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
References: <20100306070628.GM2480@ece.pdx.edu> <8c9a061003052322v446acddbm5792038af450d0b9@mail.gmail.com> <20100306073729.GN2480@ece.pdx.edu>
In-Reply-To: <20100306073729.GN2480@ece.pdx.edu>
Jabber-ID: markus.heidelberg@web.de
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201003061317.38422.markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18xz69KTo7jT2l76iPbjbyFUcLKkHZFfG9wtd+C
	MzWX64Xg0XvxyyV5TsDJOz3QK0oB2ApSrJnFhSqRtYj+74GuTq
	UFGrxR8BimAmIkpHiHKQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Tait, 2010-03-06 08:37:
> > > I'd prefer to use gvim as an editor on Windows XP instead of vim...
> > >     start "dummy" /b /wait "C:\Program Files\Vim\vim72\gvim.exe" %*
> >
> > Use the -f (stay in the foreground) flag.  I haven't tried this in
> > Windows, but that's how I've used it in Linux.
> >
> > [core]
> >     editor = gvim -f
> 
> On Windows, gvim -f is basically a shortcut for the start invocation I
> pasted above.

Not necessarily. You can avoid using the .bat wrappers from C:\Windows,
which cause the problem, but use gvim.exe directly by setting your PATH
appropriately. It will also work for git-difftool.

Markus
