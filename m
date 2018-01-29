Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8541D1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbeA2UTO (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:19:14 -0500
Received: from mout.web.de ([212.227.15.4]:65455 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754093AbeA2UTL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:19:11 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYvmV-1eJYMT3dWl-00Vd1s; Mon, 29
 Jan 2018 21:18:58 +0100
From:   tboegi@web.de
To:     lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        --to=larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 0/7]  convert: add support for different encodings
Date:   Mon, 29 Jan 2018 21:18:55 +0100
Message-Id: <20180129201855.9182-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.2.g64d3e4d0cc.dirty
In-Reply-To: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:po65gva3B46LUFvXgzgfDEIzlQzlLoSI2VTmpq9crEN1SGuPGxR
 7IDdvF7PP01WAwTEo95IuRUAaRkCabQv4BizWZQGHBqHfGJ+XrNPOkYXQpTFh0lvEQU7QJI
 GhN8jSmlGRLawWNeeZbYdUx51nqWfIGW/1KZ3GFall7Hz2SYB/j6NgfFlpfSXJgp9WjGohI
 zpvmCcYfLFbk2cJ8PcEvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TYrD/8q1+7w=:f0CnX22VMsNDOh0eEpX8RK
 cBMfI2DqwtWLp6OZkruGAclf7m5kM5N9tSeAzcxCP7hPdg3FqTuRYWiEz/Zk7hEvxUgSk//yN
 1SQoWxQpK9ajS0jhMWnjyjkdqtI0FbUk9fYA6/BtLzrYDpWTd2iFfhLZBHR//dJuEBUiI+2xu
 p9+v7X1Q/vRCaNtZRuPJwWDmiIbdjpq1nFAD1ClMwB+0OzmM0AY/b7DGC7QFsojzvpxNsqCDt
 oNQVo0c6xrLRt1bCp7XhiE4uc2YypWfvk8bxpq2VQNq2PpDjUjWcJ7xaOsSRPDG0y8fQJX+UV
 jUnhBqUfS52nsn4DknQCZpUHcvJoPwTuZWC+d0qKx8wFkpCsX9Jwv6R687iEtJH0vlhf+PlmE
 Y5nAKDoKFsVyO5umyfyIyPgWAsdBIEILdLlHthI5c/2VJQUeHwWWCqwi5JZrubZweNOnPOCSt
 lgA3H4es0lklryqttcD6kiVQPlEbB+u5pwCwEJfPKstW+H2JF7F/3MHf0cpH4SbGeJHROKJy9
 kU0LrZxGjtxiatP2SAK7xdhxHoi+QW2WDfyzIw2v5zN7e/jOCWEYkbuqJQnfmS7pDnSVJLpmK
 T6Iwy+ZwH83TbWnFh+foMJwVM/kkcCY3txQHdTZTmm9DX0BZm5W4tXuvwMrnU6I3Xvwp3+w7g
 Aeu8sO5gO3faltDj0dLsA+OvXMRMeq449EEmBza4P04hRvE80V3W4j6NHuY9VVJTe8kiqXBK0
 5SFEWrTkp8VokUZ97TH6E/McTJR9mIEfRDaxRrSnorHq3k7AIoUjwhqy9XlEG8pNRvHcSuy5Q
 jH2ivc5EhTcvFZGXBMhiUw+iUCeF8jqsZjvPm+OanLMiBcxaE4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Take V4 from Lars, manually integrated the V2 squash patch,
so a review would be good.

Add my "comments" as a patch, see 7/7 (and this is more like an RFC)

This needs to go on top of tb/crlf-conv-flags


Lars Schneider (6):
  strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
  strbuf: add xstrdup_toupper()
  utf8: add function to detect prohibited UTF-16/32 BOM
  utf8: add function to detect a missing UTF-16/32 BOM
  convert: add 'working-tree-encoding' attribute
  convert: add tracing for 'working-tree-encoding' attribute

Torsten Bögershausen (1):
  Careful with CRLF when using e.g. UTF-16 for working-tree-encoding

 Documentation/gitattributes.txt  |  63 +++++++++++
 convert.c                        | 233 ++++++++++++++++++++++++++++++++++++++-
 convert.h                        |   1 +
 sha1_file.c                      |   2 +-
 strbuf.c                         |  13 ++-
 strbuf.h                         |   1 +
 t/t0028-working-tree-encoding.sh | 198 +++++++++++++++++++++++++++++++++
 utf8.c                           |  37 +++++++
 utf8.h                           |  25 +++++
 9 files changed, 567 insertions(+), 6 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh

-- 
2.16.0.rc0.2.g64d3e4d0cc.dirty

