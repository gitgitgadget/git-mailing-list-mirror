From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/6] contrib/credential/wincred/git-credential-wincred.c:
 reduce scope of variables
Date: Wed, 16 Apr 2014 11:54:06 +0200
Message-ID: <CABPQNSZDZEhb4o5zvUtYQiMzEdrrs0QDCF6OH0wvtpLjNsNQSQ@mail.gmail.com>
References: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com> <1397640811-17719-5-git-send-email-gitter.spiros@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 11:54:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaMYP-0005Y6-Pw
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 11:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949AbaDPJys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 05:54:48 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:63511 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbaDPJyr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 05:54:47 -0400
Received: by mail-ig0-f172.google.com with SMTP id hn18so825638igb.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 02:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1WHZe8Gs/nLlxeB5+P0jOzlmQ5gGFNPcIxQngksqkzA=;
        b=z56BMQWuHABXpqvkIjiWJZ5Kb8FgzMzqW7qts3MhRN8vKWLh6KS79ctbc922Ow5A5T
         rY+pZ4Tch+/yA6Xrw6cy4/KCftu2qqQmF4Aec5tTYIOYyy06Af9OXRAO2gW3i91y0bJ2
         WxwuOxtJvAwiKm9lYGfs459Wggkty4rwBiwIpZ+giuMqLahmS24Q93VhOiy4v0CtOTE5
         +ZQ4rZoQEkT6F52KBgiKLm/Hxx2UyiVGowDQCdZ5W0Ef2iC6BcYW5jQLkWQryIfBr37P
         re1Vq6BPSMkDVU5H9HvRB24PCjAndi3AHyKn6ZStQUIXKF0xUZRU9STn2XmhvMGLPw+h
         hzzg==
X-Received: by 10.50.30.6 with SMTP id o6mr3609781igh.43.1397642086499; Wed,
 16 Apr 2014 02:54:46 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 16 Apr 2014 02:54:06 -0700 (PDT)
In-Reply-To: <1397640811-17719-5-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246326>

On Wed, Apr 16, 2014 at 11:33 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  contrib/credential/wincred/git-credential-wincred.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
> index a1d38f0..edff71c 100644
> --- a/contrib/credential/wincred/git-credential-wincred.c
> +++ b/contrib/credential/wincred/git-credential-wincred.c
> @@ -258,11 +258,13 @@ static void read_credential(void)
>
>  int main(int argc, char *argv[])
>  {
> -       const char *usage =
> -           "usage: git credential-wincred <get|store|erase>\n";
>
>         if (!argv[1])
> +           {
> +               const char *usage =
> +                 "usage: git credential-wincred <get|store|erase>\n";
>                 die(usage);
> +           }
>

This is not the indentation/bracket-style we use in this source-file.
