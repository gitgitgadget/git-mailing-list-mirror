Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7DF81F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 16:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941413AbcJTQf7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 12:35:59 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:37103 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S941206AbcJTQfp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 12:35:45 -0400
Received: (qmail 10734 invoked from network); 20 Oct 2016 16:35:37 -0000
Received: (qmail 9954 invoked from network); 20 Oct 2016 16:35:37 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 20 Oct 2016 16:35:35 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1476981335.14459.19.camel@sapo.pt>
Subject: Re: [PATCH v4 05/14] i18n: add--interactive: mark plural strings
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Date:   Thu, 20 Oct 2016 16:35:35 +0000
In-Reply-To: <20161010125449.7929-6-vascomalmeida@sapo.pt>
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
         <20161010125449.7929-6-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Seg, 10-10-2016 às 12:54 +0000, Vasco Almeida escreveu:
> @@ -70,6 +72,8 @@ Git::I18N - Perl interface to Git's Gettext localizations
>  
>         printf __("The following error occurred: %s\n"), $error;
>  
> +       printf __n("commited %d file", "commited %d files", $files), $files;
> +

I forgot to add \n to this example as suggested in
<xmqqoa2ymnb1.fsf@gitster.mtv.corp.google.com>

What should I do? Should I wait for more reviews and then send a new
re-roll fixing this?
