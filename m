From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH] wording fixes in the user manual and glossary
Date: Sun, 25 May 2014 19:56:41 +1200
Message-ID: <5381A239.2060809@gmail.com>
References: <1400989841-2845-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 25 09:56:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoTIX-00065x-Eb
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 09:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbaEYH4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 03:56:46 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62212 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaEYH4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 03:56:45 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so6138275pab.10
        for <git@vger.kernel.org>; Sun, 25 May 2014 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=TKnJuepqy8wXLbLBheEpyaRS/UMA4hyfS/rLvnJFsy8=;
        b=vM1Y5wmAI6mABOobW/WnY3mNyegzgJvYIO1UpQJt1H6gT5ZFN4omfYrbKn7Chm2bLE
         kcPDqKCi1hjJzjRTL3zfnPQsOUQoNXMNSQ5A55jLHi20Zf/j2hnWa2anvRAyAapi/nhZ
         VvVgGeNaYC2iGnBvyKNv8A4FhPgUCo8iTrKyvtEzw0YxNUgjeebMj4+T/PoO4QLhUSPP
         kHKV8S/VVn99WdyIlvWyesdlcDDDmFSaNISRZhnii8rkXazSbwh1LuxPbYcQOFwv47jm
         yRBfK4JtY6eVBP2wrgOh0u5FwU9Wii5qHtaPlR0Vl4FWeZl4N4Jj6L6x20L/7/5xBG4K
         /BMQ==
X-Received: by 10.67.14.231 with SMTP id fj7mr18705200pad.115.1401004604921;
        Sun, 25 May 2014 00:56:44 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id xg4sm12462363pbb.47.2014.05.25.00.56.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 25 May 2014 00:56:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1400989841-2845-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250082>

On 25/05/14 15:50, Jeremiah Mahler wrote:
> Some minor wording fixes in the user manual and glossary.
> 
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  Documentation/glossary-content.txt | 2 +-
>  Documentation/user-manual.txt      | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index be0858c..4e0b971 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -1,7 +1,7 @@
>  [[def_alternate_object_database]]alternate object database::
>  	Via the alternates mechanism, a <<def_repository,repository>>
>  	can inherit part of its <<def_object_database,object database>>
> -	from another object database, which is called "alternate".
> +	from another object database, which is called an "alternate".
>  
>  [[def_bare_repository]]bare repository::
>  	A bare repository is normally an appropriately
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index d33f884..efb3c97 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -416,7 +416,7 @@ REVISIONS" section of linkgit:gitrevisions[7].
>  Updating a repository with git fetch
>  ------------------------------------
>  
> -Eventually the developer cloned from will do additional work in her
> +Eventually the developer will do additional work in her cloned
>  repository, creating new commits and advancing the branches to point
>  at the new commits.

I agree that the original wording isn't clear but I'm not sure the new
wording is any clearer. The paragraph is trying to explain how to fetch
upstream changes when they happen. My initial thought was to say
"Eventually the developer will do additional work in the upstream
repository" but perhaps it is to early to start throwing around terms
like upstream. Perhaps just saying "her repository" would be clearest.

>  
> @@ -1811,8 +1811,8 @@ manner.
>  You can then import these into your mail client and send them by
>  hand.  However, if you have a lot to send at once, you may prefer to
>  use the linkgit:git-send-email[1] script to automate the process.
> -Consult the mailing list for your project first to determine how they
> -prefer such patches be handled.
> +Consult the mailing list for your project first to determine
> +their requirements for submitting patches.
>  
>  [[importing-patches]]
>  Importing patches to a project
> @@ -2255,7 +2255,7 @@ $ git checkout test && git merge speed-up-spinlocks
>  It is unlikely that you would have any conflicts here ... but you might if you
>  spent a while on this step and had also pulled new versions from upstream.
>  
> -Some time later when enough time has passed and testing done, you can pull the
> +Sometime later when enough time has passed and testing done, you can pull the
>  same branch into the `release` tree ready to go upstream.  This is where you
>  see the value of keeping each patch (or patch series) in its own branch.  It
>  means that the patches can be moved into the `release` tree in any order.
> 
