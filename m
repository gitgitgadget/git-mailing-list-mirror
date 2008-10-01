From: "Jonas Fonseca" <fonseca@diku.dk>
Subject: Re: [TG PATCH] README: Fix spelling and reflect recent depend support
Date: Wed, 1 Oct 2008 17:17:21 +0200
Message-ID: <2c6b72b30810010817p1eff63b7r32d9fbd5b9223c3b@mail.gmail.com>
References: <1222870059-22077-1-git-send-email-fonseca@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:18:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3TG-0006Px-Pc
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbYJAPRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbYJAPRX
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:17:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:13343 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbYJAPRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:17:22 -0400
Received: by wr-out-0506.google.com with SMTP id 69so242002wri.5
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=rr0xikWW3ZDsqbzOPrMs3sRei+pYkhK5NGXSo8qeNc0=;
        b=fa9/tVeAjatJe8CgCz2rpZ4rWTDrMlSTtVGrJj0h97NTcLOEBXQj/TQjcjBbOQAmo+
         RUjZBBnpuPqVojBqYz2OrTz1eydOwpaxEl6Ctnu/fo+j3bZLDIQIpIME8v8q6uQs5zmh
         CCeif3g19CALrtF14UqwGxg4595JfYVf7JAlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=vH6aii1Yd8ZwIYd/JHrcxDM6vLHzi2wwZPGmd0TcRdAgjWI+7EfbA8hVh+YPreRsIA
         Ur9B/X5F8/h+cAmJs5YfkgCZ5peCkcfFUxCeGEdeiyfTZoh1mHaLTnzJsckzyBoJP+fd
         SPOewP9mGCVwfSsB+AMHBxXr4ur2LdCe9OB/Y=
Received: by 10.142.53.19 with SMTP id b19mr3425351wfa.167.1222874241471;
        Wed, 01 Oct 2008 08:17:21 -0700 (PDT)
Received: by 10.142.153.19 with HTTP; Wed, 1 Oct 2008 08:17:21 -0700 (PDT)
In-Reply-To: <1222870059-22077-1-git-send-email-fonseca@diku.dk>
Content-Disposition: inline
X-Google-Sender-Auth: 2ca25837387af029
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97233>

On Wed, Oct 1, 2008 at 16:07, Jonas Fonseca <fonseca@diku.dk> wrote:
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
>
> ---

I have been trying to get `tg mail` to work and have a few questions.
Would you mind if topgit didn't insert an empty line after the sob
line? Most emails to this list doesn't have it. The patch mail I just
sent had two 'To:' lines: one probably comes from topgit passing
git-send-email the --to option and the other comes from the patch file
(basically .topmsg) containing a 'To:' line. Should `tg mail` be fixed
to filter this somehow? Finally, tg-mail uses bash arrays, however,
perhaps topgit could get away with just passing one --from and one
--to option to git-send-email.

> diff --git a/README b/README
> index 35a9f98..903face 100644
> --- a/README
> +++ b/README
> @@ -252,6 +252,7 @@ tg delete
>        depending on it.
>
>        TODO: '-a' to delete all empty branches, depfix, revert
> +       TODO: subcommand removing dependencies smoothly
>
>  tg depend
>  ~~~~~~~~~

Gah, this is obviously in the wrong subsection ...

-- 
Jonas Fonseca
