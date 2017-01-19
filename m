Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76C7C20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 18:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbdASSSN (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 13:18:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52793 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753869AbdASSSK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 13:18:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4D8560E03;
        Thu, 19 Jan 2017 13:17:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LFA0gVfeeW8ZGRpLqWEr2brB5n8=; b=W/8tqN
        eR/l48x1xm1eOc2TlHrnNds2d/bM/xBUzwXk5tUe/JoWlv46290NdJl+bY5jenqz
        ft6UGO/cEgJS6sqbpAP/kK6J9CVrTVad6lOlsdw8lOZvS8VEzs9wbUCl3vPo8UzL
        bZ/NvaIeclgW3w4/SGg66rWjhxcOgsHXFphLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LWWLjftkMSf+tT2ES5kMPwQbnIXLyTi/
        z9ml79yy3NuWgZ55g52e+YqnA22oraxR4Ui2/NMd5AqSBDdc9Jym+9PJ4jsTZ7pi
        O38abPCS9+wnC5I6YFjQxbvJcvpEPrrkM+C+Y09kC/xF3jjDujNNtJiHRpw3C3yr
        adDP1I1Copo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BA9360E02;
        Thu, 19 Jan 2017 13:17:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C15D660DFF;
        Thu, 19 Jan 2017 13:17:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Khomoutov <kostix+git@007spb.ru>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>, <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "CARLOS.PALMINHA\@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
Subject: Re: Git: new feature suggestion
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
        <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com>
Date:   Thu, 19 Jan 2017 10:17:29 -0800
In-Reply-To: <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com>
        (Konstantin Khomoutov's message of "Thu, 19 Jan 2017 09:33:13 +0300")
Message-ID: <xmqqa8am3oee.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A90A9CE-DE73-11E6-B08C-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Khomoutov <kostix+git@007spb.ru> writes:

> Still, I welcome you to read the sort-of "reference" post by Linus
> Torvalds [1] in which he explains the reasoning behind this approach
> implemented in Git.  IMO, understanding the reasoning behind the idea
> is much better than just mechanically learning how to use it.
>
> The whole thread (esp. Torvalds' replies) is worth reading, but that
> particular mail summarizes the whole thing very well.
>
> (The reference link to it used to be [2], but Gmane is not fully
> recovered to be able to display it.)
>
> 1. http://public-inbox.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/
> 2. http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217

Indeed.  Thanks for providing a link to it here ;-)

The message is the most important one in the early history of Git,
and it still is one of the most important messages in the Git
mailing-list archive.  "git log -S<block>" was designed to take a
block of text (even though people misuse it and feed a single line
to it) exactly because it wanted to serve the "tracking when that
file+line changed" part in that vision.  The rename detection in
"diff" was meant to be used on the commit "git log -S<block>" finds
to see if the found change came from another file so that the user
can decide that "digging further" part needs to be done for another
file.  "git blame" with -M and -C options were done to mostly
automate the "drilling down" process that finds the last commit that
touched each line in the above process, and when used with tools
like "tig", you can even peel one commit back and "zoom down" if the
found commit is an uninteresting one (e.g. a change with only code
formatting).

One thing that is still missing in the current version of Git,
compared to the "ideal SCM" the message envisioned, is the part that
notices: "oops, that line didn't even exist in the previous version,
BUT I FOUND FIVE PLACES that matched almost perfectly in the same
diff, and here they are".

