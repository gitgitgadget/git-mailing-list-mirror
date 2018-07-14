Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BCF1F933
	for <e@80x24.org>; Sat, 14 Jul 2018 21:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbeGNV72 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 17:59:28 -0400
Received: from mail.aegee.org ([144.76.142.78]:46909 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731285AbeGNV72 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 17:59:28 -0400
Authentication-Results: mail.aegee.org/w6ELcxT0015029; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1531604340; i=dkim+MSA-tls@aegee.org; r=y;
        bh=2Q4iJtkg+HzTB5Zhp4i67lHGAhJwXaQ8PZT4pm9fL3A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=TsUqDIOYpUcmASGllkm1QYRH698x6Om2ZJDgPcRziGhatc7LbG7wSooFl6fHXMrmT
         YHrtrPFy2W1xnjd9e5BiZrloEgwqXybgq3B3Fq7cFLHWKLhN6jMa6muFlsMT59YVMF
         ywXw53E/vR+OzCGpeN+D59pMzIGKbgBoTFNbGRMcHNEV3VZ7VE4Qw97IRfOQngwtfJ
         QMk0NC2P3UXDytG7vk9ayatSN0mOce6r6D6Dhuk3SKVCKBC0x8jayD2Pq9piS2FimU
         bHP7TA5zhFlemdroStbzBHrt3Ouj8JNXjq6+55zH9MnKCwUXOXniryK9kb4mdjOYX4
         /H6iPsfyO/ciGegF2FkYw/aFfBZNIhOslIlWDpEe5/w3y7/HWkKp1AunCQkCUKtX81
         Qvu826OxkOMmVbb6WGT4byVlNo2HUyDmitU78MJMrBlv8m+U1NbLf7+mUKNoaNu4ar
         M+VdRiO0AUDk547SzN7dCwaE1imt9S4/HaDZDZOyVDijLjXAbC8eaGyUBwtAh8uOVb
         Jr0WU+VYKEflyuzVFQAIpQBn4xho/0m1esO2eUxfDDZad7JAaZHKn8WbKddpkJO2wz
         XlMOygdlasScprxQd65RptydFaKRt13FbqQNWdD4Ed+Hf5RqlIkuK5kz3cWWTCaN+U
         9ig7LwBKvYKwUuXuMKMfcA4s=
Authentication-Results: mail.aegee.org/w6ELcxT0015029; dkim=none
Received: from Tylan (80-110-70-253.cgn.dynamic.surfer.at [80.110.70.253])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id w6ELcxT0015029
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 14 Jul 2018 21:38:59 GMT
Message-ID: <05bba1ef0a5da7662cc8c09f90bacc9059eeac05.camel@aegee.org>
Subject: Re: bash completion with 2.18.0/maint: unknown options
From:   =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
         =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?= 
        <Dilyan.Palauzov@aegee.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Sat, 14 Jul 2018 21:38:59 +0000
In-Reply-To: <20180714212433.GB6430@sigill.intra.peff.net>
References: <d9272a12c2a38429857777f7811010956b7b6ed5.camel@aegee.org>
         <20180714212433.GB6430@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.29.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.1 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jeff,

thanks for your answer.  You are right: I have forgotten to run 'make
install'.  After doing so the completion works again.

type git reports /usr/local/bin/git

Regards
  Дилян

On Sat, 2018-07-14 at 17:24 -0400, Jeff King wrote:
> On Sat, Jul 14, 2018 at 02:46:17PM +0000, Дилян Палаузов wrote:
> 
> > After upgrading to 2.18 the completion does not work:
> > 
> > typing "git de<TAB>" prints
> > my@host:~$ git deUnknown option: --list-cmds=list-
> > mainporcelain,others,nohelpers,alias,list-complete,config
> > usage: git [--version] [--help] [-C <path>] [-c name=value]
> > [...]
> 
> In v2.18, the completions are generated programatically using new
> options added to the git binary. The completion and the git binary
> you're using have to be upgraded in lockstep (this has always been the
> case, though I think this is probably the case where not doing so would
> have the biggest effect).
> 
> Are you sure the git binary you're running matches the completion?
> 
> You mentioned that you're sourcing the completion from a clone in
> /git/git. What does `type git` report?
> 
> -Peff

