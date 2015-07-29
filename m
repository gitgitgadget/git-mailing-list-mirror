From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-filter: fix indentation
Date: Wed, 29 Jul 2015 10:49:17 -0700
Message-ID: <xmqq3806am76.fsf@gitster.dls.corp.google.com>
References: <1438185150-31730-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 19:49:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKVTo-0003he-Q5
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 19:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbbG2RtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 13:49:20 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35955 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbbG2RtU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 13:49:20 -0400
Received: by pdjr16 with SMTP id r16so9675207pdj.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zaopSuLfyUjbPmN9Ttea2i1yFz1NokHd4g67EJzefJM=;
        b=kOTrvVMPQfii2ibMb3sgvgLDjBJKPJZQ54rw5nevmvrqymi6JtH/ZWmjXeUCWwnY6T
         Qj5/I+Y5fi41PhuXa+hioXYnVpQuP7qUnYig4KhkRwhYEyAeDOX2p0jc7C3c16HeJcva
         CKLbVs0aswp9vf+zyolG1Bi3CgSxrxKWwl+inJAlLUdThuk86ZLbeQFBxQQV0T4ISkrw
         LXjABsnXshw0jyRiZYaP4VAgU9ZWSga6+y4L1RzZM/DP1z/M9h/E42an/hKrtx5pHKjq
         x9IIcJnUuT49TmIHqLE31HdKcM9euOd5psLJHormhyT9xIKDbL1XBF2N1mDVhjICKc3Q
         TuuA==
X-Received: by 10.70.90.67 with SMTP id bu3mr94225226pdb.2.1438192159369;
        Wed, 29 Jul 2015 10:49:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id db1sm41893021pdb.50.2015.07.29.10.49.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 10:49:18 -0700 (PDT)
In-Reply-To: <1438185150-31730-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 29 Jul 2015 17:52:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274925>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> This is meant to be applied on top of kn/for-each-ref.

Hmm, as 2.5 is already out and we can rewind 'next' in the coming
couple of days, I am tempted to squash this in instead of applying
it on top.

Thanks.

>  ref-filter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 43502a4..3fbbbeb 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -868,8 +868,8 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>  	struct ref_array_item *ref;
>  
>  	if (flag & REF_BAD_NAME) {
> -		  warning("ignoring ref with broken name %s", refname);
> -		  return 0;
> +		warning("ignoring ref with broken name %s", refname);
> +		return 0;
>  	}
>  
>  	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
