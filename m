Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B388E203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 15:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760795AbcJ1PdI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 11:33:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43166 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932740AbcJ1PdF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Oct 2016 11:33:05 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C2C1E206F0;
        Fri, 28 Oct 2016 11:33:04 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 28 Oct 2016 11:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-me-sender:x-sasl-enc:message-id:subject
        :from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=smtpout; bh=n+LJ2chBF
        q3Gyl4r2wOsXKhp6KA=; b=LgeTAswbL72WI96Yb7rJFBOWDJ6HODQQLULtRGkwf
        TJxTsg1hhB9ESt0GJaiZolrl0dF2SIxZXLDBDq/3UnBo0QOXI/9p8Jjaix4JawQ9
        n2zSJpKT93qMDEEB05l4c6k4NUBpOyudO0lHVnE7N2Hlk5nqfDS+3n2Le3klvD+A
        rY=
X-ME-Sender: <xms:sG8TWFcp22Dhjdwf6ldY8Bv_RSWAAkJ2_veNIr_ijvObP89OTxCjVw>
X-Sasl-enc: JlyP3KrtApDcPy/VJUlkpsLefqst9VgrVFog0Z/JHRpt 1477668784
Received: from xylitol (89-27-63-209.bb.dnainternet.fi [89.27.63.209])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1964BCC02C;
        Fri, 28 Oct 2016 11:33:03 -0400 (EDT)
Message-ID: <1477668782.1869.4.camel@seestieto.com>
Subject: Re: [PATCH] Fix typo in 2.11.0 RelNotes
From:   Henrik Ahlgren <pablo@seestieto.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Fri, 28 Oct 2016 18:33:02 +0300
In-Reply-To: <xmqqoa2439sp.fsf@gitster.mtv.corp.google.com>
References: <1477651639-11529-1-git-send-email-pablo@seestieto.com>
         <xmqqoa2439sp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2016-10-28 at 06:03 -0700, Junio C Hamano wrote:

> If the original text were like the following, would it have been
> clear enough that prevented you from sending your patch?
> 
>  * An empty string used as a pathspec element has always meant
>    'everything matches', but it is too easy to write a script that
>    finds a path to remove in $path and run 'git rm "$paht"' by 
>    mistake (when the user meant to give "$path"), which ends up
>    removing everything.  This release starts warning about the
>    use of an empty string that is used for 'everything matches' and
>    asks users to use a more explicit '.' for that instead.

Oops. Yes, but not sure if it really needs to be clear enough even for
idiots like me. :-) Sorry.


