Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE501F424
	for <e@80x24.org>; Fri, 13 Apr 2018 08:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeDMIHP (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 04:07:15 -0400
Received: from ao2.it ([92.243.12.208]:53694 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752846AbeDMIHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 04:07:09 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6tie-0007gY-5b; Fri, 13 Apr 2018 10:06:04 +0200
Date:   Fri, 13 Apr 2018 10:07:07 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: Re: [RFC 00/10] Make .the gitmodules file path configurable
Message-Id: <20180413100707.945b38dde1c75ebea8360858@ao2.it>
In-Reply-To: <20180412222047.5716-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 13 Apr 2018 00:20:37 +0200
Antonio Ospite <ao2@ao2.it> wrote:

[...]
> Antonio Ospite (10):
>   submodule: add 'core.submodulesFile' to override the '.gitmodules'
>     path
>   submodule: fix getting custom gitmodule file in fetch command
>   submodule: use the 'submodules_file' variable in output messages
>   submodule: document 'core.submodulesFile' and fix references to
>     '.gitmodules'
>   submodule: adjust references to '.gitmodules' in comments
>   completion: add 'core.submodulesfile' to the git-completion.bash file
>   XXX: wrap-for-bin.sh: set 'core.submodulesFile' for each git
>     invocation
>   XXX: submodule: fix t1300-repo-config.sh to take into account the new
>     config
>   XXX: submodule: pass custom gitmodules file to 'test-tool
>     submodule-config'
>   XXX: add a hacky script to test the changes with a patched test suite
> 

I am re-sending the last four highly experimental patches changing the
"XXX" into "FIXME" in the subject lines because vger.kernel.org refused
the original ones with the following message:

  The capital Triple-X in subject is way too often associated with junk
  email, please rephrase.

Sorry for the inconvenience.

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
