From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] Sync "git diff -h" with the manual, show options summary.
Date: Sun, 24 Oct 2010 17:15:09 +0200
Message-ID: <87tykbpqpu.fsf@gmail.com>
References: <1287840825-6491-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Oct 24 17:19:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA2Ll-0007rT-VL
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 17:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779Ab0JXPQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 11:16:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36916 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab0JXPQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Oct 2010 11:16:28 -0400
Received: by bwz11 with SMTP id 11so1736422bwz.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=xb/WCzbP6C9xuyPo/Pn8nni8Ev5B7d7/F7MLO2yOvXY=;
        b=qqQO2GAi1Yu00NUNRxbLd9rmaCJLiRlwN2aMjwNM9p//RBhS2Qn0POFsVxymuiXubK
         9hdNZA2dv/7n+VgmfWcIDggTyptLnRmj94BwsnKnWC5oJL/MwlTzCROY1Jw8LQqWyGyX
         EVbT9N2wZjwN6tsXnbzp+fD31S6ZVv9SzPzoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=HSIUHuoUMIHTTX13gfNqGfm/Ual15ZoQb/u56DzK0EIAkq0NfzEqQKCNZxcEWV86xN
         lhZVEPBOuRT61fhSACjsCyfydx+lmaIEv/0HnAiP4zgCw787ZfpRdDTcAoVCh4zNE1KV
         JC4xkKDMYAhkTMQpyd4E2EF5GiXYOYWc7UJvE=
Received: by 10.204.117.196 with SMTP id s4mr4338575bkq.78.1287933387361;
        Sun, 24 Oct 2010 08:16:27 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id a25sm3959821bks.8.2010.10.24.08.16.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 08:16:26 -0700 (PDT)
In-Reply-To: <1287840825-6491-1-git-send-email-ydirson@altern.org> (Yann
	Dirson's message of "Sat, 23 Oct 2010 15:33:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159878>

Yann Dirson <ydirson@altern.org> writes:

> Signed-off-by: Yann Dirson <ydirson@altern.org>
> ---
>  builtin/diff.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index a43d326..8736225 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -22,7 +22,8 @@ struct blobinfo {
>  };
> =20
>  static const char builtin_diff_usage[] =3D
> -"git diff <options> <rev>{0,2} -- <path>*";
> +"git diff [<common diff options>] <commit>{0,2} -- <path>*"
> +COMMON_DIFF_OPTIONS_HELP;
> =20
>  static void stuff_change(struct diff_options *opt,
>  			 unsigned old_mode, unsigned new_mode,

When at it, could you please also use [<path>...] instead of <path>*?
That's what the man pages and other usage strings use.

=C5=A0t=C4=9Bp=C3=A1n
