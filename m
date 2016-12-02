Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D75C1FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 12:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754822AbcLBMUo (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 07:20:44 -0500
Received: from mout.web.de ([212.227.17.11]:63109 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753787AbcLBMUn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 07:20:43 -0500
Received: from [192.168.209.58] ([195.252.60.88]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwHxK-1clUFk3J7O-01863f; Fri, 02
 Dec 2016 13:19:59 +0100
Subject: Re: [PATCH v2 1/1] convert: git cherry-pick -Xrenormalize did not
 work
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <6a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com>
 <20161130170232.19685-1-tboegi@web.de>
 <CA+P7+xoJb=SukbnJVJrXR6WV9+UtGnsn776KGkrHC7X-T_wZWg@mail.gmail.com>
 <xmqqtwan8kjv.fsf@gitster.mtv.corp.google.com>
Cc:     Git mailing list <git@vger.kernel.org>, eevee.reply@veekun.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <11a8a411-528c-0e7d-b503-19bab6b6e7f1@web.de>
Date:   Fri, 2 Dec 2016 13:20:06 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqtwan8kjv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:rjUmO3hUNlCK9AMX3C4HT3oHO8IfsDFnmtxXvk6IV1DiEe/z3px
 v5HoaAsPqRrYN7pOchkKNyiYhgRcI6rVepgO1bc/gVnxvFbrqqiQHooITqgt6sMtvXJu/mz
 81UD1LCikvalsRhy55914sv1tVfOc8xHp5eMLFfWWlg4s1HEASRcVEiOYwxg3i0k/RBO8f+
 k/QW5t2T8nA6avXtGYg4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5vOOwddgOEg=:VNYAVHZsjBQxPMICry9dep
 bi0oaZ+APIT7oIoywExz5vWM8289NKoFfLAn9QeA1wcqwayPotmKk+0GnB/zIyWzFkujA/1w1
 iTJ2Wm8eaY1CgRnoGzbBfivfrLNZwo/hCTJIEPg+QAZjiay0F1I1A9r2Vu7E+3fPtj+ykD/MO
 C8uxfkFwAANX7TP2AyvACTbNJj8JET1SNtDpq9aT4kn339zmEYaJt5kZqhpHVDeNuCw+4fARW
 YCw5WpKStkKQJLfKHZHZG0zzWm9CAw3gh4B4fpqiV4lIYyH+f/YphcnoU7jH+GXyIFwWPvnoa
 oWGHyu4a0EoC70XRwwJlpyGCT4mJoi2ojradSjrzlQTQnc4DhnAusfrqjz5FlA/scMONFyzLW
 DaxLfKYoZ2lj7tRbKy0CWcjYP9F+9CeoM0jhKqNdzdf4+mmN7PFWxn4MKUw+jUGR9mLUlQ4vn
 ed64g0pFOQeXFiiM1KHFeff+OwdzHjwA84fObMzks4bZxe6Y13MhTUbOQwcqGDHSF6FdoVevM
 Yl7dm3NQPoRjN3XUdSOTx5PH8o6QC8eO7yg5RsyvYyGcL3xQIzqsba9ce5VYE6DKUk8rd18rm
 pK2RJSLOg2C3nRns5eYsxGdAosaejA00HrLqaDuKs07f/pzUePvMLWKtXieP0X3Q26qQ5a2hL
 kgMa9BsfZRX62OZxsF4P1vsAGFXjHJEz0moBqw7vb6tk57kqyIQz6sXZ9YUVzUEEx+8ida1nR
 XDrkcvc6R9tZr5igeLUo4oWQa7+jcMedFyHaVulBpgvms1w/cWQTPO1dyJea4qc5F/wYe934K
 mcA/BE/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Yup, this is what I queued.
>
Looks good, thanks you all.

