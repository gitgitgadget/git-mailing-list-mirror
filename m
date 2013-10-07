From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Feature Request: gitignore recursion
Date: Mon, 7 Oct 2013 17:26:17 +0700
Message-ID: <CACsJy8CHcyDrzieX1Ps3LU2UxCP+QJdv9+5BXZj9Mw2bMs5v3w@mail.gmail.com>
References: <loom.20131007T000517-673@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: AJ <alljeep@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 07 12:26:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VT81d-0001iL-75
	for gcvg-git-2@plane.gmane.org; Mon, 07 Oct 2013 12:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932Ab3JGK0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Oct 2013 06:26:48 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36743 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab3JGK0r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Oct 2013 06:26:47 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so7095886pab.18
        for <git@vger.kernel.org>; Mon, 07 Oct 2013 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7uA65mu9nk06Y1HelBVvom28ddvmJyhSF5agzuTmHZQ=;
        b=WB24NoHBjSqHHmVO1Xsj1zPA1UL/iuWirCVGGXN9GvSAJ4yQUqfrk2omn4mUXPsMY0
         N21ghMjCXL+R/BoYYjw5tF0pPqdhQ3ojNqGEdTsKdIcaaNSgndC8tJmFDJk5YIj29gEZ
         G6YN5g+7MbccI2WSt+wFTYvIBkR6EnNHzIuIFitiiVASBQHkQuVrEqKeKpj8eORAdIXY
         LsJCN7h8vKARdOQPHxcQJ2M3lmKfLaLZzGpIVFRbZqk/SgVgu2N8CUyo2E9OI4OBcdAm
         YPfbmO18Y5Xi9oSCleUH3SbUiI4oA2kCDFwYKSRjOPvgUWWC/PqXuRs16wbXBw0dlM+M
         4LXg==
X-Received: by 10.68.178.197 with SMTP id da5mr30162428pbc.28.1381141607087;
 Mon, 07 Oct 2013 03:26:47 -0700 (PDT)
Received: by 10.70.66.33 with HTTP; Mon, 7 Oct 2013 03:26:17 -0700 (PDT)
In-Reply-To: <loom.20131007T000517-673@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235755>

On Mon, Oct 7, 2013 at 5:23 AM, AJ <alljeep@gmail.com> wrote:
> I'm hoping to get the following feature implemented into git.
>
> Add the ability to recursively include using:
> !/my_dir/**/*

You can do that since v1.8.2. Actually the pattern should be

!/my_dir/**

Checkout gitignore man page for more information.

> Currently, in order to include a directory with multiple sub-directories
> within a excluded directory, you must do the following:
> !/my_dir/
> !/my_dir/*
> !/my_dir/*/*
> !/my_dir/*/*/*
> !/my_dir/*/*/*/*
> !/my_dir/*/*/*/*/*
>
> Here is a use case:
> When developing a WordPress site you typically only place the wp-content/themes
> directory under version control. Once you start adding custom plugins, README
> files, and a task manager like Grunt JS, you then have to starting getting
> creative with your .gitignore if your .git directory is in the web root
> directory.
>
> Here is an example:
> https://gist.github.com/AJ-Acevedo/6859779
>
> Thanks for taking the time to consider this feature
> AJ
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
