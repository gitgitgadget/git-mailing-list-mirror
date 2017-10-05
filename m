Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E00020281
	for <e@80x24.org>; Thu,  5 Oct 2017 14:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdJEOVx (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 10:21:53 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:50328 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdJEOVw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 10:21:52 -0400
Received: by mail-ua0-f179.google.com with SMTP id v27so5299010uav.7
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3rXljSwjo3fwFbCSHC1UGDxm1PtFMaQC84YFnWsVdlw=;
        b=m0dWzumfT7SF8+LPijjevmGf1Hy9/q3+3DGPHEiE827aZxYvc/FMQprnYoXx+Cf+Cj
         SbR95z1JNhAn2wQiw4h8xhvT5GqI1fAe/MEfuE6FxTR0YSQmMDfAdXkTwOaZLnhkz/IG
         vwJsQ/2qFHykKiyoZB1ZokRHxqsGhx/pF7oOeZVmebMrbII1EJgQyK7tdUw3cJM9oEDc
         J0EVseles93a3ZvnZfES/hiwYjLl54qI+Sws4F5bkXjJj31whvf1fd3usNsdcSe4tTPn
         flEqtsjY3mzyEAZqtb4/YD8rbWFlG7V1DpGi9sfNAQYMYnvBLvx44REeZYICctPme2Nu
         /TCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3rXljSwjo3fwFbCSHC1UGDxm1PtFMaQC84YFnWsVdlw=;
        b=cqdnrYDHAndBhBZMqxnFslojrn0ULnZ+O678DRngeEM1wFKGTno1rXoKa0bwo2+bPz
         5Fjx6UZZhEprY2B7gvqP4xD1yolrTB36iDiF4ziwq3J8oN3PV0ejik+ev177aKibruc/
         qqHMsC1OzDwamu8+lAG/ccWCGMJ1WxRW+YF41jZnHNvESJCRTcswuQafZNnwQEuA8cJO
         atqulM/5TGVMphatczQuhQm0gicV7+kAdmRNFz3sXm84EcOAYlh/tutYw0vUFaFRxT8x
         U9LJPhzaw1MO/+IzGC0UxH0G9IoxXslMsRMYZCDkaLJvaJMv9wCpFCcxZnCgVQLNwWzp
         Kq/w==
X-Gm-Message-State: AHPjjUiHtzA4RYX3gAg9bDrxO4Q2nqJUF45CkWoJGDfD2Z54d/pG7shQ
        aQe83SRybAdwqbAay/UjjgWiGHDJK8Kz2j60Fso=
X-Google-Smtp-Source: AOwi7QDMX4tuwZJoFTEquXKBTPagJcAZcc4YRIIMfViuWex7rCTJSF+CMXJEAnBc/arHA0QDWBWaSMDdv3/LpBmKNro=
X-Received: by 10.176.21.228 with SMTP id j33mr16100799uae.55.1507213311187;
 Thu, 05 Oct 2017 07:21:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.11.4 with HTTP; Thu, 5 Oct 2017 07:21:20 -0700 (PDT)
In-Reply-To: <384b95b9-822a-872a-999a-10b5e1e60076@gnu.org>
References: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com> <384b95b9-822a-872a-999a-10b5e1e60076@gnu.org>
From:   ankostis <ankostis@gmail.com>
Date:   Thu, 5 Oct 2017 16:21:20 +0200
Message-ID: <CA+dhYEUb7uwpYazR1MXNYBXCTPipY0zVKDadnxOKMLaYiM932w@mail.gmail.com>
Subject: Re: git send-email does not work with Google anymore?!
To:     Paolo Bonzini <bonzini@gnu.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 October 2017 at 15:43, Paolo Bonzini <bonzini@gnu.org> wrote:
>
> On 05/10/2017 12:52, Lars Schneider wrote:
> > Hi,
> >
> > I used to use the Google SMTP server to send my patches to the list with
> > the following config:
> >
> >     [sendemail]
> >         smtpencryption = tls
> >         smtpserver = smtp.gmail.com
> >         smtpuser = larsxschneider@gmail.com
> >         smtpserverport = 587
> >         from = larsxschneider@gmail.com
> >         chainreplyto = false
> >         suppresscc = self
> >
> > Apparently that stopped working today. I get this error:
> >
> >     (mbox) Adding cc: Lars Schneider <larsxschneider@gmail.com> from line 'From: Lars Schneider <larsxschneider@gmail.com>'
> >     Password for 'smtp://larsxschneider@gmail.com@smtp.gmail.com:587':
> >     5.7.14 <https://accounts.google.com/signin/continue?...token...
> >     5.7.14 ...> Please log in via your web browser and
> >     5.7.14 then try again.
> >     5.7.14  Learn more at
> >     5.7.14  https://support.google.com/mail/answer/78754 ... - gsmtp
> >
> > Of couse I tried to log in via web browser etc. Does anyone else use
> > Google as SMTP server? If yes, does it work for you?

I have been using SMTP+GMail rather a lot, recently.
The situation is a mess, and it becomes worse by the month!

Till recently, you had to perform various steps to achieve this:

1. Got to your web-gmail, Settings | Forwarding and POP/IMAP | Enable
IMAP Access

2. Enable access for "Less secure apps":
   https://support.google.com/accounts/answer/6010255?hl=en

3. Try to SMTP-login.

   BUT if the IP had not access web-GMail recently,
   you got the message you report.
   So you had to:
   - reconstruct the URL+token intermingled in the SMTP-error message,
   - paste it in your browser, and
   - do a web-login to prove you are a human.

You had to perform step 3 regularly.


Now, if you had 2-factor-auth enabled, you could use
"app-passwords" to log into your gmail account:
https://support.google.com/accounts/answer/185833?hl=en

But this seems to have stopped working; I clicked the link in the page below
  https://support.google.com/accounts/answer/6010255?hl=en
and for my account it tells me "less secure apps" access is unavailable :-(



>
> It's probably a good idea to set up two-factor authentication and add an
> app-specific password for "git send-email" (at least that's what I do).
>
> The password can be stored encrypted using the OS keychain, or if you
> don't want/have one (e.g. you are running headless) you could check if
> your distro installs git-credential-netrc.  Create a ~/.netrc.gpg file,
> where the decrypted content should look like
>
>     machine smtp.gmail.com login larsxschneider@gmail.com password mypassword
>
> Then do
>
>     git config --global credential.helper netrc
>
> and you're all set. :)

I believe the best way forward is to use OAuth.



Ciao,
  Kostis
