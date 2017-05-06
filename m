Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909C7207B3
	for <e@80x24.org>; Sat,  6 May 2017 00:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbdEFA0J (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 20:26:09 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35402 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdEFA0I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 20:26:08 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so2403470pfd.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 17:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Df9IET3VyBqq6lPAuiDLouVxVvGX7V3Cx3z2HEGh4zQ=;
        b=YN5ArDJAy+yT+HLbbsn/ND66nRD25HGGZuLYuTMLqwc3D6gDTHFpWH26GmE+oKMRVZ
         fKqFBwxGcxFGoqUvEmydMKqyFInAcIMMkszkleh8JAWJYOchyIaTOMWOpAj5kiA6E9dM
         DhpEw2MNJzej54PUZdFp03Ug3IemzojFOzU3JssUyGszaLlLRwwviQNEGLiErI+BT+Bw
         YlpckrFD2E98x498E3nyDkUNl2hL+flSTSKG+gRlMkao3NaJDBPmQoUbTwOLgZN7AVXz
         4ycQGFq2+sb9/VVd7xnKSrlden3iXQlTz/da7OQVt3QWoNsscgmLx11iU4Yl2ZxM+FPn
         b5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Df9IET3VyBqq6lPAuiDLouVxVvGX7V3Cx3z2HEGh4zQ=;
        b=e7kx5TOS6m4KZ8C1D6qh2VsZrDimt1lME/Q/Hio1Kp+02d7P7WaWAxOcJ9hTVm7cOA
         /g0+1SGyNFJSYlA98439xbLZpr8gekBrsAlSEHFGJKocsY/DtSLs3DHFBLw5VBMY9T3P
         XWX7q6AWI0c/0I69DjVRK+EidLynFyLb2sKbRQsk64YVJsY2eEhTp2MTl0uUygxpa6CG
         JVXWU6gx6aP+lr+qgsP7XMqvQfr12P2EtLGL2Sh6BxVjDIXIcbHsO618Y0Hrsg7Bd8jn
         Bls6Cl5uZJURHFIZ7PIHI9JwsPTZ2g0zt6Ypj1Ixx7nrRYw3AGofwYWB/epKeLmAUfC9
         B9cw==
X-Gm-Message-State: AN3rC/6AAoPh+TEfcjBc9t12izM73Xj70Hr9tqTCTxqwH50QxDXKSEi1
        tgnJZmfifZxAEg==
X-Received: by 10.99.126.92 with SMTP id o28mr6594881pgn.63.1494030367884;
        Fri, 05 May 2017 17:26:07 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:5d98:2d3c:6099:849])
        by smtp.gmail.com with ESMTPSA id t5sm5147605pgo.48.2017.05.05.17.26.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 17:26:07 -0700 (PDT)
Date:   Fri, 5 May 2017 17:26:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 3/3] protocol docs: explain receive-pack push options
Message-ID: <20170506002605.GM28740@aiede.svl.corp.google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
 <615007182a5e205a7074317a4c8788aa4eb009ff.1494027001.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <615007182a5e205a7074317a4c8788aa4eb009ff.1494027001.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> Support for push options in the receive-pack protocol (and all Git
> components that speak it) have been added over a few commits, but not
> fully documented (especially its interaction with signed pushes). Update
> the protocol documentation to include the relevant details.

Thanks.  This could be combined with the previous patch, since that
patch is enforcing what this patch documents.

[...]
> -This list is followed by a flush-pkt. Then the push options are transmitted
> -one per packet followed by another flush-pkt. After that the packfile that
> -should contain all the objects that the server will need to complete the new
> -references will be sent.
> +This list is followed by a flush-pkt.

I think this removed more than intended.

Before c714e45f (receive-pack: implement advertising and receiving
push options, 2016-07-14), this said

	This list is followed by a flush-pkt and then the packfile that should
	contain all the objects that the server will need to complete the new
	references.

which I think would work fine.

[...]
> -  update-request    =  *shallow ( command-list | push-cert ) [packfile]
> +  update-request    =  *shallow ( command-list | push-cert )

This seems confusing to me both before and after.  How does
update-request get used?  Is it supposed to include the packfile or not?

Where do push-options fit into an unsigned request?

[...]
> @@ -500,12 +497,35 @@ references will be sent.
>  		      PKT-LINE("pusher" SP ident LF)
>  		      PKT-LINE("pushee" SP url LF)
>  		      PKT-LINE("nonce" SP nonce LF)
> +		      *PKT-LINE("push-option" SP push-option LF)
>  		      PKT-LINE(LF)
>  		      *PKT-LINE(command LF)
>  		      *PKT-LINE(gpg-signature-lines LF)
>  		      PKT-LINE("push-cert-end" LF)
>  
> -  packfile          = "PACK" 28*(OCTET)
> +  push-option       =  1*CHAR
> +----
> +
> +If the server has advertised the 'push-options' capability and the client has
> +specified 'push-options' as part of the capability list above, the client then
> +sends its push options followed by a flush-pkt.
> +
> +----
> +  push-options      =  *PKT-LINE(push-option) flush-pkt
> +----
> +
> +For backwards compatibility with older Git servers, if the client sends a push
> +cert and push options, it SHOULD send its push options both embedded within the

This needs to be a MUST, not SHOULD.

> +push cert and after the push cert. (Note that the push options within the cert
> +are prefixed, but the push options after the cert are not.) Both these lists
> +SHOULD be consistent.

Likewise this one.

What does it mean to be consistent?

> +
> +After that the packfile that
> +should contain all the objects that the server will need to complete the new
> +references will be sent.
> +
> +----
> +  packfile          =  "PACK" 28*(OCTET)
>  ----

Thanks,
Jonathan
