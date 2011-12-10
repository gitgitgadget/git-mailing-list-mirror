From: Santhosh Kumar Mani <santhoshmani@gmail.com>
Subject: Re: [RFC/PATCH] show tracking branches with their associated
 branch names
Date: Sat, 10 Dec 2011 16:53:46 +0530
Message-ID: <1323516226.1698.80.camel@sdesktop>
References: <1323502829.1698.6.camel@sdesktop>  <4EE32C1B.8070306@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sat Dec 10 12:24:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZL2G-0003Nd-Fs
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 12:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509Ab1LJLYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 06:24:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47304 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab1LJLX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 06:23:59 -0500
Received: by iaeh11 with SMTP id h11so102865iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 03:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=sHeaYCNTAywGpupyjGhtGbSu3rJ9DUYZ+g4vdRFRJzs=;
        b=iHIox/S0x1y5X4NyoA4lbbHaHpQ7pl52CMvnNJIfE/5lSLbNwMEftKtLgBxt/E+XSL
         nYsJvvCDG5Uc8gOmSvPYeKG+acszg45c3uy5jKBz3H7H3PaXtRHHB5O+qXGp6L0fAdap
         Mg+IdMsRPhVetcs83l3ez+NVtTFvrIFkablHM=
Received: by 10.42.189.5 with SMTP id dc5mr5374504icb.51.1323516238591;
        Sat, 10 Dec 2011 03:23:58 -0800 (PST)
Received: from [10.0.0.2] ([122.181.155.85])
        by mx.google.com with ESMTPS id l28sm44870028ibc.3.2011.12.10.03.23.52
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 03:23:54 -0800 (PST)
In-Reply-To: <4EE32C1B.8070306@lyx.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186759>

On Sat, 2011-12-10 at 10:53 +0100, Vincent van Ravesteijn wrote:
> Op 10-12-2011 8:40, Santhosh Kumar Mani schreef:
> > The "git branch" command, by default, displays the local branches. There
> > is no visual distinction made between the tracking branches and normal
> > local branches. This patch enables the "git branch" to display
> > tracking info for tracking branches:
> >
> > Before this patch:
> >    $ git branch
> >    * master
> >      local
> >
> > After this patch:
> >    $ git branch
> >    * master [origin/master]
> >      local
> >
> >
> Did you try "git branch -vv" ?
> 

Yes. I did. It is too verbose as it meant to be.

This patch distinguishes between the tracking and non-tracking local
branches.

I use a lot of tracking branches and they track different branches. I
tend find this feature useful to know which branch tracks what.

Of course, I could get this information in different ways. But it makes
sense to have this information displayed by default.

> Vincent

Regards,
Santhosh.
