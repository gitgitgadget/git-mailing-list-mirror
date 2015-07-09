From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 06/10] Documentation/tag: remove double occurance of "<pattern>"
Date: Thu, 9 Jul 2015 14:19:01 +0200
Message-ID: <CAP8UFD0mSZ_FyPcaMoWRbrR=i9vFJvVYyqM+0B-3L3dQpA6SsA@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	<1436437671-25600-6-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 14:19:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDAnE-0004IA-Tg
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 14:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbbGIMTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 08:19:05 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38857 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbGIMTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 08:19:02 -0400
Received: by wibdq8 with SMTP id dq8so240421233wib.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4LouFWPA3S8aLXEslpr+ash5Jnd/F15DLb0ZCqsDrhA=;
        b=jC1yRwcYjvFJDPqaltt7uf0R5DTTiy+NBRHd0HHyHhdgmhFX0+tRjl2P3CAf5+gjg1
         6V9RAiPoQB6inahFLtCcowRw1zwEOP64VyWMVvaKG8J9bV1VxKXxONPO5vbRH46/io8U
         BxnBumT4PBvpCR8JLb0famFGtINoPNZd6mf4FWcEYUpL8yoCGGDrtEH1z+5v0c1qBYob
         kfnUg+AVx7vYBD1XKIVrIsRqRMlOsBB3IvmV70HSfSqKVSYDQ1Rsy4QlpwO2w33pNCBT
         OeNLmMPGV2yGY2bT/Vq0deM/f2WyF4IcbRerIKYVvHMmdmG6XGtEAunMayBXT6kpgpU1
         Koqg==
X-Received: by 10.181.25.234 with SMTP id it10mr120969848wid.41.1436444341497;
 Thu, 09 Jul 2015 05:19:01 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Thu, 9 Jul 2015 05:19:01 -0700 (PDT)
In-Reply-To: <1436437671-25600-6-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273744>

On Thu, Jul 9, 2015 at 12:27 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-tag.txt | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 034d10d..4b04c2b 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -14,7 +14,6 @@ SYNOPSIS
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>         [--column[=<options>] | --no-column] [<pattern>...]
> -       [<pattern>...]
>  'git tag' -v <tagname>...

As this patch could be applied directly to master and to maint maybe
you could send it at the top of this patch series or alone outside of
this patch series.
