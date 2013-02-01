From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] Add a description for 'gitfile' to glossary
Date: Fri, 1 Feb 2013 11:46:37 -0800
Message-ID: <20130201194637.GD12368@google.com>
References: <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
 <274664435.1090127.1359742284591.JavaMail.ngmail@webmail18.arcor-online.net>
 <7v4nhvc1vv.fsf@alter.siamese.dyndns.org>
 <7vlib7al90.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Ackermann <th.acker@arcor.de>, git@vger.kernel.org,
	davvid@gmail.com, Lars Hjemli <hjemli@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 20:47:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1MZk-0004zG-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 20:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301Ab3BATqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 14:46:43 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:52768 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab3BATql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 14:46:41 -0500
Received: by mail-pb0-f50.google.com with SMTP id ro8so2286614pbb.37
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 11:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vkenK6OdfEr5OEDGma1zu8cKBILZ/a27Wyv7JvwEl2I=;
        b=IAje4LyLW3PFXUqLZcLsg5La2g2RpRFMXJzBo6doDkel4ZN3Gz9cT5qs4A6C/vNXTT
         Z/Zd5+hHh/7xHScBB2IThAIl2gpLmzJhrJxE4KTHd5DkATrT7Cj2a+2zBYMtbDVDROGw
         Y9+wpSlhBzo3xhA/GCh+Yalb8qedQSeCayUnSfFG5ho6VRGHOFdcNoU13SL5qPJZ3wyg
         cemWwHyUsjyhOpj40GZ+twBcZloopWQ8A+1cpA48pYtMlavBf1dnhB8/9Vm8sPrWI9Q9
         b8qvsBsUL5NXaBhy5eXpOi5QnMuBe8WcBNUJmlrgqHLnlla1EHm4hQkQq+JP5xs1RDyM
         oZHg==
X-Received: by 10.68.238.163 with SMTP id vl3mr34386057pbc.89.1359748001321;
        Fri, 01 Feb 2013 11:46:41 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id sb3sm9288142pbc.44.2013.02.01.11.46.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 11:46:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vlib7al90.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215262>

Junio C Hamano wrote:

> How about saying something like this here in the glossary:
>
> 	A plain file `.git` at the root of a working tree that
> 	points at the directory that is the real repository.
>
> And then as a separate patch, in gitrepository-layout.txt (eek---see
> the other thread), we can do something like this:
>
>  Documentation/gitrepository-layout.txt | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Looks correct and very readable.  Thanks.

Jonathan
(patch left unsnipped for reference)

> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
> index 9f62886..473c6a0 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -12,12 +12,24 @@ $GIT_DIR/*
>  DESCRIPTION
>  -----------
>  
> -You may find these things in your git repository (`.git`
> -directory for a repository associated with your working tree, or
> -`<project>.git` directory for a public 'bare' repository. It is
> -also possible to have a working tree where `.git` is a plain
> -ASCII file containing `gitdir: <path>`, i.e. the path to the
> -real git repository).
> +A Git repository comes in two different flavours:
> +
> + * a `.git` directory at the root of the working tree;
> +
> + * a `<project>.git` directory that is a 'bare' repository
> +   (i.e. without its own working tree), that is typically used for
> +   exchanging histories with others by pushing into it and fetching
> +   from it.
> +
> +*Note*: Also you can have a plain text file `.git` at the root of
> +your working tree, containing `gitdir: <path>` to point at the real
> +directory that has the repository.  This mechanism is often used for
> +a working tree of a submodule checkout, to allow you in the
> +containing superproject to `git checkout` a branch that does not
> +have the submodule.  The `checkout` has to remove the entire
> +submodule working tree, without losing the submodule repository.
> +
> +These things may exist in a Git repository.
>  
>  objects::
>  	Object store associated with this repository.  Usually
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
