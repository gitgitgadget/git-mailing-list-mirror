Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC74426
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqkEpKjO"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C4CC0
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 14:19:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc1a124b29so20235ad.1
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698355175; x=1698959975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BTlquga4bS/ikIQAJa2rht6n6/OKH3O1/qXZUE8svAQ=;
        b=hqkEpKjOawIE5e183Szn5Gkkv56qN8XfiUYPg3gQv8jRnpavblK4MLvVONovPsrISH
         VaMUs4duqI8z2PoJpxd4dpM2yabndnUk2GmQbrLNEoCljGZkcDGRcy/3Zy2fGcV/RH4L
         bW3M6Gv2FHqmTCAHgcMFo6j78oPOT17QTf2b2EzixvnmcBSXjR5O2PryK6KO60aI2p2X
         KDoR3Tfg+erWErCFL/2MYQ0gIHPJzCwriA8E+tb7AczXryhUVtMkAr1zTs7UXdS/nU6N
         XldbKeSCq7lpgh+R3x0OAtWU2CVPXmZsCed0/T+GRmegr69b61coI2gSbiRcVe6gyE/E
         I73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698355175; x=1698959975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTlquga4bS/ikIQAJa2rht6n6/OKH3O1/qXZUE8svAQ=;
        b=M/iDdN4A3Qhpi4so12A3fj7iEzK9Lyom8rHA8DyrD1CEdndYWt1qj7CjddZYrfQgD0
         GXjWqtFKznNCelS1ehvUrcGi2I0UJu33qYjVFIm8/1HjK2GiEEN8ZUau8Ot71wNEX9WI
         xgUIfoG4m1zab9SG+FnV5NJ6INn/NGtpoLQitMfbU1fgLWpnVjRVq4CGRpI84rcyo2QB
         rSxfz+vUfrltAvjy9M+rlZhzKQZDvsmfbs4psnV9FP0VazFM2/hTif+gzTdnPKzxSvdK
         hDpts4SVDqKpmsgCecekSsVvEmG0nbVF5fwMQIKk/I99dHASBU39ipVGnwdVo2loluA9
         OiLg==
X-Gm-Message-State: AOJu0YwzccW23Zbaww+lGfsZOC21lD2snxQffaEzfr55Q1VNGa13KchB
	8gqbmz9w6f4nJNDmfQJVrDxRC+S8FX8+aP697WlV8Q==
X-Google-Smtp-Source: AGHT+IGXDvGuf+MAXz519ac2dWBljBSeNuAoumkblCTfewJSG9fqFrVO86c9lJ6ysVH16zoIxQGbCw==
X-Received: by 2002:a17:902:d491:b0:1c9:bfdb:aae4 with SMTP id c17-20020a170902d49100b001c9bfdbaae4mr81094plg.18.1698355174739;
        Thu, 26 Oct 2023 14:19:34 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:3e48:417f:9bff:e591])
        by smtp.gmail.com with ESMTPSA id g4-20020a056a001a0400b006bfb9575c53sm34937pfv.180.2023.10.26.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 14:19:34 -0700 (PDT)
Date: Thu, 26 Oct 2023 14:19:28 -0700
From: Emily Shaffer <nasamuffin@google.com>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] bugreport: include +i in outfile suffix as needed
Message-ID: <ZTrX4PMYtbVT-tUu@google.com>
References: <20231015034238.100675-2-jacob@initialcommit.io>
 <20231016214045.146862-1-jacob@initialcommit.io>
 <20231016214045.146862-2-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016214045.146862-2-jacob@initialcommit.io>

Thanks Jack for drawing my attention to the summoning, and sorry for
delay.

On Mon, Oct 16, 2023 at 02:40:45PM -0700, Jacob Stopak wrote:
> 
> When the -s flag is absent, git bugreport includes the current hour and
> minute values in the default bugreport filename (and diagnostics zip
> filename if --diagnose is supplied).
> 
> If a user runs the bugreport command more than once within a minute, a
> filename conflict with an existing file occurs and the program errors,
> since the new output filename was already used for the previous file. If
> the user waits anywhere from 1 to 60 seconds (depending on when during
> the minute the first command was run) the command works again with no
> error since the default filename is now unique, and multiple bug reports
> are able to be created with default settings.
> 
> This is a minor thing but can cause confusion for first time users of
> the bugreport command, who are likely to run it multiple times in quick
> succession to learn how it works, (like I did). Or users who quickly
> fill in a few details before closing and creating a new one.

Sure, agreed - I guess I got in the habit of testing by running `rm
git-bugreport*.txt && git bugreport --foo` and never thought about this
being annoying for an actual reporter :)

> 
> Add a '+i' into the bugreport filename suffix where 'i' is an integer
> starting at 1 and growing as needed until a unique filename is obtained.
> 
> This leads to default output filenames like:
> 
> git-bugreport-%Y-%m-%d-%H%M+1.txt
> git-bugreport-%Y-%m-%d-%H%M+2.txt
> ...
> git-bugreport-%Y-%m-%d-%H%M+i.txt
> 
> This means the user will end up with multiple bugreport files being
> created if they run the command multiple times quickly, but that feels
> more intuitive and consistent than an error arbitrarily occuring within
> a minute, especially given that the time window in which the error
> currently occurs is variable as described above.

Sure, and with the monotonic increases it's quite easy to locate the
bugreport that's the final one the user generated. This scheme seems
fine to me.

> 
> If --diagnose is supplied, match the incremented suffix of the
> diagnostics zip file to the bugreport.

Nice.

> 
> Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
> ---
>  builtin/bugreport.c | 83 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 57 insertions(+), 26 deletions(-)
> 
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index d2ae5c305d..ed65735873 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -11,6 +11,7 @@
>  #include "diagnose.h"
>  #include "object-file.h"
>  #include "setup.h"
> +#include "dir.h"
>  
>  static void get_system_info(struct strbuf *sys_info)
>  {
> @@ -97,20 +98,41 @@ static void get_header(struct strbuf *buf, const char *title)
>  	strbuf_addf(buf, "\n\n[%s]\n", title);
>  }
>  
> +static void build_path(struct strbuf *buf, const char *dir_path,
> +		       const char *prefix, const char *suffix,
> +		       time_t t, int *i, const char *ext)
> +{
> +	struct tm tm;
> +
> +	strbuf_reset(buf);
> +	strbuf_addstr(buf, dir_path);
> +	strbuf_complete(buf, '/');
> +
> +	strbuf_addstr(buf, prefix);
> +	strbuf_addftime(buf, suffix, localtime_r(&t, &tm), 0, 0);
> +
> +	if (*i > 0)
> +		strbuf_addf(buf, "+%d", *i);
> +
> +	strbuf_addstr(buf, ext);
> +
> +	(*i)++;
> +}

I commented on the weirdness of having to decrement i for --diagnose
below, but I think I generally just wish that instead of build_path()
this function did create_file_with_optional_suffix() and returned the
final modified option_suffix(). Better still would be if this function
created (or at least tested) all the necessary output paths so you don't
end up succeeding in creating a bugreport.txt but failing in creating
the diagnostics.zip in some edge case, something like....

build_suffix(..., &option_suffix) {
  ... build timestamp ...
  while (...)
    for (final_path in eventual_paths) {
    	err = select(final_path);
	if (err)
	  final_path = strcat(most_of_path, i)
	else
	  break
(Yeah, that's very handwavey, but I hope you see what I'm getting at.)

Really, though, I mostly don't think I like leaving the control variable i raw
to the calling scope and making it be manipulated later. Fancy
pre-guessing-path-availability aside, I think you could achieve a more
pleasant solution even by letting build_path() become
create_file_with_optional_suffix() (that reports the optional suffix
eventually settled on).

> +
>  int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf buffer = STRBUF_INIT;
>  	struct strbuf report_path = STRBUF_INIT;
>  	int report = -1;
>  	time_t now = time(NULL);
> -	struct tm tm;
>  	enum diagnose_mode diagnose = DIAGNOSE_NONE;
>  	char *option_output = NULL;
> -	char *option_suffix = "%Y-%m-%d-%H%M";
> +	char *option_suffix = "";
> +	int option_suffix_is_from_user = 0;
>  	const char *user_relative_path = NULL;
>  	char *prefixed_filename;
> -	size_t output_path_len;
>  	int ret;
> +	int i = 0;
>  
>  	const struct option bugreport_options[] = {
>  		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("mode"),
> @@ -126,16 +148,16 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, bugreport_options,
>  			     bugreport_usage, 0);
>  
> +	if (!strlen(option_suffix))
> +		option_suffix = "%Y-%m-%d-%H%M";
> +	else
> +		option_suffix_is_from_user = 1;

Looking at where this is used, it looks like you're saying "if the user
specified the suffix manually and has this problem, then that sucks for
them, they put their own foot in it". But I don't know if I necessarily
follow that logic - I'd just as soon drop the exception, append an int
to the user-provided suffix, and document that we'll do that in the
manpage.

(This isn't something I feel strongly about, except that I think it
makes the code harder to follow for not very notable user benefit. I
also didn't look through the reviews up until now, so if this was
already hashed back and forth, just go ahead and ignore me.)

> +
>  	/* Prepare the path to put the result */
>  	prefixed_filename = prefix_filename(prefix,
>  					    option_output ? option_output : "");
> -	strbuf_addstr(&report_path, prefixed_filename);
> -	strbuf_complete(&report_path, '/');
> -	output_path_len = report_path.len;
> -
> -	strbuf_addstr(&report_path, "git-bugreport-");
> -	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
> -	strbuf_addstr(&report_path, ".txt");
> +	build_path(&report_path, prefixed_filename, "git-bugreport-",
> +		   option_suffix, now, &i, ".txt");
>  
>  	switch (safe_create_leading_directories(report_path.buf)) {
>  	case SCLD_OK:
> @@ -146,20 +168,6 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  		    report_path.buf);
>  	}
>  
> -	/* Prepare diagnostics, if requested */
> -	if (diagnose != DIAGNOSE_NONE) {
> -		struct strbuf zip_path = STRBUF_INIT;
> -		strbuf_add(&zip_path, report_path.buf, output_path_len);
> -		strbuf_addstr(&zip_path, "git-diagnostics-");
> -		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
> -		strbuf_addstr(&zip_path, ".zip");
> -
> -		if (create_diagnostics_archive(&zip_path, diagnose))
> -			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
> -
> -		strbuf_release(&zip_path);
> -	}
> -
>  	/* Prepare the report contents */
>  	get_bug_template(&buffer);
>  
> @@ -169,14 +177,37 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  	get_header(&buffer, _("Enabled Hooks"));
>  	get_populated_hooks(&buffer, !startup_info->have_repository);
>  
> -	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
> -	report = xopen(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
> +	again:
> +		/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
> +		report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
> +		if (report < 0 && errno == EEXIST && !option_suffix_is_from_user) {
> +			build_path(&report_path, prefixed_filename,
> +				   "git-bugreport-", option_suffix, now, &i,
> +				   ".txt");
> +			goto again;
> +		} else if (report < 0) {
Nit, but the double-checking of (report < 0) bothers me a little. Is it
nicer if it's nested?

	if (report < 0) {
		if (errno == EEXIST) {
			build_path(...);
			goto again;
		}

		die_errno(_(...));
	}

I like it a little more, but that's up to taste, I suppose.
> +			die_errno(_("unable to open '%s'"), report_path.buf);
> +		}
>  
>  	if (write_in_full(report, buffer.buf, buffer.len) < 0)
>  		die_errno(_("unable to write to %s"), report_path.buf);
>  
>  	close(report);
>  
> +	/* Prepare diagnostics, if requested */
> +	if (diagnose != DIAGNOSE_NONE) {
> +		struct strbuf zip_path = STRBUF_INIT;
> +		i--; /* Undo last increment to match zipfile suffix to bugreport */
I understand why you're doing this, but I'd rather see it decremented
(or more care taken in the increment logic elsewhere) closer to where it
is being increment-and-checked. If someone wants to add another
associated file besides the report and the diagnostics, then the logic
for the decrement becomes complicated (what happens if I run `git
bugreport --diagnostics --desktop_screencap`? what if I run only `git
bugreport --desktop_screencap`?). Even without that potential pain,
reading this comment here means I have to say "oh wait, what did I read
above? hold on, let me page it back in".

> +		build_path(&zip_path, prefixed_filename, "git-diagnostics-",
> +			   option_suffix, now, &i, ".zip");
> +
> +		if (create_diagnostics_archive(&zip_path, diagnose))
> +			die_errno(_("unable to create diagnostics archive %s"),
> +				  zip_path.buf);
> +
> +		strbuf_release(&zip_path);
> +	}
> +
>  	/*
>  	 * We want to print the path relative to the user, but we still need the
>  	 * path relative to us to give to the editor.
> -- 
> 2.42.0.297.g36452639b8

Last thing: it probably makes sense to mention this new behavior in the
manpage, especially if you'll apply that behavior to user-provided
suffixes too.

Thanks for your effort on the patch so far and again, sorry for the late
reply.
 - Emily
