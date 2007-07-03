From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [PATCH] Add core.pager config variable.
Date: Tue, 3 Jul 2007 21:48:18 +0200
Message-ID: <2c6b72b30707031248r7a3ccf8bw23bda41f2e2e117e@mail.gmail.com>
References: <Pine.LNX.4.64.0707031729370.4071@racer.site>
	 <20070703181811.GA17966@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 21:48:24 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5oMJ-0006l8-GJ
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 21:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299AbXGCTsU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 15:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757319AbXGCTsU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 15:48:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:5065 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756587AbXGCTsT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 15:48:19 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2904225wah
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 12:48:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eDCVwdsMBmnV5wGS1rD84RatrNxagOYykk4NwwFpoQ+a8OnYgD06FCO103o4wazGw6VhnM4BzhsoXgZ1mkmrpqLIqHQaLcegFk+F3w1Zi5IemMh+1Dms6PiniMbpIPe+lYIlSlHLGamHMJ/ogZUjXmR1S4cms9YFbOPGCo0njHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SIB+bVdiw7nLK9nGxfGzEdBwCptJ32+BTTVyCid5CdPyu+bzmRweC/dcc59A4zS/k0Dy0geFpTBMqu/Ysoh69zuUHavyecGfdnnnOS5s5XYxxZsQ3q67tfBoBDcMDawPa9t1b6UooP6Mc8sl3g1PXQZjhE7/gGmdu274EMKmsmA=
Received: by 10.115.23.12 with SMTP id a12mr6447592waj.1183492098592;
        Tue, 03 Jul 2007 12:48:18 -0700 (PDT)
Received: by 10.114.26.20 with HTTP; Tue, 3 Jul 2007 12:48:18 -0700 (PDT)
In-Reply-To: <20070703181811.GA17966@Hermes.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51529>

On 7/3/07, Brian Gernhardt <benji@silverinsanity.com> wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1d96adf..d319359 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -281,6 +281,10 @@ core.excludesfile::
>         of files which are not meant to be tracked.  See
>         gitlink:gitignore[5].
>
> +core.pager::
> +       The command that git will use to paginatee output.  Can be overridden
> +       with the `GIT_PAGER` environment variable.
> +

A typo: paginatee.

-- 
Jonas Fonseca
