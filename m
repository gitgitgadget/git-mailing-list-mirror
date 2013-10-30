From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Help creating git alias
Date: Wed, 30 Oct 2013 12:47:00 -0700
Message-ID: <CAH5451kcTCYaXK4tqsCkHFNLxE0z8tv=n6h6QS_VkMpnWAsdGA@mail.gmail.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 20:47:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbbk2-00069T-Ms
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 20:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab3J3Trm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 15:47:42 -0400
Received: from mail-vb0-f48.google.com ([209.85.212.48]:38672 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab3J3Trl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 15:47:41 -0400
Received: by mail-vb0-f48.google.com with SMTP id o19so1207354vbm.7
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 12:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=veAH/nxo5jHBJRaCQL4BtMc6loMFkoKk2AJkGeKpzc0=;
        b=cpeb7RXR0cZZvH3cl/wV389vBVNOVCJBwXKcquerjiTaoCESexiDJoV9rbgQ7v88gy
         L86VAaEA9Pz3ZuUBaR50tRr2l3b2DoJRlYf3XfQf8iAzCIRSwv/aO6b2ncorFYoQfVTS
         f3TkSPtFCVzn8dFSs36PnT/xYVRP+VWMxvlJaeRtlkjz2rArWquE+CZZAUjyOn28bnST
         0sbcN7H6N+MuBpW1AfK7XRh6RZ93iiojnesYvyfVP9pdMfjnWDdsY/Amf628HgbXBWZ/
         LGO/BjllK9wU3KzPnhtGl53pRIVQ6odDlvj/s7D57LY/SuO2E00NOXK09/Tc/8CzOa34
         +BKA==
X-Received: by 10.52.34.76 with SMTP id x12mr1366972vdi.35.1383162460751; Wed,
 30 Oct 2013 12:47:40 -0700 (PDT)
Received: by 10.220.58.197 with HTTP; Wed, 30 Oct 2013 12:47:00 -0700 (PDT)
In-Reply-To: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237062>

Have you tried backslash escaping the backslash? double escaping?

I don't know how many are required, but I would try first \S, then
\\S, then \\\\S, etc
Regards,

Andrew Ardill


On 30 October 2013 12:34, Eugene Sajine <euguess@gmail.com> wrote:
> Hi,
>
> I need some advice about creating the git command alias:
>
> I have this as the command:
>
> git log --pretty=format:"%h %ad %ae %s" --date=short | sed 's/@\S*//g'
>
>
> The purpose is to cut off the email domain and keep only username.
>
> I'm trying to create this as the alias:
>
>
> lg = !sh -c 'git log --pretty=format:"%h %ad %ae %s" --date=short |
> sed 's/@\S*//g'' -
>
> but it complains about the \S and i'm failing to come up with the
> escape sequence to make it work right.
>
> I know i can work around that by creating shell alias, but it is not
> what i would like to have.
>
> Any ideas?
>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
