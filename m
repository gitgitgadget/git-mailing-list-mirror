Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A4B1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 18:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeJWCXF (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 22:23:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43763 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbeJWCXF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 22:23:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id k9so40956977otl.10
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyDF8q4kBlQ+LBnDbyUyDAgZubeZV62nkcRN76vtmvk=;
        b=k0CLQ41rvMvdwX+RwslvbSPSu7NVQIv1DmOv8mNQ2atmlkwfh0KEUg0LraMsBmdicm
         y0e9DbNuRd4UDl6z43myKMp6ZKvgMleuY6epLYrF+3tYjQsHVau2b7o5HOm+OyVWrHDa
         FAbrABITE8HDkKH34NvDAEVsaI4Ud/XuScyvNqdPr4FaeSlb3rfSSVT6rHUAjoR7EPnM
         dLOeZq0zzrQCMPx0e0eVHqPl4VCJfhSzxYVxgyBY29FWK1fC4/CFOJ3rNWf11vOZsBD9
         rdl2Gq7Tsdhp98HNSuF+77JpjwzmtqeJUx3HDnV+bs/dxrrFcOqbz6hC1Ob5PCDp2x/b
         MK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyDF8q4kBlQ+LBnDbyUyDAgZubeZV62nkcRN76vtmvk=;
        b=Th0KjdS2slapfNCx8XTlmqPEYz5I4EUHw0prB07taWoHsJDAyGvFlyKshw7VcPFUF4
         MEgyp91FDIuguDMhtYg/0WfN2l3NoWxST0STGmPWt2L8gdCOTZS0vkQVZuYQKx7jaSgf
         lQnH0WRqoRvu0IuI7/6NYHjo6L0m7H7WNOMzz6GSrTaaTiyeYyJmVcvZZJjQ4ojeF+6Y
         Nqpc2BN7Bo9Y5xULA6x4vsXmQGfhciAa/3KlceqtBdV99UP98I4yR9cWWnH5SuxN73GV
         8JovqLzAOKRMF1A1rvTRRyjhb5eL0o1l4t7CkOYjml+7mr7D00+2hRm5AwGhTu1J+dkY
         /Q4g==
X-Gm-Message-State: ABuFfohoY1AvYfIQBEl9Q0Lg7RO6ZZTGFq7gSiN6OcNsGyNPjMnV2AEx
        n9a1R9rxh3EXpLvdS3BrS9eXU+E1BUy/SIENz6paBw==
X-Google-Smtp-Source: ACcGV60dAyJ6tmY5fHAJ0HqjJciQK96pK2rjLBsAfveis7a+oh8xYfbbUrcMHUzRLmbjKXHozL5Qeb1tFDoUeVhxWMw=
X-Received: by 2002:a9d:477:: with SMTP id 110mr28807297otc.78.1540231411556;
 Mon, 22 Oct 2018 11:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181018211527.25597-1-JPEWhacker@gmail.com> <20181022175248.3940-1-JPEWhacker@gmail.com>
In-Reply-To: <20181022175248.3940-1-JPEWhacker@gmail.com>
From:   Joshua Watt <jpewhacker@gmail.com>
Date:   Mon, 22 Oct 2018 13:03:20 -0500
Message-ID: <CAJdd5Gaq+YaMZiE3MF0XzeB62w-qD4d8KOyBkPJxOfuFxqXukg@mail.gmail.com>
Subject: Re: [PATCH v2] send-email: explicitly disable authentication
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 12:52 PM Joshua Watt <jpewhacker@gmail.com> wrote:
>
> It can be necessary to disable SMTP authentication by a mechanism other
> than sendemail.smtpuser being undefined. For example, if the user has
> sendemail.smtpuser set globally but wants to disable authentication
> locally in one repository.
>
> --smtp-auth and sendemail.smtpauth now understand the value 'none' which
> means to disable authentication completely, even if an authentication
> user is specified.
>
> The value 'none' is lower case to avoid conflicts with any RFC 4422
> authentication mechanisms.
>
> The user may also specify the command line argument --no-smtp-auth as a
> shorthand for --smtp-auth=none
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  Documentation/git-send-email.txt | 7 ++++++-
>  git-send-email.perl              | 8 ++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 465a4ecbe..17993e3c9 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -190,7 +190,9 @@ $ git send-email --smtp-auth="PLAIN LOGIN GSSAPI" ...
>  If at least one of the specified mechanisms matches the ones advertised by the
>  SMTP server and if it is supported by the utilized SASL library, the mechanism
>  is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
> -is specified, all mechanisms supported by the SASL library can be used.
> +is specified, all mechanisms supported by the SASL library can be used. The
> +special value 'none' maybe specified to completely disable authentication
> +independently of `--smtp-user`
>
>  --smtp-pass[=<password>]::
>         Password for SMTP-AUTH. The argument is optional: If no
> @@ -204,6 +206,9 @@ or on the command line. If a username has been specified (with
>  specified (with `--smtp-pass` or `sendemail.smtpPass`), then
>  a password is obtained using 'git-credential'.
>
> +--no-smtp-auth::
> +       Disable SMTP authentication. Short hand for `--smtp-auth=none`
> +
>  --smtp-server=<host>::
>         If set, specifies the outgoing SMTP server to use (e.g.
>         `smtp.example.com` or a raw IP address).  Alternatively it can
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2be5dac33..7d7e69581 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -82,8 +82,11 @@ sub usage {
>                                       Pass an empty string to disable certificate
>                                       verification.
>      --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
> -    --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms.
> +    --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms, or
> +                                     "none" to disable authentication.
>                                       This setting forces to use one of the listed mechanisms.
> +    --no-smtp-auth                   Disable SMTP authentication. Shorthand for
> +                                     `--smtp-auth=none`
>      --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
>
>      --batch-size            <int>  * send max <int> message per connection.
> @@ -341,6 +344,7 @@ sub signal_handler {
>                     "smtp-debug:i" => \$debug_net_smtp,
>                     "smtp-domain:s" => \$smtp_domain,
>                     "smtp-auth=s" => \$smtp_auth,
> +                   "no-smtp-auth" => sub {$smtp_auth = 'none'},
>                     "identity=s" => \$identity,
>                     "annotate!" => \$annotate,
>                     "no-annotate" => sub {$annotate = 0},
> @@ -1241,7 +1245,7 @@ sub smtp_host_string {
>  # (smtp_user was not specified), and 0 otherwise.
>
>  sub smtp_auth_maybe {
> -       if (!defined $smtp_authuser || $auth) {
> +       if (!defined $smtp_authuser || $auth || $smtp_auth eq "none") {

Oops, this generates a warning when no smtp auth argument is supplied
(comparison to undefined value). Version 3 will be along shortly.

>                 return 1;
>         }
>
> --
> 2.19.1.543.g99a77c85e.dirty
>
