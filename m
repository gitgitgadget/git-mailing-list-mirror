From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Sat, 7 Sep 2013 19:54:36 -0500
Message-ID: <CAMP44s2NUvm41+ysvj0hp5SvDtFZDt-4pGnh8hP4UT1kBRaUxQ@mail.gmail.com>
References: <522A36AA.3050701@gmail.com>
	<xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP6w8rvoz+h2Xase1ApY_kpZh4X=VF6LY4O0r7RS0UayA@mail.gmail.com>
	<xmqqsixgvci1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 02:54:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VITGz-0006S8-VK
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 02:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181Ab3IHAyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 20:54:38 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:63464 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab3IHAyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 20:54:37 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so3881444lab.33
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 17:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e724i1ANaxjiynp2Nvq+gjNImgh8XtvxuKDVbAyfbYY=;
        b=vSXs6Iz7tkSFZt1RO1u0q7j8hb+t64hub52/+I8OQoeHVxDlI34J0g6JOReq7wIcos
         bDIqOJJRmavKMJrDBwkms66AMIMySN7tNj+cR/UDpN5SKLldJdiJDumviRvwxP8qUjRV
         8jHCowXhZh58Gx7Jcljcd63XK+UxuzyiVNUeAoL89up3FL+ezOywuipkxwPH+I8dDtt+
         EXmx8MnU/CBzEvq0f1Jge9uj1CfIb9FkgGmA2ARAgJ9L4qesW/Q/lKUJUMCxBr7YbiCE
         lvAlvXxz35DOYeXhQDVNoQrlmmdlIUCjd3NQFNQ/4Ccm8E1Y55erO2IevVttZ4pfYHUD
         dDtg==
X-Received: by 10.112.51.166 with SMTP id l6mr9618393lbo.5.1378601676148; Sat,
 07 Sep 2013 17:54:36 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 17:54:36 -0700 (PDT)
In-Reply-To: <xmqqsixgvci1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234154>

On Sat, Sep 7, 2013 at 11:10 AM, Junio C Hamano <gitster@pobox.com> wrote:

> I am not sure what you mean by automated, but if you can tell your
> automation infrastructure that the way to build this Git software is
> to run "make" in it, shouldn't it be trivial to instead tell it to
> run something like this instead?
>
>         git describe --tags HEAD >version && make

Which is a pretty stupid option. 'git describe' does use tags by
default anyway, what else is it supposed to do?

-- 
Felipe Contreras
