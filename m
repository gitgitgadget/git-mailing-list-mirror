Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648741F406
	for <e@80x24.org>; Mon, 18 Dec 2017 10:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758121AbdLRKNx (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 05:13:53 -0500
Received: from mout.web.de ([212.227.17.12]:54365 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbdLRKNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 05:13:52 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2uWg-1fFx4w0b4w-00seVi; Mon, 18
 Dec 2017 11:13:36 +0100
Date:   Mon, 18 Dec 2017 11:13:34 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, patrick@luehne.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
Message-ID: <20171218101334.GA20685@tor.lan>
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
 <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:1X3PF1XHQGNMtdfwljdyjJ6YQUP/OkH4CrHNCOovxHdxVt+xNb5
 zBqJSVgub3rrP94cancW2SPfCvE2zNvAAiMk7eRxobvC2ibSfY1/5t+D3hququRmoubQApk
 7mN3WeyJYJZ4SOY6wM591729AyYpfPRWjO+eVKEn3mBN5vHQiyPN0z+uhRW05H9xKjmOECb
 evjN1dJG8wpi7p4kDGLLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HugX1EovreQ=:RaRo4WqhiZ+JmMwIxlZ50h
 3Xxyph1gceI6Es3Nq0wlOU9L3ghqrqEpGoqAAB+g2cEjRuUqzWe8HjoWxQnS3LhKggYtV4Bue
 vZHCa4NnKJ2khy3iH+g/7fbSxE+V+9Hnpdx0gGNpNi8YTBO4urgkKU5SFXO3fZVl1J10q/ZHt
 nt7hyMDeNjhs4ss8XKrnQ1Mk0ESwXSiHHfAY2mWwtCX+zc4Mxgjb1Ddr8LeXoUIws6QHUJcHL
 tSqFCB2UfoqZKhABtE5Oh5Fa4eHJIUoijma/2v5iApEUPKf14ZL86AxgQcm7qw8rCrnY1hKaS
 s0epCC83TtMlJ3E/91mrqRuWt2XxzD9Ec4wvgueYIZlxhl8OugoWMQBn1nPh/8IGlFk62yh2W
 Omk5kVh6VThbQtz13+WDB6sCmt/sXHtkUouQNwBmbmfKSOz/VQU2Gwgv42c6eM7D/U5SnWvzu
 x7R5TyPUIFG3MTNsmPx2K+oUFupNiBdRPh4b/QvdTtlukfIP4dB3S4m9keY6Flmv8FMJVMqRy
 1P+PKRINiEcCPbQoc/93bjqRyEuBU1VS8rIHdKaaCaP1ysZjb9uvZcXu2YX9mqIqNVCwibk7l
 uXDxVE1kvucTO6Fg1aIlc5oDyaEjextN1C8YPjC7OIJv5ns6hHvqagPQOMuzY/Ni+taV8ZPt1
 r1HbhdRa4qD1/Szxc+3QnDa4A78DWyQvjp8AWAWNa0wixcZh+yBnPidDJFZKY3lq8mKdioa5b
 hO32D8xph+hEeb+hkVs9MJ9OjyS+67FU5FT7BziGkKt9EZPuL/xoKEvrGbAP2MEnf6yv8rPBq
 wgSM2OlKV3vMyIYmSGi1aEMUQipdg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 09:47:24PM +0100, Johannes Sixt wrote:
> Am 11.12.2017 um 16:50 schrieb lars.schneider@autodesk.com:
> >From: Lars Schneider <larsxschneider@gmail.com>
> >
> >Git and its tools (e.g. git diff) expect all text files in UTF-8
> >encoding. Git will happily accept content in all other encodings, too,
> >but it might not be able to process the text (e.g. viewing diffs or
> >changing line endings).
> >
> >Add an attribute to tell Git what encoding the user has defined for a
> >given file. If the content is added to the index, then Git converts the
> >content to a canonical UTF-8 representation. On checkout Git will
> >reverse the conversion.
> >
> >Reviewed-by: Patrick Lühne <patrick@luehne.de>
> >Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> >---
> >
> >Hi,
> >
> >here is a WIP patch to add text encoding support for files encoded with
> >something other than UTF-8 [RFC].
> >
> >The 'encoding' attribute is already used to view blobs in gitk. That
> >could be a problem as the content is stored in Git with the defined
> >encoding. This patch would interpret the content as UTF-8 encoded and
> 
> This will be a major drawback for me because my code base stores text files
> that are not UTF-8 encoded. And I do use the existing 'encoding' attribute
> to view the text in git-gui and gitk. Repurposing this attribute name is not
> an option, IMO.

Just to confirm my missing knowledge here:
Does this mean, that git-gui and gitk can decode/reencode
the content of a file/blob, when the .gitattributes say so ?

If yes, would it make sense to enhance the "git diff" instead ?
"git diff --encoding" will pick up the commited encoding from
.attributes, convert it into UTF-8, and run the diff ?
We actually could enhance the "git diff" output with a single
line saying
"Git index-encoding=cp1251"
or so, which can be picked up by "git apply".

The advantage would be that we could continue to commit in UTF-16
as before, and avoid the glitches with .gitattributes, that Peff
pointed out.

Does this make sense ?

> 
> >it would try to reencode it to the defined encoding on checkout > Plus,
> >many repos define the attribute very broad (e.g. "*
> encoding=cp1251").

Is this a user mistake ?

> >These folks would see errors like these with my patch:
> >     error: failed to encode 'foo.bar' from utf-8 to cp1251
> 
> -- Hannes
