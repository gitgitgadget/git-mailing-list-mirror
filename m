Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29211FF34
	for <e@80x24.org>; Tue,  9 May 2017 04:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbdEIEbm (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 00:31:42 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35194 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdEIEbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 00:31:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so12266658pfd.2
        for <git@vger.kernel.org>; Mon, 08 May 2017 21:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zJnJMs+iix5cC0xKeRgiCYjyWjoYrt/VFvxihNp3OVs=;
        b=rX281WEQIP3GIjEsHm2OYx//t5d9i6+j0BpAvAf3Qm7sLYqcUdqqYQ7Ri3N05u+DO0
         YZ3Fhn9Uy4P9Dxv+uM6pXBZyPPe226cYOFSbmjep4/dSvOeV4FTi2N8k9muQ5vS3kj2f
         s1msZvl/t3HG196hzV5SHqKJKtXbaVYttQpa+BKmY6NZmKX3lqV7sr+1+pbbfjX9VQ23
         zLFUW7Vf0pZ7IkWu3vuWbcp1/jnXHJ6o6KMaktJIejo5QyxCkm3N0W4DRUr3jvklHC68
         qfbiz//jj5XrMaPIms9jUcgJxSLGr5s5/vQyUSSLfxuFto7BemS8A44eAqaTpqDwiNwv
         ysTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zJnJMs+iix5cC0xKeRgiCYjyWjoYrt/VFvxihNp3OVs=;
        b=HmeQIZ7LJxZdzJvMwDUoiHEWH4Nsd8TbpazGqZRvoDuBmL75v8RWt13qLWEMy6JqlB
         s2y0C/5PURfMhXn4uSNF6021r2QUPa0thNTqLi3i8Rsmlv900/n9rYwvP31r+fGslFOB
         YoEMjFZy1MhFyqoOi75Vbj6/+37Sl3VPUr7KMfsuMgiIuPHgHaqnI6d1aUJWquSDDWgy
         zQqFFb8x7Gpf6PxggkluZHINU1w8H/a669NC/ZOcOrrH1gi+ox5vCw/yPax6DIBhDss/
         7qsSTXTK1jvkIzOtZ7iel4yqCJtCiBIBovgd0f3OWqtgbUlRSIKozveERgXRzxIOkRX+
         Vt2Q==
X-Gm-Message-State: AN3rC/4ZlW+r3COeMnXoeA4WF0Wey791CKx8B/MK67mGo06ctPVOIKoZ
        jaQ3+ZDidUk6OA==
X-Received: by 10.98.200.23 with SMTP id z23mr34608667pff.18.1494304300846;
        Mon, 08 May 2017 21:31:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id n22sm18698498pfj.27.2017.05.08.21.31.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 21:31:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Jordi Mas <jmas@softcatala.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Not translatable strings in Git
References: <f3bfb85c-1722-e720-3d36-40c29a692867@softcatala.org>
        <CAGZ79kbtT6QCbd3-MpWiTm3r_cyBOLsa9kvd-KLNr8eEe+9v9Q@mail.gmail.com>
        <20170509040722.dd2yt4254g3raeev@sigill.intra.peff.net>
Date:   Tue, 09 May 2017 13:31:39 +0900
In-Reply-To: <20170509040722.dd2yt4254g3raeev@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 9 May 2017 00:07:22 -0400")
Message-ID: <xmqq7f1q4pn8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think the diffstat summary is marked for translation at all,
> plumbing or not.  There's some history there:
>
>   http://public-inbox.org/git/1345922816-20616-1-git-send-email-pclouds@gmail.com/t/#u

Wow, that's a long thread.

> There was an attempt to re-enable it for local-only commands:
>
>   http://public-inbox.org/git/alpine.DEB.2.00.1210231323480.602@ds9.cixit.se/
>
> but nobody seems to have responded (I don't have much of an opinion
> myself).

I still think that the latter is wrong, especially the part that
touches log-tree.c, pp_header(), and other lower level things that
will be read and interpreted by scripts.  The change to diff.c about
the diffstat reverts a bugfix made in v1.8.0 timeperiod, it seems.



