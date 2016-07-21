Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB4020195
	for <e@80x24.org>; Thu, 21 Jul 2016 10:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbcGUKpn (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 06:45:43 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33837 "EHLO
	mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbcGUKpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 06:45:42 -0400
Received: by mail-qt0-f196.google.com with SMTP id c52so3594486qte.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2016 03:45:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2ZsGoVP6pk8y3PGmNG9ctHj2dz+F0vhtE35yDHlASDU=;
        b=dr6hkjs8p7rOnl6VWBhqJEimb6Blye5Wp8gTxfYl6ggxc+LOroS1ZYWz15uplfOWIo
         lzAfbf73ejtXZC3Dh1PKHGRLZ2AQAZygGQmHgRvdfgaEWPfJ/5QB7z6ZzTE370Kei1hA
         TqVA4hWMgvihvKeyWRon5hD9CR8eR6uWKSdx2BS+slCbxw45wYP1zJp0rKk8Vlgyh9lI
         RrwtUAccZhO9bx9EVrcPsY1bvgu9AeBRqLrw3iueV5xVkj0COtQAOnyyP+f9vQFa3AbW
         SDw2hdFajzyapElIlMEN6DW9RDkVjjOMURYXcrs89MXtDze+jjha2EBmtk7HsfHhcpI5
         A/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2ZsGoVP6pk8y3PGmNG9ctHj2dz+F0vhtE35yDHlASDU=;
        b=NJ7qxtHfHwVwYe3+Cgv1hXY9F8QWWVq93cSvkZ/9vGio7F66wYb+gMn09za61YgjpN
         dN+/OKx445gwWactTP+yOxMsBV81uFeVacjS3NGMT2bLfSnaXCHrI8wAeUUwORpZ6X42
         uLuHJ88EbSW6GcSUxBp+8lxxkOJBvDnLHPfIQCZbiYb6egrYXVw40WyzzqTYzJQNYxn6
         6q2R7HRgBqYwWykQ4IdbRjtAYrb9lH2NSxReD+MFCb0r9XWSzzWJkMSUcyBtSAl0a4O9
         UVRIALu2bvIr5gwxUG4brOyRwxXcZa7mbTPsaF/V5bM+S2PYaQPPzt9oF+tIx47VYHu3
         H2fA==
X-Gm-Message-State: ALyK8tLA0PAeESkMSMx6xrTCOOzLRzwQ1hP5kY2AW8BQkQWBn5AT4CX86j8S3jOQLRaLBdwGmlYtfz6P1BWeaA==
X-Received: by 10.237.36.38 with SMTP id r35mr81963574qtc.3.1469097941816;
 Thu, 21 Jul 2016 03:45:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.36.77 with HTTP; Thu, 21 Jul 2016 03:45:22 -0700 (PDT)
In-Reply-To: <1469095670-3834-1-git-send-email-vascomalmeida@sapo.pt>
References: <1469095670-3834-1-git-send-email-vascomalmeida@sapo.pt>
From:	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:	Thu, 21 Jul 2016 12:45:22 +0200
Message-ID: <CACBZZX51K=D2gYbzKvJW3B5=bzxEGGFhOc6TkAfJkkpdYuEt0w@mail.gmail.com>
Subject: Re: [PATCH] i18n: notes: mark comment for translation
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 21, 2016 at 12:07 PM, Vasco Almeida <vascomalmeida@sapo.pt> wrote:
> Mark comment displayed when editing a note for translation.

I'm not sure, but wouldn't this make more sense:

> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  builtin/notes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 0572051..37933bd 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -91,7 +91,7 @@ static const char * const git_notes_get_ref_usage[] = {
>  };
>
>  static const char note_template[] =
> -       "\nWrite/edit the notes for the following object:\n";
> +       N_("\nWrite/edit the notes for the following object:\n");
+       N_("Write/edit the notes for the following object:");
>
>  struct note_data {
>         int given;
> @@ -179,7 +179,7 @@ static void prepare_note_data(const unsigned char *object, struct note_data *d,
>                         copy_obj_to_fd(fd, old_note);
>
>                 strbuf_addch(&buf, '\n');
+                 strbuf_addch(&buf, '\n');
> -               strbuf_add_commented_lines(&buf, note_template, strlen(note_template));
> +               strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
+                 strbuf_addch(&buf, '\n');
>                 strbuf_addch(&buf, '\n');
>                 write_or_die(fd, buf.buf, buf.len);

I.e. moving the starting and ending \n out of the message itself, the
surrounding whitespace doesn't seem like something the translators
need to modify, and if they were to trim it it looks like it would
break the output a bit.
