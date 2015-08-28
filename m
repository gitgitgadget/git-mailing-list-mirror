From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-ref: place angle brackets around variable in usage string
Date: Fri, 28 Aug 2015 11:07:05 -0700
Message-ID: <xmqq37z32som.fsf@gitster.mtv.corp.google.com>
References: <1440649612-3667-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:11:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVO7A-0007Mj-M4
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbbH1SHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:07:12 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33428 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbH1SHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:07:08 -0400
Received: by padfo6 with SMTP id fo6so31503460pad.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Vdn3gy81x+UUDJ0OrmUAViDjsYndgjjQ5lKRLn5gYwY=;
        b=UPetvWegx9TOqHJUUUQtryMVS+HC39z+sgTBwgddCR2K0zoMv6qiGALDubU4JHjoDY
         wuuptghrwENZG9t/NfDDh3/2pA1H+j4pGBCSAzSWFCY9NfXVlWCIyszf/5LFkHlwoklf
         mBGA/p6URwdNYS1CC9z7UOkBjcf/RXkNkympBg9R1WAqcNCOJQxsv9b9cknUDOLPYy8y
         rKIQNxKA8ULvXljVx/6HKRuMhc8v89l8bCXbSLwUgtJr+7Pkndk9f4Y+fkPKpPbedllT
         EWOOdh8q6CA076ZiI5M37Cxvi8+UftfSZnNPAOWYZquMi2Btetea1Cw69cPv+TYNlmAb
         fhKQ==
X-Received: by 10.68.143.70 with SMTP id sc6mr17102955pbb.87.1440785227518;
        Fri, 28 Aug 2015 11:07:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id if9sm6406404pbc.89.2015.08.28.11.07.06
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 11:07:06 -0700 (PDT)
In-Reply-To: <1440649612-3667-1-git-send-email-alexhenrie24@gmail.com> (Alex
	Henrie's message of "Wed, 26 Aug 2015 22:26:52 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276742>

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/show-ref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index dfbc314..d9c1633 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -8,7 +8,7 @@
>  
>  static const char * const show_ref_usage[] = {
>  	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [<pattern>...]"),
> -	N_("git show-ref --exclude-existing[=pattern] < ref-list"),
> +	N_("git show-ref --exclude-existing[=pattern] < <ref-list>"),
>  	NULL
>  };

Isn't "--exclude-existing[=<pattern>]" also a placeholder?
