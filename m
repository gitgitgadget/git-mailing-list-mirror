Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4C521FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 06:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753977AbcLPGEm (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 01:04:42 -0500
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:51342 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752509AbcLPGEl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Dec 2016 01:04:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B57F7C1F71;
        Fri, 16 Dec 2016 06:04:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: name76_26d8a895dba46
X-Filterd-Recvd-Size: 2244
Received: from XPS-9350 (unknown [47.151.132.55])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 16 Dec 2016 06:04:26 +0000 (UTC)
Message-ID: <1481868265.29291.84.camel@perches.com>
Subject: Re: [PATCH] printk: Remove no longer used second struct cont
From:   Joe Perches <joe@perches.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        git <git@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 15 Dec 2016 22:04:25 -0800
In-Reply-To: <xmqqtwa4tqnc.fsf@gitster.mtv.corp.google.com>
References: <1481806438-30185-1-git-send-email-geert@linux-m68k.org>
         <20161215162336.GA18152@pathway.suse.cz>
         <20161216013706.GA20445@jagdpanzerIV.localdomain>
         <CA+55aFz3B2BfjG54z7ALOwezCHSdQp+YbFaHcJkCg=fzoKtfNg@mail.gmail.com>
         <1481853432.29291.76.camel@perches.com>
         <CA+55aFxaOFoh+Zrm5tNhU4hWu4Z032+nqV3vXK=QPJyhZsU3_A@mail.gmail.com>
         <1481855446.29291.80.camel@perches.com>
         <xmqqtwa4tqnc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.1-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2016-12-15 at 21:00 -0800, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > grep 2.5.4 was the last version that supported the -P option to
> > grep through for multiple lines.
> 
> Does anybody know why it was dropped?

perl compatible regexes in grep have always been "experimental"
and never officially supported.

From the grep manual https://www.gnu.org/software/grep/manual/grep.html

    --perl-regexp

        Interpret the pattern as a Perl-compatible regular expression
    (PCRE). This is highly experimental, particularly when combined with
    the -z (--null-data) option, and ‘grep -P’ may warn of unimplemented
    features. See Other Options.


It wasn't dropped so much as "enhanced" away.

Oh well.

