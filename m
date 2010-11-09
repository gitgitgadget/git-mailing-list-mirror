From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git automatic stashing?
Date: Tue, 9 Nov 2010 19:36:02 +0700
Message-ID: <AANLkTi=G=Xo90QayvuRDp=GTWtkES2fU0kkmn87Q09_2@mail.gmail.com>
References: <AANLkTim3MacQK6EtTPNJsYbqb=5bOM3W3BXC6p=hT+PU@mail.gmail.com> <AANLkTinwftXiZxbs_=PeM-MxQmMF4VaBCPEufH=OG6iU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Casey McGinty <casey.mcginty@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 13:36:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFnR8-0007ax-Q7
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 13:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878Ab0KIMgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 07:36:25 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53273 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab0KIMgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 07:36:25 -0500
Received: by eye27 with SMTP id 27so3444957eye.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 04:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ZOWCnaZG2Vho17FBPjfQJSXkP2RCYX0PfOQaED1eYpY=;
        b=HF5mBapEypx/bRiRxng69lG0S0DTeAsa7z1mydebrzHohfYU1TXhheQGiOlOg2NVSL
         ieLk+CoCKlGB07Um0c3NcdRgPpCqc6Qf3pQY4/Xv4a8h0M6osDdMuBqk3ZaMSvFXNH61
         eexiie1c6sjlAGbtlNI/FU++RR5P9jkQSsHww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cuIVJUOlx8M+bvHW2wzjmkdnhJaqEBwvOlGWGq3R8visi5V7sqNztwGlYRqwe/bGyy
         LXR+yU1sp8HeAKUfVx/giEax0Th4rFbjfZYxE2S4yYVGdGmxGixd/VBgKepwPoBwAr/i
         NWuPmscDsg8oGG07xaI82zHQpercoPGNyQ8zg=
Received: by 10.216.47.19 with SMTP id s19mr733312web.56.1289306183041; Tue,
 09 Nov 2010 04:36:23 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Tue, 9 Nov 2010 04:36:02 -0800 (PST)
In-Reply-To: <AANLkTinwftXiZxbs_=PeM-MxQmMF4VaBCPEufH=OG6iU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161041>

On Tue, Nov 9, 2010 at 12:37 PM, Casey McGinty <casey.mcginty@gmail.com> wrote:
> Is there any feature in git to perform and auto stash apply/pop when
> trying to do a merge/rebase in a dirty working dir? This would save
> some keystrokes from time-to-time, and make it easier for new users
> unfamiliar with git.

And when switching branches too.
-- 
Duy
