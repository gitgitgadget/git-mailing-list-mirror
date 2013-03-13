From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [PATCH 4/4] contrib/subtree: Replace invisible carriage return
 with a visible \r
Date: Wed, 13 Mar 2013 22:36:40 +0000
Message-ID: <CALeLG_kSye2xRoUJ8ytjx-bsj6oSG_brPbj-X3yfXuLA-KEppA@mail.gmail.com>
References: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
	<1363213963-4065-5-git-send-email-pcampbell@kemitix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Greene <greened@obbligato.org>,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	Paul Campbell <pcampbell@kemitix.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 23:37:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFuII-0000MV-9q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 23:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934327Ab3CMWgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 18:36:43 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34179 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729Ab3CMWgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 18:36:42 -0400
Received: by mail-ob0-f174.google.com with SMTP id 16so1586495obc.19
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 15:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=TJqSUklOvfvTJkEr8FEISf0Gwd8NuQx0i7lD5Dq3pmg=;
        b=QmyJARwPm4Jo65d9EJl9m+r9jpzHrCR7pivi4Z5ZHi1yhB1jo1ucmDtOc+Apk1pP4q
         uIm6bQIkF3rerrA8X77RaMlYyJWw//jy/jyCneBJpWTrdP5CGayvCK0rz1XCPkCmg6tZ
         qYewb6Fdjm3Q3gQ23cPsq0dqinZPA7oMFih7qVpp92x7aK00DyHoOhe/ApGHp6zzsAhh
         cYj977J6qa4VqBzO04H8eb5TFPkCTlsDOlxj4pP6P8XeCGQhc37iME9vi4G8ABSMCpXY
         nADVjwRMwMAHxofgxM9ZEfVnwwTp510wnmqhGwSW2jzTg9JPFpmWs8aX/IWyayORQsD1
         xIHA==
X-Received: by 10.60.11.35 with SMTP id n3mr37204oeb.90.1363214200130; Wed, 13
 Mar 2013 15:36:40 -0700 (PDT)
Received: by 10.76.13.2 with HTTP; Wed, 13 Mar 2013 15:36:40 -0700 (PDT)
X-Originating-IP: [2.102.86.203]
In-Reply-To: <1363213963-4065-5-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQlsBkwazXG6AzIwJ7q+R0lcDkhWBQ64jXWT4XPL7tctx5f9+5k6JQGJIqf3bRWsiIMu/mGh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218102>

On Wed, Mar 13, 2013 at 10:32 PM, Paul Campbell <pcampbell@kemitix.net> wrote:
> From: Matt Hoffman <matt.hoffman@quantumretail.com>
>
> The ctrl-M (^M) character used for the carriage return (CR) is not visible
> in all (most) text editors and is often silently converted to a new
> line (NL) or CR/NL combo.
>
> 'say' is a wrapper for echo with accepts the option -e to interperet
> escaped characters. \r becomes a CR, yet is not munged by text
> editors.
>
> Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
>
> Conflicts:
>         git-subtree.sh

Oops. Meant to replace this Conflict line.

> ---
>  contrib/subtree/git-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 2d9b071..5314bd0 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -595,7 +595,7 @@ cmd_split()
>         eval "$grl" |
>         while read rev parents; do
>                 revcount=$(($revcount + 1))
> -               say -n "$revcount/$revmax ($createcount)
> "
> +               say -ne "$revcount/$revmax ($createcount)\r"
>                 debug "Processing commit: $rev"
>                 exists=$(cache_get $rev)
>                 if [ -n "$exists" ]; then
> --
> 1.8.2
>



-- 
Paul [W] Campbell
