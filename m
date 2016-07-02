Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BDC11F744
	for <e@80x24.org>; Sat,  2 Jul 2016 08:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbcGBIAE (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 04:00:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:64213 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbcGBIAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 04:00:03 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MgbTj-1avFAh3Rnb-00Nvgm; Sat, 02 Jul 2016 09:59:56
 +0200
Date:	Sat, 2 Jul 2016 09:59:54 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #01; Fri, 1)
In-Reply-To: <xmqqmvm0vry4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607020958210.12947@virtualbox>
References: <xmqqmvm0vry4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pm41VjLMVI4S1RKKDJNEDaBzB2K00JfR64PPuZoPNTFXCtSDYb0
 jBJ3lc7KT3qLp6LPCA6PUJZAAEb/1IQwDiXILzDXpAo9bFyGhr+6e3iAnpR3OHgcMg4edSG
 rGzsLgIIWRgmmio6OeJqTRl8XCO2sSOmFwqmaEz3ut6NuyqP8Z5vdxEo6UTFStW+HnZ4+WV
 Au3Ca9RT2UrWjxj/h/Cog==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ARy1BnB7NXk=:0XuDIYJq8cDkqHiHg1DvzY
 Dc4UnwCNh+g69qprtyC9QR5+nV8hjBUt0vjVw6ygShovEjuEPMtUsLTaZ4JeQApdURkLb4ZCQ
 UU8f7Y3oizjaJF65qS2lzhsVuNvBKJrkb1AQw5wSlsQCJK129ObxFcjh0HsPiJJ9aUcj0g6gm
 ez4Qqz70nIZFgSzj28/pUc6l4/lhBm1GfpfYuyj++x27ma0Hvr4ZPz21oAHgbyCM09GeecPAN
 OknYtiKm68c0BnxOSxEM5x0v5cWC1KgwOU4uZ5twARLWEVEKBaiMMUXrpHBZxkyvxuLNe7Lfh
 Y6gsLuzVjqBpdbW2WaKm0vLsJRofmMrQVK72xbnXF57QITHvYbMsokz/d+FRoltf+JtzQxWiu
 8R+WonXaR3m5/mbTDh+zawWrnogWxqKNdby+s2t19E/vC70MqmfRKm4qlwix/h9awF7TU4vg0
 JnBBZsNEpmmHrUFYNYc+WkzfHkhzArsQ480ndnf/C5DsDV/A/JlUL9uqLqm+BM9JNxkm4hz+k
 kcMDJaqhhrKLWHHZDcnMlHQ87Q4ZoADKisuRWtrjNnO0h1xdnJn+9gUVSRb70WYLa62rZgPoV
 X+jZQ7/k96Oo6T/sAIX3kzHB6YkKnofDdPDUa19+QD1ZnLXOjANqEt6UzLbKtR3FJEkacw3NE
 rnjrNNFkYAO/AMndoW+xslqrlbLYqlHCqqi34imIvzg67GX7fIRR1co0wGUM3GnCl3VX3ML1S
 kg9MzV5Cz/X4G6X68G8GuOqTzLvTW0u1F/YUdEbtJ0ows4yxyNw6Dy48/DI0BQzrrFQsVXqiv
 2nlmcuI
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Fri, 1 Jul 2016, Junio C Hamano wrote:

> * jk/common-main-2.8 (2016-07-01) 5 commits
>  - common-main: call git_setup_gettext()
>  - common-main: call restore_sigpipe_to_default()
>  - common-main: call sanitize_stdfds()
>  - common-main: call git_extract_argv0_path()
>  - add an extra level of indirection to main()
>  (this branch is used by jk/common-main.)
> 
>  There are certain house-keeping tasks that need to be performed at
>  the very beginning of any Git program, and programs that are not
>  built-in commands had to do them exactly the same way as "git"
>  potty does.  It was easy to make mistakes in one-off standalone
>  programs (like test helpers).  A common "main()" function that
>  calls cmd_main() of individual program has been introduced to
>  make it harder to make mistakes.

To make it easier, I pushed my version of the patch series (including the
one required to be able to build with DEVELOPER=1) as 'common-main-maint'
to https://github.com/dscho/git.

Ciao,
Dscho
