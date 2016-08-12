Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E2E203BD
	for <e@80x24.org>; Fri, 12 Aug 2016 07:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbcHLHtP convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Fri, 12 Aug 2016 03:49:15 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:48040 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959AbcHLHtM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2016 03:49:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8F2042670;
	Fri, 12 Aug 2016 09:49:08 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gUkdSKTYcUIe; Fri, 12 Aug 2016 09:49:08 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 740B92618;
	Fri, 12 Aug 2016 09:49:08 +0200 (CEST)
Date:	Fri, 12 Aug 2016 10:09:38 +0200 (CEST)
From:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To:	Stefan Beller <sbeller@google.com>
Cc:	gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
Message-ID: <2038600423.1215501.1470989378002.JavaMail.zimbra@ensimag.grenoble-inp.fr>
In-Reply-To: <20160812002947.1582-1-sbeller@google.com>
References: <20160812002947.1582-1-sbeller@google.com>
Subject: Re: [PATCHv2] checkout: do not mention detach advice for explicit
 --detach option
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: checkout: do not mention detach advice for explicit --detach option
Thread-Index: 2FP0d2HpDzNAZfOrKwIhd2i7fOB8Ng==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:
> +test_expect_success 'no advice given for explicit detached head state' '
> +        git config advice.detachedHead false &&
> +        git checkout child &&
> +        git checkout --detach HEAD >expect &&
> +        git config advice.detachedHead true &&

Is there a reason for not unsetting `advice.detachedHead` at the
end of the test?

Thanks,
Rémi
