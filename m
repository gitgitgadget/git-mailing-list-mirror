From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Is there an API to the .gitignore capability?
Date: Tue, 4 Jun 2013 06:04:19 +0700
Message-ID: <CACsJy8DzcZ6PxBkGyYDobTZmY6sKF0ANhXnkz9xnULPG5USiNg@mail.gmail.com>
References: <CABrM6wnJYSGGsj=ZxHOFRMmDCSgsU0dFwxus=h1PtVazgpg3ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Peng Yu <pengyu.ut@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 01:04:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujdo6-00087m-O8
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 01:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758968Ab3FCXEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 19:04:51 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:53509 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758876Ab3FCXEu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 19:04:50 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so8417000obc.34
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 16:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E71A/zdeDNtqEEgVXowF4Z61tAT6ybwCdRxK6NQ6RLs=;
        b=H71t07N5wMCrLWB25+XDhRp3iiZMzPoG2a9k20TmxxMninV8gpm63sKNEfFbq8davq
         ywa8eMfHJivvSCTmEZb6WnAe2XWo1yEzKWuQ4vd04t/Ux/OwZ0X6YuNaj4OQfQsZS3PB
         ctr4uT+cb05NlFK5uSK+slV4PBjOReLrDFYU7ecwbuq7tAWv7oSWuvAtSz5bOY6Nvxor
         QhZUaQSIyzqd5WmjS0NntguJoTlZMeH7QWc9+cvN3a/v9LeyZ7KPSFhg/mkshm3QS/GI
         wdH8KGJKubLgY5kJuNEMfujTYgmGw7iaU5Z5KGVUSudZz9lv3pH4CQfWRMB1k2zDJ91+
         MRbA==
X-Received: by 10.60.162.98 with SMTP id xz2mr1775869oeb.7.1370300689981; Mon,
 03 Jun 2013 16:04:49 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Mon, 3 Jun 2013 16:04:19 -0700 (PDT)
In-Reply-To: <CABrM6wnJYSGGsj=ZxHOFRMmDCSgsU0dFwxus=h1PtVazgpg3ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226304>

On Sun, Jun 2, 2013 at 9:40 PM, Peng Yu <pengyu.ut@gmail.com> wrote:
> Hi,
>
> .gitignore is a flexible way to customize what dir/file to search or
> not to search. So it is of general use and is more flexible than what
> is offered by "find". I'm wondering if there is an API than I can use
> besides using it within git. Thanks.

Git provides no C API, if that's what you mean. You can link with
libgit.a, but there's no guarantee it won't break someday. At a higher
"API" level such as shell scripting, still "no", but I think you could
modify "git ls-files" to support running 'ls-files -i' without a git
repository (like git-grep --no-index). I think it'll work, mostly, but
not entirely sure.
--
Duy
