From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 0/8] Speed up cache loading time
Date: Tue, 13 May 2014 16:24:04 +0200
Message-ID: <CALbm-EZEeFv=CX-TJJ3ZAUOxdBrqWfcJ_W-to20XAaB5=oZ0Rg@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
	<1399979737-8577-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 16:24:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkDcp-0001Km-K9
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 16:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933744AbaEMOYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 10:24:07 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:43539 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932891AbaEMOYF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 10:24:05 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so454620wgg.13
        for <git@vger.kernel.org>; Tue, 13 May 2014 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6px4S4ZbSDKz+ctqV4+LcijZJR55HnwhEfXG0LI/zxc=;
        b=GVmy98db18IqAwJGMnBVFISl+PoVJsuPlP1ey+2IPpIt0To1jeCH73Q4gfTSPBeAzv
         8FtKAYVCBmNEeotOlcUi52hI2t2r4EaAVm9BmP8j1flNAU/Ypg/cBrEkF7CtNBPo2Hmm
         LvvXdAuSr+TB19oGfxCnpn5H7EV060GsE55yujU/Cz+YaQ+2mdCZdpb0FjEayWbOv8gf
         HXiBQfAhOBIVKIAgJ5TN3TQOyN7Accsxpr4t5k16X052eBwcn64IOI6B6LtLl0r8nEFl
         Qb7my4lMernjUWyLzZ+e827kmfuuLhuf4xXTMVkYvgR1nmYcngvnooRsuPxGCW/rBg4t
         TSOg==
X-Received: by 10.194.89.168 with SMTP id bp8mr2075334wjb.73.1399991044179;
 Tue, 13 May 2014 07:24:04 -0700 (PDT)
Received: by 10.180.94.166 with HTTP; Tue, 13 May 2014 07:24:04 -0700 (PDT)
In-Reply-To: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248788>

> That is clocked at 800 MHz. A repository at this size deserves a
> better CPU. At 2.5 GHz we spend 183.228ms on loading the index. A
> reasonable number to me. If we scale other parts of git-status as well
> as this, we should be able to make "git status" within 1 or 2 seconds.
>

Which harddrive do you use? Traditional or SSDs?
Does have harddrive loading time significant impact here? (just a
guess/question)
