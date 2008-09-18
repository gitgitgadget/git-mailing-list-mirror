From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] .gitignore += vim swap files
Date: Thu, 18 Sep 2008 19:38:58 +0200
Message-ID: <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>
	 <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Kirill Smelkov" <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:50:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgNe5-0005vf-9t
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 19:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbYIRRtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 13:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755570AbYIRRtE
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:49:04 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:59206 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436AbYIRRtC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:49:02 -0400
Received: by gxk9 with SMTP id 9so31584677gxk.13
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oSZrs0+vgrXKCOkHdWKFO5zAt+EHBnvUrygn8zrx3g0=;
        b=H5Ho3OK4bXqJwXE/ZoeNxbMi7LcFVlVUpAf1Kv26IqnPxvQSXN/vNIrkdWkPx3cav6
         +1CEtKXgNKyP6uOSggNBFqBCUQFFaOET23Pw8m2e42IJ785J92A0KKTJw/qpiO4QC021
         5ZvNHimJk0vLnQuHRepC18U3TyLK/E3fiOkVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hVRDYuxR3a/pjH94veE7PeewftyB/kc2MGm085z8rVdGBrf9cKMxHWKTUCpkpl++ZT
         ycw1fS70YswROS01vi1Pxf9B7/SMPSVWFzEBn2cmgK3SJftj2N72dSWTevBHvG7e7UNY
         ap/xqtqxEOUzDRGd4RHgOkyxzJs3xadLG9yW8=
Received: by 10.100.194.5 with SMTP id r5mr5778673anf.2.1221759538931;
        Thu, 18 Sep 2008 10:38:58 -0700 (PDT)
Received: by 10.70.36.14 with HTTP; Thu, 18 Sep 2008 10:38:58 -0700 (PDT)
In-Reply-To: <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96229>

On Thu, Sep 18, 2008 at 18:29, Kirill Smelkov <kirr@landau.phys.spbu.ru> wrote:
> Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> ---
>  .gitignore |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 8868f2d..aa39db4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -18,3 +18,5 @@ tg-import.txt
>  tg-remote
>  tg-remote.txt
>  tg
> +
> +*.swp
can't you do this in your .git/info/excludes?

bert
> --
> 1.6.0.2.250.g965aa
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
