Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27D520437
	for <e@80x24.org>; Fri, 13 Oct 2017 22:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbdJMW0G (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 18:26:06 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:48352 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbdJMW0F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 18:26:05 -0400
Received: by mail-pg0-f52.google.com with SMTP id v78so2236799pgb.5
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 15:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0hu3M/XOsWtcjFdQlWMjlnQ09J08jAVo8kHUNDiGnig=;
        b=YooA12ZZuzgARGcmTwo3Uj7mvTCVk5w8umvTHVoxchV7gPVsXPWBlYNohXA46MbLuW
         0TcDw1bNPxpoftpp28VbTs3MxuJxJji3rT0dty6qrxuelS06GRse9qjN+14XQX76rJm6
         ZmoyXLh4v0gGfWJGMnxk8u0IaXj9xQBdghGx5U3oyeaeOWWYAcq0MxAV70GWb9std8S9
         8O91O60bPpAU6rSpJNPwChZymrOKDEzswyyB3BIwz0fiKCF3CAPxlwa8tDBO0VBbrf+r
         OSEQE/cwP8FR1uu7gNY+xb13wZNW8chvRaCnJd0S3q22axihwl+DiZz9/3e/mb0i1jXZ
         7P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0hu3M/XOsWtcjFdQlWMjlnQ09J08jAVo8kHUNDiGnig=;
        b=Ng+8ZcHY+FEd9YrXj2vLMpt8XGxqOJN6lh6+wPV3ugUBG2C/7KZpiVSZ8tMXuTuWCX
         uvcMZcblesTcmiLLPtioRggkQ8ryRg1Zfo4/8DP3dVXdsknyFfXwZhhlGGrTr+3reWI4
         BVKT7Twruiv/BgN1PN+eOdMbOmc7ATpcIXTbvegjVe7G7bFP7f2SPxFTupCRvECej8e7
         ddYzgdphyTOPPQe2XA11ywj0cvlZTduM2ULu2DYPr+PQbW9PPdPE6pEmx5GLDk36kWZM
         66CB/5D1sx5+2s5pQpdYt94xesI18f99UZXCHBjyXaOpnWyKJQD1OwE/+MxjrcwAGBy5
         gQYw==
X-Gm-Message-State: AMCzsaUM/v2XBfSB2MFk+hYEOdmVTIGGECtCd6c+qlY0LLJNCrLliacY
        ITDogxvvWOyAWoiCn3xH0SAdZg==
X-Google-Smtp-Source: AOwi7QCyjs/RJsFNOGQJTc//E9suNlTmVT1XK4zEOOB+xSRLpSDT9APeusoC3bN7nh3tUCCxZC5E5g==
X-Received: by 10.98.198.138 with SMTP id x10mr908886pfk.55.1507933564523;
        Fri, 13 Oct 2017 15:26:04 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b031:5884:4d4f:f3a9])
        by smtp.gmail.com with ESMTPSA id z8sm4252901pfl.135.2017.10.13.15.26.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 Oct 2017 15:26:03 -0700 (PDT)
Date:   Fri, 13 Oct 2017 15:26:01 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     bturner@atlassian.com, git@jeffhostetler.com, git@vger.kernel.org,
        gitster@pobox.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH] Documentation: document Extra Parameters
Message-ID: <20171013222601.GC101395@google.com>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171010193956.168385-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010193956.168385-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10, Jonathan Tan wrote:
> Document the server support for Extra Parameters, additional information
> that the client can send in its first message to the server during a
> Git client-server interaction.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I noticed that Documentation/technical was not updated in this patch
> series. It probably should, and here is a suggestion on how to do it.
> 
> Also, I'm not sure what to call the extra sendable information. I'm open
> to suggestions for a better name than Extra Parameters.

Thanks for writing this up.

> ---
>  Documentation/technical/http-protocol.txt |  8 ++++++
>  Documentation/technical/pack-protocol.txt | 43 ++++++++++++++++++++++++++-----
>  2 files changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
> index 1c561bdd9..a0e45f288 100644
> --- a/Documentation/technical/http-protocol.txt
> +++ b/Documentation/technical/http-protocol.txt
> @@ -219,6 +219,10 @@ smart server reply:
>     S: 003c2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0\n
>     S: 003fa3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}\n
>  
> +The client may send Extra Parameters (see
> +Documentation/technical/pack-protocol.txt) as a colon-separated string
> +in the Git-Protocol HTTP header.
> +
>  Dumb Server Response
>  ^^^^^^^^^^^^^^^^^^^^
>  Dumb servers MUST respond with the dumb server reply format.
> @@ -269,7 +273,11 @@ the C locale ordering.  The stream SHOULD include the default ref
>  named `HEAD` as the first ref.  The stream MUST include capability
>  declarations behind a NUL on the first ref.
>  
> +The returned response contains "version 1" if "version=1" was sent as an
> +Extra Parameter.
> +
>    smart_reply     =  PKT-LINE("# service=$servicename" LF)
> +		     *1("version 1")
>  		     ref_list
>  		     "0000"
>    ref_list        =  empty_list / non_empty_list
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index ed1eae8b8..f9ebfb23e 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -39,6 +39,19 @@ communicates with that invoked process over the SSH connection.
>  The file:// transport runs the 'upload-pack' or 'receive-pack'
>  process locally and communicates with it over a pipe.
>  
> +Extra Parameters
> +----------------
> +
> +The protocol provides a mechanism in which clients can send additional
> +information in its first message to the server. These are called "Extra
> +Parameters", and are supported by the Git, SSH, and HTTP protocols.
> +
> +Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
> +
> +Servers that receive any such Extra Parameters MUST ignore all
> +unrecognized keys. Currently, the only Extra Parameter recognized is
> +"version=1".
> +
>  Git Transport
>  -------------
>  
> @@ -46,18 +59,25 @@ The Git transport starts off by sending the command and repository
>  on the wire using the pkt-line format, followed by a NUL byte and a
>  hostname parameter, terminated by a NUL byte.
>  
> -   0032git-upload-pack /project.git\0host=myserver.com\0
> +   0033git-upload-pack /project.git\0host=myserver.com\0
> +
> +The transport may send Extra Parameters by adding an additional NUL
> +byte, and then adding one or more NUL-terminated strings:
> +
> +   003egit-upload-pack /project.git\0host=myserver.com\0\0version=1\0
>  
>  --
> -   git-proto-request = request-command SP pathname NUL [ host-parameter NUL ]
> +   git-proto-request = request-command SP pathname NUL
> +		       [ host-parameter NUL [ NUL extra-parameters ] ]

This should probably be "[ host-parameter NUL ] [ NUL extra-parameters ]"
because we don't want to require sending a host parameter in order to
send extra parameters.

>     request-command   = "git-upload-pack" / "git-receive-pack" /
>  		       "git-upload-archive"   ; case sensitive
>     pathname          = *( %x01-ff ) ; exclude NUL
>     host-parameter    = "host=" hostname [ ":" port ]
> +   extra-parameters  = 1*extra-parameter
> +   extra-parameter   = 1*( %x01-ff ) NUL
>  --
>  
> -Only host-parameter is allowed in the git-proto-request. Clients
> -MUST NOT attempt to send additional parameters. It is used for the
> +host-parameter is used for the
>  git-daemon name based virtual hosting.  See --interpolated-path
>  option to git daemon, with the %H/%CH format characters.
>  
> @@ -117,6 +137,12 @@ we execute it without the leading '/'.
>  		     v
>     ssh user@example.com "git-upload-pack '~alice/project.git'"
>  
> +Depending on the value of the `protocol.version` configuration variable,
> +Git may attempt to send Extra Parameters as a colon-separated string in
> +the GIT_PROTOCOL environment variable. This is done only if
> +the `ssh.variant` configuration variable indicates that the ssh command
> +supports passing environment variables as an argument.
> +
>  A few things to remember here:
>  
>  - The "command name" is spelled with dash (e.g. git-upload-pack), but
> @@ -137,11 +163,13 @@ Reference Discovery
>  -------------------
>  
>  When the client initially connects the server will immediately respond
> -with a listing of each reference it has (all branches and tags) along
> +with a version number (if "version=1" is sent as an Extra Parameter),
> +and a listing of each reference it has (all branches and tags) along
>  with the object name that each reference currently points to.
>  
> -   $ echo -e -n "0039git-upload-pack /schacon/gitbook.git\0host=example.com\0" |
> +   $ echo -e -n "0044git-upload-pack /schacon/gitbook.git\0host=example.com\0\0version=1\0" |
>        nc -v example.com 9418
> +   000aversion 1
>     00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack thin-pack
>  		side-band side-band-64k ofs-delta shallow no-progress include-tag
>     00441d3fcd5ced445d1abc402225c0b8a1299641f497 refs/heads/integration
> @@ -165,7 +193,8 @@ immediately after the ref itself, if presented. A conforming server
>  MUST peel the ref if it's an annotated tag.
>  
>  ----
> -  advertised-refs  =  (no-refs / list-of-refs)
> +  advertised-refs  =  *1("version 1")
> +		      (no-refs / list-of-refs)
>  		      *shallow
>  		      flush-pkt
>  
> -- 
> 2.14.2.920.gcf0c67979c-goog
> 

-- 
Brandon Williams
