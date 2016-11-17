Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890331FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 18:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbcKQS3m (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 13:29:42 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35075 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754446AbcKQS3l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 13:29:41 -0500
Received: by mail-qk0-f177.google.com with SMTP id n204so233300664qke.2
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 10:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5OTj8tE1Qp0AZJQ0+hZrQRnQS+yYHrj/U69NWXIW9oU=;
        b=dGIE60WnQSfWRu1lUU8Nb5q0SqrBVtPIPqSIXrSqkQTjpuoJdqJwipO8EPIfWPBRJt
         CSrhzJeq9k8CQU2JVRW82khwQLgt7hvqn3BPQ7nNeEeU9yMHKWTkHUBNMhcl+Lwx4Dlx
         y6reI54ugDXhnDApbylDopxA6czplLeRmHJZeRPQf0hbI7T9Pg/IjOYOSUecWHBU4vkn
         2VLkJpOt9CSuNfaZsYX2eNS0uFKIXe1Z+6B41pBCo/Spv1cFt0C/nWMN+9Oon9LyOK6A
         icuP62o0/9p07H48TeUJOwkL2NYtpkGxb+ilmyOo6QsXFheHHvBcVHjDuDj9jRacpJkP
         VmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5OTj8tE1Qp0AZJQ0+hZrQRnQS+yYHrj/U69NWXIW9oU=;
        b=R0AXu/MIaSUN/8Ew0PM3INpgtk9nFxg+OK4Vvry5b0qgTnIXkSPARiUJ2rgZb76XIn
         sOyMiAjNw6o/4dBZhuJyOvM1BD9IG/2TraK6bo7tlDiL2bzG5dNGm3IW/s83NbpHMTZo
         G1f4uQqdemQZann9P7z3CYMFO04N81Hrs81OAAic15dQlEK/lyGPaBH4Wc2ghVN0cQO8
         Bxfe+wZ6idCYmTJ+Z8yQWNaAaxwiHXEka67WKEroutwVQ9Q81WLMWOl75l8sANq4lF1F
         fYmi3XXCNBnybq0mFC6a3y44boIAjM6ROKh9xO22RbV/JfbHShnlfoheBF/kByLLNQLU
         aCVQ==
X-Gm-Message-State: AKaTC03DChj+oqHgVMQ4QBD/+8aQkfG7A5Wbc+C9wdtEQv8y89p0pMJHzTWi5oH9t/h5c6sg0h2NRlnRrrp1xztV
X-Received: by 10.55.186.3 with SMTP id k3mr5576557qkf.47.1479407380119; Thu,
 17 Nov 2016 10:29:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 10:29:39 -0800 (PST)
In-Reply-To: <xmqqshqrp7i8.fsf@gitster.mtv.corp.google.com>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-2-sbeller@google.com>
 <xmqqshqrp7i8.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 10:29:39 -0800
Message-ID: <CAGZ79kbVq0SrD8u+GrGAVYpvNeirDqnAU9jJCbSLoEvqSgB4yg@mail.gmail.com>
Subject: Re: [PATCH 01/16] submodule.h: add extern keyword to functions, break
 line before 80
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 11:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> submodule.h: add extern keyword to functions, break line before 80
>
> The former is probably a good change for consistency.  As the latter
> change breaks a workflow around quickly checking the output from
> "git grep funcname \*.h", I am not sure if it is a good idea.
>
> Especially things like this look like a usability regression:
>
> -void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
> +extern void handle_ignore_submodules_arg(struct diff_options *diffopt,
> +                                        const char *);
>
> Perhaps the name "diffopt" can be dropped from there if we want it
> to be shorter.

Does the Git community have an opinion on dropping the name?
Usually the meaning can be inferred from the type such as in this example.
"diffopt" doesn't add information to my understanding when looking at
the header file.

One (cherry-picked) counter example is:

    /**
    * Like `strbuf_getwholeline`, but operates on a file descriptor.
    * It reads one character at a time, so it is very slow.  Do not
    * use it unless you need the correct position in the file
    * descriptor.
    */
    extern int strbuf_getwholeline_fd(struct strbuf *, int, int);

where I'd need a bit of time to figure out which of the 2 ints is the
fd and which is the line termination character.

So I'd rather have a broken line than dropping names,
as when grepping for names I'd look them up most of the time
anyway (to e.g. read additional documentation or just reading the
source)


> Names in prototypes are valuable for parameters of
> more generic types like "char *", especially when there are more
> than one parameters of the same type, but in this case the typename
> is specific enough for readers to tell what it is.

Ok, that seems a reasonable to me.

I'll squash the changes below, with an updated commit message:

submodule.h: add extern keyword to functions

As the upcoming series will add a lot of functions to the submodule
header, let's first make the header consistent to the rest of the project
by adding the extern keyword to functions.

As per the CodingGuidelines we try to stay below 80 characters per line,
so adapt all those functions to stay below 80 characters that are already
using more than one line.  Those function using just one line are better
kept in one line than breaking them up into multiple lines just for the
goal of staying below the character limit as it makes grepping
for functions easier if they are one liners.

(diff on top of the patch under discussion)
diff --git a/submodule.h b/submodule.h
index afc58d0..2082847 100644
--- a/submodule.h
+++ b/submodule.h
@@ -33,17 +33,14 @@ extern int is_staging_gitmodules_ok(void);
 extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 extern int remove_path_from_gitmodules(const char *path);
 extern void stage_updated_gitmodules(void);
-extern void set_diffopt_flags_from_submodule_config(
-               struct diff_options *diffopt,
+extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
                const char *path);
 extern int submodule_config(const char *var, const char *value, void *cb);
 extern void gitmodules_config(void);
 extern int parse_submodule_update_strategy(const char *value,
                struct submodule_update_strategy *dst);
-extern const char *submodule_strategy_to_string(
-               const struct submodule_update_strategy *s);
-extern void handle_ignore_submodules_arg(struct diff_options *diffopt,
-                                        const char *);
+extern const char *submodule_strategy_to_string(const struct
submodule_update_strategy *s);
+extern void handle_ignore_submodules_arg(struct diff_options *, const char *);
 extern void show_submodule_summary(FILE *f, const char *path,
                const char *line_prefix,
                struct object_id *one, struct object_id *two,
@@ -72,8 +69,7 @@ extern int find_unpushed_submodules(unsigned char
new_sha1[20],
                                    struct string_list *needs_pushing);
 extern int push_unpushed_submodules(unsigned char new_sha1[20],
                                    const char *remotes_name);
-extern void connect_work_tree_and_git_dir(const char *work_tree,
-                                         const char *git_dir);
+extern void connect_work_tree_and_git_dir(const char *work_tree,
const char *git_dir);
 extern int parallel_submodules(void);

 /*
