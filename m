From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Thu, 13 Dec 2007 22:23:21 +0100
Message-ID: <81b0412b0712131323p7cbba402hbfe8105eb356bdc2@mail.gmail.com>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos>
	 <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael Dressel" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 22:24:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2vXD-0003QN-PQ
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 22:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933110AbXLMVXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 16:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933104AbXLMVXZ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 16:23:25 -0500
Received: from hs-out-0708.google.com ([64.233.178.248]:36641 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932257AbXLMVXY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 16:23:24 -0500
Received: by hs-out-2122.google.com with SMTP id 54so822640hsz.5
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 13:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=57CKboK/+O7lHD4rF1GdDIfdtwq8QpnbUn2G2M/fGfI=;
        b=OylGxXQ3MP96qdOB/3CiVhGJyG/mMUk25GkSWDhd4ML8rwoIs1m7RVeik7caPI0t0EUdiYPQMmZV8FhOno3it/TJOHwpxGkKswMzVUJFLOTK40ByPc1eXX4lEhlFEgnvi11fr2VEhhH30PxuKCjCgm5zzpzPt2EIdAQTMmR3Nds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=btczfcQXlsPExJulTnVMhsF21En0pJUVHf+PuNoq4jkWjmKc0V4+DqKgVhki5F1PMuUbZoN1G3wyVPJAxtG4jRdpIiqAggp8hjZM+xqsz4egRVydAyjYihqMbRwng60TRbTxRzxCdJfqH2U6jZpwrpK1UcQbkIToHZZaVYi2Ccc=
Received: by 10.78.131.8 with SMTP id e8mr3126250hud.52.1197581001950;
        Thu, 13 Dec 2007 13:23:21 -0800 (PST)
Received: by 10.78.118.18 with HTTP; Thu, 13 Dec 2007 13:23:21 -0800 (PST)
In-Reply-To: <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68194>

On 13/12/2007, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 13/12/2007, Michael Dressel <MichaelTiloDressel@t-online.de> wrote:
> > git merge --no-commit <branch> does "create" a commit. At lesat the
> > head and index are moved to the new commit fetched from <branch>. Maybe
> > that is because git was able to do a fast forward?
>
> Yes. Because fast-forward is what it called: fast-forward.
> It does not do any commits at all.
>

If you have a very recent git, you can avoid fast-forward when merging
by running with --no-ff. It has it's problems in general case, so it is not
default (see the git ml archive for "fast-forward does not commit").
