From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Fri, 8 Apr 2011 02:29:59 +0200
Message-ID: <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com> <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Thorsten Glaser <tg@mirbsd.de>
X-From: git-owner@vger.kernel.org Fri Apr 08 02:30:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7zaj-0003EO-Ht
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 02:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757223Ab1DHAaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 20:30:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55334 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757140Ab1DHAaT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 20:30:19 -0400
Received: by iyb14 with SMTP id 14so2982681iyb.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 17:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Ud9uFWB38MKembV3eo9fRaSccxsxQB0pulMVa7SMmX0=;
        b=ddPffcjjupMxnylHjF7nMVsBFb2UcCW+mc0P4CBqgP6wgX54hnqgImlYAnWsN7EeNd
         0Yh/ZaTgH6eBXwBy/7bwe2L9sAcsxC0rZtV4QXk5SVZfjr+lzJKkDopPAk96j8G4vUhv
         ivT1wEeSKJcJBAnh09CUjdul6B+4WVERug8o4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WZyypsAjMauHO6CzC4CFEtEIxdegm2IPtSVg1UA1zhHdkFHfNVB01pBdMpNslfjELe
         zlZbsrG9BbNEcfr08+AEPKAqGIOVMeu+cp+ZncRtL1oFvmwV3Ixavc4t8rUrWvXXZ6Wu
         jaiyexBPMdULAsU57gf989TlWsjoiHAEJvaIU=
Received: by 10.231.130.153 with SMTP id t25mr1522792ibs.135.1302222619074;
 Thu, 07 Apr 2011 17:30:19 -0700 (PDT)
Received: by 10.231.92.16 with HTTP; Thu, 7 Apr 2011 17:29:59 -0700 (PDT)
In-Reply-To: <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171098>

On Thu, Apr 7, 2011 at 21:27, Thorsten Glaser <tg@mirbsd.de> wrote:

> but seeing that people seem to want to use
> git for keeping their /etc (I use RCS, myself, but volunteered my
> C skill to change metastore if it needs be) there is definitively
> a market for having it there, in a standardised manner.

etckeeper does exist and it's very useful.


Richard
