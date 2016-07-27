Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC31203E2
	for <e@80x24.org>; Wed, 27 Jul 2016 10:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbcG0Kxv (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 06:53:51 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:53113 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752930AbcG0Kxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 06:53:51 -0400
Received: (qmail 4563 invoked from network); 27 Jul 2016 10:53:46 -0000
Received: (qmail 5206 invoked from network); 27 Jul 2016 10:53:46 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 27 Jul 2016 10:53:41 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1469616819.1858.25.camel@sapo.pt>
Subject: Re: [PATCH v3] i18n: notes: mark comment for translation
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Date:	Wed, 27 Jul 2016 10:53:39 +0000
In-Reply-To: <xmqqzip41gn5.fsf@gitster.mtv.corp.google.com>
References: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt>
	 <1469535400-9242-1-git-send-email-vascomalmeida@sapo.pt>
	 <xmqqzip41gn5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.4 (3.20.4-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A Ter, 26-07-2016 às 09:57 -0700, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
> > 
> > +		strbuf_add_commented_lines(&buf, "\n",
> > strlen("\n"));
> > +		strbuf_add_commented_lines(&buf, _(note_template),
> > strlen(_(note_template)));
> > +		strbuf_add_commented_lines(&buf, "\n",
> > strlen("\n"));
> 
> Hmm, do we really need to make three separate calls?

This patch does (1)

#
# Write/edit the notes for the following object:
#

The original source does (2)

#
# Write/edit the notes for the following object:

How do we want, (1) or (2) ?
