From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [PATCH v2] Documentation: Fix indentation problem in
 git-commit(1)
Date: Fri, 19 Feb 2010 09:54:11 -0800
Message-ID: <20100219175411.GA388@vfb-9.home>
References: <201002151008.31980.trast@student.ethz.ch>
 <1266237186-8065-1-git-send-email-jacob.helwig@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 19:00:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiX9a-0007PO-1E
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 19:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684Ab0BSSAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 13:00:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:2652 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab0BSSAc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 13:00:32 -0500
Received: by fg-out-1718.google.com with SMTP id l26so404988fgb.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 10:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tkslTHM9h7RwPlG1RrUJGFVKCwh8UP6Eau3srFaHQ1I=;
        b=immCwooW7jSV4KhjSsIuCAub088g7ZZv6cGiFAVAi8gXLT2EOI+qXyH0+/Z8+SwvNM
         PX/zoPlPXQL6Md5/5leYlEu485H9e6T/g60FNR8Xj6fJ2+O97cZTzx+6BPJhJF/XMgM5
         ugqqlQMwFH6PmrVGD3ucW5ftqIhxJpgDZ6TkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ap1huCiPVasI4wdYyMyX/KJL8VQILfm73xg+YqwEibA6bmn/08udCF9Mmbpmj7KsFB
         i6gxXROH91x73B0Q0/52OdfRlUeRBgzQzH/gk8XuO8Jtf5YR2xzrS9nJeCuEqlXiO6U9
         LrHWP+zlF9PrMVpQukIP03RUF/H8iPFZYll6k=
Received: by 10.87.66.11 with SMTP id t11mr16836268fgk.18.1266602059100;
        Fri, 19 Feb 2010 09:54:19 -0800 (PST)
Received: from vfb-9.home ([96.225.220.117])
        by mx.google.com with ESMTPS id 14sm187123fxm.13.2010.02.19.09.54.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Feb 2010 09:54:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266237186-8065-1-git-send-email-jacob.helwig@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140475>

On 04:33 Mon 15 Feb     , Jacob Helwig wrote:
> Ever since the "See linkgit:git-config[1]..." paragraph was added to the
> description for --untracked-files (d6293d1), the paragraphs for the
> following options were indented at the same level as the "See
> linkgit:git-config[1]" paragraph.  This problem showed up in the
> manpages, but not in the HTML documentation.
> 
> While this does fix the alignment of the options following
> --untracked-files in the manpage, the "See linkgit..." portion of the
> description does not retain its previous indentation level in the
> manpages, or HTML documentation.
> 
> Signed-off-by: Jacob Helwig <jacob.helwig@gmail.com>
> Acked-by: Thomas Rast <trast@student.ethz.ch>
> ---
> 
> When adding the caveat to the commit message, the introductory comment
> paragraph I had before seemed to fit better; I decided to go with a
> version of it, instead.
> 
>  Documentation/git-commit.txt |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index e99bb14..64fb458 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -197,13 +197,13 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
>  	Show untracked files (Default: 'all').
>  +
>  The mode parameter is optional, and is used to specify
> -the handling of untracked files. The possible options are:
> +the handling of untracked files.
> ++
> +The possible options are:
>  +
> ---
>  	- 'no'     - Show no untracked files
>  	- 'normal' - Shows untracked files and directories
>  	- 'all'    - Also shows individual files in untracked directories.
> ---
>  +
>  See linkgit:git-config[1] for configuration variable
>  used to change the default for when the option is not
> -- 
> 1.7.0
> 

I haven't seen any further discussion on this after I sent out a v2 with
Thomas's suggested change to the commit message, and I didn't want to
let the problem that this is trying to address fall through the cracks.

Does anyone have any comments on the v2 of this change?

-- 
Jacob Helwig
