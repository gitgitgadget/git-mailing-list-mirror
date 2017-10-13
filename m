Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D58E1FF32
	for <e@80x24.org>; Fri, 13 Oct 2017 08:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbdJMIcL (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 04:32:11 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:33699
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750722AbdJMIcI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Oct 2017 04:32:08 -0400
X-IronPort-AV: E=Sophos;i="5.43,370,1503352800"; 
   d="scan'208";a="240863659"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 13 Oct 2017 10:32:06 +0200
From:   Moy Matthieu <Matthieu.Moy@univ-lyon1.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     second.payre@gmail.com, git@vger.kernel.org,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
Subject: Re: [PATCH v2] Documentation/git-config.txt: reword missleading sentence
References: <xmqqtvz7pewn.fsf@gitster.mtv.corp.google.com>
        <20171012091727.30759-1-second.payre@gmail.com>
        <xmqqa80vyjyf.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 13 Oct 2017 10:32:06 +0200
In-Reply-To: <xmqqa80vyjyf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 13 Oct 2017 09:23:20 +0900")
Message-ID: <q7h9infjmos9.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> second.payre@gmail.com writes:
>
>> From: PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
>
> Should I assume that the name/address on the last Signed-off-by: we
> see below is what you want to be known as?  As a part of school
> work, I'd imagine that Matthieu wants your work to be associated
> with the univ-lyon1.fr address, so perhaps you want to go the other
> way around?

Yes, I'd rather have contributions made with the identity
@etu.univ-lyon1.fr, and use the same identity for Signed-off-by: and
From:.

>>  --path::
>> -	'git-config' will expand leading '{tilde}' to the value of
>> +	'git config' will expand leading '{tilde}' to the value of
>>  	'$HOME', and '{tilde}user' to the home directory for the

Didn't notice yesterday, but you still have forward quotes here and
backquotes right below. If you are to fix this paragraph, better fix all
issues at once.

>>  	specified user.  This option has no effect when setting the
>> -	value (but you can use 'git config bla {tilde}/' from the
>> -	command line to let your shell do the expansion).
>> +	value (but you can use `git config section.variable {tilde}/`
>
> Does this reference to {tilde} get expanded inside the `literal`
> mark-up?  In the description for 'gitdir', we find this passage (in
> Documentation/config.txt):
>
>      * If the pattern starts with `~/`, `~` will be substituted with the
>        content of the environment variable `HOME`.
>
> So I'd expect `~` to be a safe way to get what you want, not `{tilde}`.

If I read correctly, the potential issue with ~ is that it's used for
subscript text (i.e. foo~bar~ in asciidoc is LaTeX's $foo_{bar}$). But ~
within a literal string should be safe, and at least we use it in many
places in our doc.

Cheers,

-- 
Matthieu Moy
https://matthieu-moy.fr/
