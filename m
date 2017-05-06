Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D002207B3
	for <e@80x24.org>; Sat,  6 May 2017 00:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbdEFAK4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 20:10:56 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36195 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbdEFAK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 20:10:56 -0400
Received: by mail-pf0-f179.google.com with SMTP id q66so9141940pfi.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 17:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MyS0QBvO95Yk1k9akl8h/vZQMxUfRESaUCS4IYuEaeQ=;
        b=NLjXhVQHqvkpQluF4Sf3ABTFY9qMTYL6OAA+JA5TP4KJxBTikaYOQMfu0MTrzkACip
         CEe6QlsEzHA0Um5nI0k+BewPRCdPd6wpS630JGfPqZg9WySM/Umka4CwG9Ch8TmxiG2o
         x726rcXW3BnaFd6wv8P89Pvp5RnNrAERi79vo9XZo+b1IsZiCmfaFZ1au9D7a5alIqF8
         r5c9utdkEq8mhuY2rsKBTb/ungyIlE34XxuIhhWjcaCnBm6f8LE8xZPIeuM3XEBA2Bne
         AKq+p71I2D2t96LWBo+K9rnf4jWo7CPObSdi6hhBw6hywmr72DCxHPCCU+v+TYz06Kwx
         ZN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MyS0QBvO95Yk1k9akl8h/vZQMxUfRESaUCS4IYuEaeQ=;
        b=lBfAKjlWUEoiCjZxPOzWxJ/tQ4Y4CTe3tTZpMYRw791CmUjKJ+58bl+Zl4ueBWISE4
         eil5TJREIxUSfsIyuEdqg/ZzFdXBRFzm37le4cXGJqc6OYtV5IcyLDAEzH8aDii+U8b4
         Qy+8+9JEuXTgFYsb1lMxqGD4fWQZ208Hkwo9v3Vn4wgtdVSt+mqUMXTMVzCHkgo/sxdF
         WITOZDJIq9g4aqYl8kF1DUKt9S43iRBz88VNEFIm7bAeQoChpxz03WtdVkcGsGE9xz+Z
         kZvS0/70uyCOFzYwf3MA39MyEoNkYJeoAm6sBnKz7EttMUru/PD0k4dyq40vlxfMPK+F
         uFnw==
X-Gm-Message-State: AN3rC/7h7BL3N8eWIM7cA4yL7IaQsaRqIGmjI3MeX/b2sG6LNa6KHlI0
        uQJdtZDF5VjCN4hxkKqeWqZMrrOiHf0s
X-Received: by 10.99.56.66 with SMTP id h2mr6572905pgn.40.1494029455175; Fri,
 05 May 2017 17:10:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Fri, 5 May 2017 17:10:54 -0700 (PDT)
In-Reply-To: <615007182a5e205a7074317a4c8788aa4eb009ff.1494027001.git.jonathantanmy@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com> <615007182a5e205a7074317a4c8788aa4eb009ff.1494027001.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 5 May 2017 17:10:54 -0700
Message-ID: <CAGZ79kb5vQ6_3j6r7szDvXtOdCSx6-HUeMuC9yjgMHL0jvA5BQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] protocol docs: explain receive-pack push options
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 4:46 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Support for push options in the receive-pack protocol (and all Git
> components that speak it) have been added over a few commits, but not
> fully documented (especially its interaction with signed pushes). Update
> the protocol documentation to include the relevant details.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/technical/pack-protocol.txt | 32 +++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index 5b0ba3ef2..cf7cb48c3 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -473,13 +473,10 @@ that it wants to update, it sends a line listing the obj-id currently on
>  the server, the obj-id the client would like to update it to and the name
>  of the reference.
>
> -This list is followed by a flush-pkt. Then the push options are transmitted
> -one per packet followed by another flush-pkt. After that the packfile that
> -should contain all the objects that the server will need to complete the new
> -references will be sent.
> +This list is followed by a flush-pkt.
>
>  ----
> -  update-request    =  *shallow ( command-list | push-cert ) [packfile]
> +  update-request    =  *shallow ( command-list | push-cert )
>
>    shallow           =  PKT-LINE("shallow" SP obj-id)
>
> @@ -500,12 +497,35 @@ references will be sent.
>                       PKT-LINE("pusher" SP ident LF)
>                       PKT-LINE("pushee" SP url LF)
>                       PKT-LINE("nonce" SP nonce LF)
> +                     *PKT-LINE("push-option" SP push-option LF)
>                       PKT-LINE(LF)
>                       *PKT-LINE(command LF)
>                       *PKT-LINE(gpg-signature-lines LF)
>                       PKT-LINE("push-cert-end" LF)
>
> -  packfile          = "PACK" 28*(OCTET)
> +  push-option       =  1*CHAR
> +----
> +
> +If the server has advertised the 'push-options' capability and the client has
> +specified 'push-options' as part of the capability list above, the client then
> +sends its push options followed by a flush-pkt.

The CHAR of the push-options SHOULD NOT include an LF. Well I guess that may
be obvious when looking at PKT-LINE("push-option" SP push-option LF),
not sure if we want to mention it here.

> +
> +----
> +  push-options      =  *PKT-LINE(push-option) flush-pkt
> +----
> +
> +For backwards compatibility with older Git servers, if the client sends a push
> +cert and push options, it SHOULD send its push options both embedded within the
> +push cert and after the push cert. (Note that the push options within the cert
> +are prefixed, but the push options after the cert are not.) Both these lists
> +SHOULD be consistent.

s/SHOULD/MUST/ ?

> +
> +After that the packfile that
> +should contain all the objects that the server will need to complete the new
> +references will be sent.
> +
> +----
> +  packfile          =  "PACK" 28*(OCTET)
>  ----
>
>  If the receiving end does not support delete-refs, the sending end MUST
> --
> 2.13.0.rc1.294.g07d810a77f-goog

Thanks for writing the docs.

Stefan


>
