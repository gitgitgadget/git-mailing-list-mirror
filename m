From: Christian Himpel <chressie@googlemail.com>
Subject: Re: backup git repo on every commit
Date: Mon, 12 Oct 2009 20:35:04 +0200
Message-ID: <20091012183504.GA3872@mrslave>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com>
 <20091012141544.GF9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Israel Garcia <igalvarez@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 20:36:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPlJ-00010D-Cy
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757704AbZJLSfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 14:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757699AbZJLSfp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 14:35:45 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44667 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757701AbZJLSfo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 14:35:44 -0400
Received: by fxm27 with SMTP id 27so9500856fxm.17
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vCZWnUSwSTnKMtE9UAF/zBBWKxiVLsrcI+7Ipl4F3Yk=;
        b=gkWPUyVtfuWY5DNzQl0flgZtS3hHPQNltCKx+gNJd6TkTdAdC4Ix4xQGYh2+aDT5Hi
         urQnnP0dbclnsz3RtsqChVAfOfrdsOPXG6cPbDvAJBTRpvXBerU5Y5r0vMk4wbSvGmLk
         7KluThVt/UViGqLuzyP8mDLgk6NVj74HutX/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BUzEDWaGFCgTGhvKbGF9pPSbN+gswfmPYaNYPgVn1w7tQs+R/BEZvahp3z/bF8OnQn
         pxBFTPzh9GxG8+yMV17bAue5isBbFLCxTgLMYQ0RMTZTan5BrFvuZiseq0pTzQI2FYW4
         M9DzqwmftzVwHuQn5g/Uzv/8XsJAesA/XeKcA=
Received: by 10.103.126.32 with SMTP id d32mr2624028mun.0.1255372507876;
        Mon, 12 Oct 2009 11:35:07 -0700 (PDT)
Received: from mrslave (HSI-KBW-078-043-091-043.hsi4.kabel-badenwuerttemberg.de [78.43.91.43])
        by mx.google.com with ESMTPS id n10sm470127mue.17.2009.10.12.11.35.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 11:35:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091012141544.GF9261@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130048>

On Mon, Oct 12, 2009 at 07:15:44AM -0700, Shawn O. Pearce wrote:
> Israel Garcia <igalvarez@gmail.com> wrote:
>   git remote add --mirror backup you@another.host:path/to/backup.git
> 
>   cat >.git/hooks/post-commit
>   #!/bin/sh
>   git push backup
>   ^D
> 
>   chmod a+x .git/hooks/post-commit

Since this is meant as a backup, is there also a sane way to push the
reflog entries as well?  Or is it okay just to copy .git/logs to the
backup repository?

Thanks,
chressie
