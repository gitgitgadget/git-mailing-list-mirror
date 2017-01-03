Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F6F205C9
	for <e@80x24.org>; Wed,  4 Jan 2017 09:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967406AbdADJto (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 04:49:44 -0500
Received: from mout.gmx.net ([212.227.17.21]:57546 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753489AbdADJtl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 04:49:41 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTjMy-1byHIF3C1A-00QWWS; Wed, 04
 Jan 2017 10:42:55 +0100
Date:   Tue, 3 Jan 2017 22:33:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v4 1/4] Avoid Coverity warning about unfree()d
 git_exec_path()
In-Reply-To: <CAGZ79kZ--jp08pK+xwn1N2VQQr8bA5+DveE2HsoY90R1gR6c_A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701032231400.3469@virtualbox>
References: <cover.1480019834.git.johannes.schindelin@gmx.de> <cover.1483373635.git.johannes.schindelin@gmx.de> <18e9a1009aac2329cb9bf9d12fbac4e8ac19a5bb.1483373635.git.johannes.schindelin@gmx.de>
 <CAGZ79kZ--jp08pK+xwn1N2VQQr8bA5+DveE2HsoY90R1gR6c_A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:W2/EED7pSeJn/MvD+v/VG5IlBl67b12YU/NT+Gsxbzt/fUcOtLN
 Km74SFfoWyUt14vvAxxQ7s7HugXsDnaAZWJQvFU6UryPAOgdQt/qt1gENNEewB9NMHUb1/D
 fQNB7BRk2eiJ5VyalrS8gJJ8CZabeTC9tIelREIZ1+C4O/Dhgu5i0lB71YRm7PR6YwKdg4s
 gM0g9y9+rbYaZ7SFmB/Xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uXwPaQAocUU=:p6l6Tei5kSr6Lg1akX/SvE
 Fx5Nzl/7PLXeuf/z6tsMiI0euWmsMaXdqkh4ftVU+aV/KL/SbS3xykVUpE/7cVn50XCGSyqJT
 8tmeV/I25eur9413cE9f+LlqsAMK/svxWV8jpyx8ElPA5U2sXhy90HmeK4xzOqiYPHih8nhH2
 u/BLPqA6GDgdG0tVA02qeOM33tbIzGyefS6jyjzP1Nk2T5SDnMnIJfa6QcoNvx4+cW/OhDdZB
 6XbeaJBxOB8KCvrS4LRLJa5X8KeC/mZjTwx4Ui2nHS2GGrgWYkMmjW3g8iQFHsT1QAWtLBQau
 OM5QJi3r+AdyHBQE+pPftv4jhqEjYTZmjEp7FAFK7dtKF6bxFWz8/NBpIDDi6Z7/n5dh6jyny
 imSbWqMe9njObDo8BEnagxGNi88qbZLhilwGdHOljlM9v7Carza4YYW58OWHhqsNjIyVy86fN
 ew1xTl3S01bv1+OlIhk/cT8LCFHxgPpMEiOtQXquPqgD1UiEZCRobUUWjzQOo3a2LDk3P0xAI
 XakNpsYOQMkVgKSTX3yWxFL2hpNLeIGSVOfy516pKhigeylijLpj48jffs8IwgwPzLEAV3yco
 plc5+zRJ4HNaPJbjRZxfZY/S+JOyiMldKWo9wN6gPu0Vwj45M791LLI8ZQgf1OlvV2ab8qdII
 cMnkfXlhyr1OX6puaRm7KDfK77Ofhq7yBGGwfJ0OpcHl2AHoR3LlnyGVRT0R2NjlxvQsh9vic
 pjHKEMPcDVJCxHkGfEN+rPVXdWxNcniHNyovLFr7kN041ylViVK24KeN/NAnTvZ9+3Wn3g3CU
 AFCC3+TrcviITn9rSXh0IRRy+urOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 3 Jan 2017, Stefan Beller wrote:

> On Mon, Jan 2, 2017 at 8:22 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > Technically, it is correct that git_exec_path() returns a possibly
> > malloc()ed string. Practically, it is *sometimes* not malloc()ed. So
> > let's just use a static variable to make it a singleton. That'll shut
> > Coverity up, hopefully.
> 
> I picked up this patch and applied it to the coverity branch
> that I maintain at github/stefanbeller/git.
> 
> I'd love to see this patch upstream as it reduces my maintenance
> burden of the coverity branch by a patch.
> 
> Early on when Git was new to coverity, some arguments were made
> that patches like these only clutter the main code base which is read
> by a lot of people, hence we want these quirks for coverity not upstream.
> And I think that still holds.
> 
> If this patch is only to appease coverity (as the commit message eludes
> to) I think this may be a bad idea for upstream.  If this patch fixes an
> actual problem, then the commit message needs to spell that out.

This patch was originally only to appease Coverity, but it actually *does*
plug a very real memory leak: previously, *every* call to git_exec_path()
*possibly* returned a newly-malloc()ed buffer. Now, the first call will
store that pointer in a static variable and reuse it later.

Could you maybe help me with improving the commit message?

Ciao,
Dscho
