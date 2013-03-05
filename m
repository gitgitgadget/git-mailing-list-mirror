From: David Aguilar <davvid@gmail.com>
Subject: Re: Configurable .gitignore filename?
Date: Tue, 5 Mar 2013 01:59:41 -0800
Message-ID: <CAJDDKr55ayTpzXPG3j5czY=-W08L8QjhMmjqWdRpoWO=MpHdyg@mail.gmail.com>
References: <CACoicv+Hq=d5fJ7PXYdyvOdWmc3-GbFrsAf2Ze7dnQTzjExXnw@mail.gmail.com>
	<vpqzjyjp8y0.fsf@grenoble-inp.fr>
	<CACoicvKMWSjU6Lf-2PsCShzqGiX-=2xF9+W0EtrHUzWPU7-T_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jari Pennanen <jari.pennanen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 11:00:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCofJ-0003eG-HY
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 11:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642Ab3CEJ7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 04:59:44 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:39040 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab3CEJ7n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 04:59:43 -0500
Received: by mail-we0-f177.google.com with SMTP id d7so5743555wer.36
        for <git@vger.kernel.org>; Tue, 05 Mar 2013 01:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=zJLEUx/CEYkwI7DhgX0ggRXWxVdfunZXWUX85FXizOU=;
        b=Vua7Pfel3M2/OaGp+vwK/91RfgRBPTpw0593o5MjRhOVRFb4m+GJooX7FWt/wtx96g
         +0iXr3hDtEDv/lUNmFABT2wWmdi/m/y/Gf5ceHTsqSE1/u17mUlJJN2Uw2Zc2sXSWwB5
         qWNtU35+UCo3E/rHeuTVfbqX5oiu4wAWbIiNJQ5xjFH30xQ0XsjeKX/3FIAqqTcz/QaX
         1iJETiJsGOPKNB0KDYWa62W07O96G2lID+6juK3Iwzs0stkqqfybmmUYJc6J7Pb/H/Rb
         bAtV+Ow3Z8mF7rVKUGvkpVRw2CuqWcX2cO1MBT202hy6vXWSPx3iTBsbvDFQ1EIsXYRL
         wSiw==
X-Received: by 10.180.183.81 with SMTP id ek17mr9039701wic.2.1362477581875;
 Tue, 05 Mar 2013 01:59:41 -0800 (PST)
Received: by 10.194.13.129 with HTTP; Tue, 5 Mar 2013 01:59:41 -0800 (PST)
In-Reply-To: <CACoicvKMWSjU6Lf-2PsCShzqGiX-=2xF9+W0EtrHUzWPU7-T_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217441>

On Mon, Mar 4, 2013 at 7:47 AM, Jari Pennanen <jari.pennanen@gmail.com> wrote:
> 2013/3/4 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
>> There is already core.excludesfile, which does not replace the usual
>> .gitignore but comes in addition. The common use is a user-wide ignore
>> file, not a per-directory one.
>
> I'm actually aware of that. Problem is the normal .gitignore files
> must *not* be used in the second GIT_DIR at all, in my case it's for
> syncing so I need to sync almost all files (including stuff inside
> .gitignore), though I'd still like to retain some ignore files for
> second GIT_DIR, e.g. like in rsync the .rsync-filter file.

How about .git/info/exclude in the 2nd GIT_DIR?  Would that help?
-- 
David
