From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GIT-GUI) 1/8] git-gui: Don't allow staging files with conflicts.
Date: Mon, 8 Sep 2008 16:25:00 +0400
Message-ID: <bb6f213e0809080525t5da18021jf8f564a748545468@mail.gmail.com>
References: <200808310052.21595.angavrilov@gmail.com>
	 <200808310054.19732.angavrilov@gmail.com>
	 <48C5161E.3020402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 08 14:26:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcfop-0003Gd-PS
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 14:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbYIHMZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 08:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbYIHMZF
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 08:25:05 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:5502 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbYIHMZC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 08:25:02 -0400
Received: by yx-out-2324.google.com with SMTP id 8so821751yxm.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3C7J9g68lGdUV2rpHrM92P2l4pPiLzhPN3VVMC//UJo=;
        b=Gc26j7JjZB/qXAkajAgqMuEDjudae78jHKdo2cvTsIbypHQKKnMLEKbIG8foMiXFXY
         tm+B4yRG2jTigfSNK5uAtVOT/Rwd0/5r/wIgyiU9XNKEjlXUK/fAVYFOi01mpeZEHIN8
         DUyeXogX8x6fRe9w/IElb/2OHo4V5DqZ7RH8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DYCb92qkxFw66DNTd6LxZg/rfoNn/r7fxHdIdHeMyzXgmHFcbNYabztsgzV+GEQ19M
         lnpt/3vXMsrdytsDXbJqhSfbFC3I8k3JJ0XL61sBvvTYGAk2la9ww6B3Jwy+3bnv8lkO
         lKyV+uOGWd0K7LisRYIRcATiXVep14aOd9c88=
Received: by 10.103.23.4 with SMTP id a4mr6285354muj.0.1220876700849;
        Mon, 08 Sep 2008 05:25:00 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Mon, 8 Sep 2008 05:25:00 -0700 (PDT)
In-Reply-To: <48C5161E.3020402@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95245>

> I know I'm a bit late... I just got the first impression of the
> consequences of this patch. And I don't like them.
>
> I did a merge with conflicts, and the result was resolved to my liking by
> rerere. (And even if rerere did not kick in - I'd have resolved the
> conflicts in an external editor anyway.) Now I want to stage the file -
> but I can't. :-(
>
> No, I can't "Run merge tool", because I don't have one.
> No, I don't want to "Use remote version" or "Use local version" or "Revert
> to base".
> Yes, I want to stage the file _as_is_!!
>
> Please help.

I'll make a patch today to add a new item to the popup menu.

I don't use rerere much, so I didn't notice this problem myself until
yesterday evening.

Alexander
