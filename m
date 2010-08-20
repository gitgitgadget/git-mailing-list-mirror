From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] shell: Rewrite documentation and improve error message
Date: Sat, 21 Aug 2010 01:21:41 +0530
Message-ID: <20100820195139.GD6211@kytes>
References: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Brockman <gdb@MIT.EDU>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 21:53:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmXeo-0000Se-8Z
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 21:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab0HTTxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 15:53:38 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:39560 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab0HTTxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 15:53:37 -0400
Received: by pxi10 with SMTP id 10so1340611pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/iLrJnV+GctqQF8lAKjk7TfycgnlVSOl1PiAWniiSqA=;
        b=LSjlabJdqxkGGjKdboUoUbxNSJyQzQdvSxq3Cns6WgBqO5i73gUu5PvAxgz50RbmY8
         Ddki0lHN/7FEhIkf1sbTQKLMQQjNWBftv+Jdene+VSWCOyPgDET8E5aBUgsP8iwf3kOh
         T7X3jEY7VQ1eymYbK0fUfyPwsxC8SrbHwIKXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kAVXjoAMy2qPO7KgQipbh88GWI8VjvdWHlgH4srQ7H6HPDj5eNj4igJ58iCt4zdJLd
         LHzV4p910VUIL7gknZgTFBfyJiHd5lU4lfXbO36qYCy/Eyc6PXyjuqQjyntvxyraMN2D
         hTb4TxNhKqB+SM7dp0FpITu+Hgy4aDCIjrl0k=
Received: by 10.142.254.21 with SMTP id b21mr1308443wfi.305.1282334016544;
        Fri, 20 Aug 2010 12:53:36 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 23sm3648855wfa.10.2010.08.20.12.53.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 12:53:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154077>

Hi,

Ramkumar Ramachandra writes:
> Update the documentation of 'git shell' to mention the interactive
> mode and COMMAND_DIR. Also provide a hint when interactive mode is not
> available in the shell.
> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Cc: Greg Brockman <gdb@MIT.EDU>
> Cc: Petr Baudis <pasky@suse.cz>
> ---
>  Documentation/git-receive-pack.txt |    2 +-

I'm sorry this stray change crept in. It's not relevant to this patch.

> diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
> index 2790eeb..2b07e44 100644
> --- a/Documentation/git-receive-pack.txt
> +++ b/Documentation/git-receive-pack.txt
> @@ -8,7 +8,7 @@ git-receive-pack - Receive what is pushed into the repository
>  
>  SYNOPSIS
>  --------
> -'git-receive-pack' <directory>
> +'git receive-pack' <directory>

Quick fixup:
-- 8< --
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 2b07e44..2790eeb 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -8,7 +8,7 @@ git-receive-pack - Receive what is pushed into the repository
 
 SYNOPSIS
 --------
-'git receive-pack' <directory>
+'git-receive-pack' <directory>
 
 DESCRIPTION
 -----------
