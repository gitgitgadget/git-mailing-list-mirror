Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE871FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 12:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbcHNK5r (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 06:57:47 -0400
Received: from mout.web.de ([212.227.17.12]:49460 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932378AbcHNK5p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 06:57:45 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MDP6H-1bQkH802g9-00Gnx8; Sat, 13 Aug 2016 23:20:03
 +0200
From:	tboegi@web.de
To:	git@vger.kernel.org
Cc:	peff@peff.net, Johannes.Schindelin@gmx.de, j6t@kdbg.org,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 0/1] convert: Correct NNO tests and missing `LF will be replaced by CRLF`
Date:	Sat, 13 Aug 2016 23:29:19 +0200
Message-Id: <20160813212919.11282-1-tboegi@web.de>
X-Mailer: git-send-email 2.9.3.599.g2376d31.dirty
In-Reply-To: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:wBgtbaQuTgRsN9FP7SyDtBNmtHvdWnROOMDelTMaGgpBTprlnBv
 r6//MYn2EXAv+u9hRj9835cVnEKRa1ZDGO9tYOiRADapkA2LfmkabR2RIqzIPuaCuMeXfjg
 RobE725uZIenVKR0IzFSIbLLYQpVkmpiqFIpc3PcmUQ3A550co/URnSuz7lnf1pDAjZzMyu
 UM8Y5GY5hzdPKB5OxsgQw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:JsZ3442HIog=:USrs1ETCqf+QZTiWqK1qiX
 rz2JqguoYlIhgrAxt9TNhSZIUCJjj3bHL9KeGziTtnK1q+Gk97ohgjpv6dqMT8w+EuAGV3GDq
 gyup19PDCakmaera35P+NvWRZLS0uY3FLB7oe7fQpOGj5DeqIH0EpuCxsQfEgCGxhqQZE5cp5
 ++dQUjhYjvmVGUhC9NH1JvJMyIt+E7l+vlHMv9Br7ef4haqiv6Lz727qjhHA9q/Lx/TgmufBv
 YQA1lYFs6q/rvulaVQtDIq++Xhp8a2q8SWJMgVZd4jv/aFXa/vsJNBvY6SRbnz/k2G8BdTmWf
 V1kqV2p02IjbTlSVT/dhdceVTWEbMVJfr/aUNqcnmFQIkHQoOlWkFZuMAiaY3BvYnwwPlywc+
 wGmMmG/VqyTxqObDbAobau40Mdt8tEWxfzcgncp4vWGgd2riK34tXdBl0ulGbIyNse4fuLwkd
 e3/ERe5nXhHMVkcd/AJTWgus7IGYvdHLh1Ns65V2jcds4CyshvG+FmanojgqjeQkSDmu8R+ua
 352i9JV6K/za0c+x7CxO61JBt18V+bdfQ30XAr52dJddYubUqMhEXs2JCGIJJlA1xXTU4zR57
 c0YcOS3rbIyq++yALeRqY23miwvWjCIzldAvOjC7KQfbhKNac6NOR34Do/p3dJujDpde00TAR
 RwzvV54RlIhZlLtSLgMmd16J0yIf/5bnJJbQdghAMnzbyHBPYLlcwD0wlEgYdMvRcvzvl8EnM
 oPMXTOJKe/dVkvUyLrlVMXK+UcSTn6G8O1PsRjUwg/aYPbsh9Q9Y23m2CDCuCRypQGUmQK05m
 y7wtNk+
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Change since v1:
- The changes done in 1/2 in t0027 needed to be reverted in 2/2.
  Put both changes for convert.c and t0027 into a single commit
Thanks to Johannes Sixt.
Torsten Bögershausen (1):
  convert: Correct NNO tests and missing `LF will be replaced by CRLF`

 convert.c            | 97 ++++++++++++++++++++++++++++++----------------------
 t/t0027-auto-crlf.sh |  6 ++--
 2 files changed, 60 insertions(+), 43 deletions(-)

-- 
2.9.3.599.g2376d31.dirty

