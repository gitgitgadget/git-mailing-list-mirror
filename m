From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 16/20] revision: trivial style fixes
Date: Sat, 12 Oct 2013 11:08:16 +0200
Message-ID: <52591180.3010103@googlemail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com> <1381561636-20717-10-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 11:08:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUvBD-0004dV-9g
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 11:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab3JLJIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 05:08:01 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:58307 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab3JLJH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 05:07:59 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so2368057eek.30
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=6IQvYgt2I+Jub6AfeJ/YiQsl2fpxqXBUYkc5NbbQ3Fk=;
        b=RdXuhaQhimxxRav3pJsPTfRsKrNNHdbAFQjSf8fpNcLEAv9cYa/YL6MkMXTCs658i3
         7R2AP3PyA5HbwSbDqd9Owm/wak34PtU5l5Q6+1mrq74a0yfB67RYlcwrJmRD4EYI1jhL
         +sqlMbIj6ZbOCx/m0Q+y23h0pR49oPabgQ8PlEaHoQI/R0mRnbeQ8xGprjWMxSD8lPhj
         i5DGQot8RVIGTi6sy+04kxMnt0Txd3XTEC3B1fHsh/B+Nl3SbaF70xOL1fvtr05CxYFJ
         peWiqLjzUMg2gB+K9Rd4oA2I+ea403YIXOXzG+Dy20IoeEESpiH9nf1aBPyOTUbcRk50
         C//w==
X-Received: by 10.14.101.6 with SMTP id a6mr43959eeg.81.1381568878120;
        Sat, 12 Oct 2013 02:07:58 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id b45sm125137333eef.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 02:07:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1381561636-20717-10-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236043>

On 10/12/2013 09:07 AM, Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  revision.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/revision.c b/revision.c
> index 0173e01..4049867 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1503,7 +1503,7 @@ struct cmdline_pathspec {
>  static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
>  {
>  	while (*av) {
> -		ALLOC_GROW(prune->path, prune->nr+1, prune->alloc);
> +		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
>  		prune->path[prune->nr++] = *(av++);
>  	}
>  }
> @@ -1515,7 +1515,7 @@ static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
>  		int len = sb->len;
>  		if (len && sb->buf[len - 1] == '\n')
>  			sb->buf[--len] = '\0';
> -		ALLOC_GROW(prune->path, prune->nr+1, prune->alloc);
> +		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
>  		prune->path[prune->nr++] = xstrdup(sb->buf);
>  	}
>  }
> @@ -2118,7 +2118,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  		 *	call init_pathspec() to set revs->prune_data here.
>  		 * }
>  		 */
> -		ALLOC_GROW(prune_data.path, prune_data.nr+1, prune_data.alloc);
> +		ALLOC_GROW(prune_data.path, prune_data.nr + 1, prune_data.alloc);
>  		prune_data.path[prune_data.nr++] = NULL;
>  		parse_pathspec(&revs->prune_data, 0, 0,
>  			       revs->prefix, prune_data.path);
> @@ -2971,7 +2971,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
>  	if (revs->max_count) {
>  		c = get_revision_1(revs);
>  		if (c) {
> -			while (0 < revs->skip_count) {
> +			while (revs->skip_count > 0) {
>  				revs->skip_count--;
>  				c = get_revision_1(revs);
>  				if (!c)
> @@ -2986,9 +2986,8 @@ static struct commit *get_revision_internal(struct rev_info *revs)
>  	if (c)
>  		c->object.flags |= SHOWN;
>  
> -	if (!revs->boundary) {
> +	if (!revs->boundary)
>  		return c;
> -	}
>  
>  	if (!c) {
>  		/*
> @@ -3034,9 +3033,8 @@ struct commit *get_revision(struct rev_info *revs)
>  
>  	if (revs->reverse) {
>  		reversed = NULL;
> -		while ((c = get_revision_internal(revs))) {
> +		while ((c = get_revision_internal(revs)))
>  			commit_list_insert(c, &reversed);
> -		}

While talking about trivia, what is the projects stance on
such constructs here?
	while (foo)
		bar();
	foobar();

I've seen an empty line between the bar(); and the foobar(); often, which suits readability.
What's the stance on such an empty line here?

>  		revs->commits = reversed;
>  		revs->reverse = 0;
>  		revs->reverse_output_stage = 1;
> 

Thanks,
Stefan
