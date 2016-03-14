From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] commit: add a commit.verbose config variable
Date: Mon, 14 Mar 2016 17:32:59 -0400
Message-ID: <CAPig+cTj0AeAUPDm2MBE=72b98AU+0F90a6UwmorwrRoO0kx_A@mail.gmail.com>
References: <0102015376e53b40-d25f7fdc-4ae1-4aae-b779-052fcf252071-000000@eu-west-1.amazonses.com>
	<CAPig+cRC5kZCtELhTh3em0bv+mfeR58AKd3Y76VM+0J+C+zzcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 22:33:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afa6r-0008Ts-QI
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 22:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbcCNVdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 17:33:02 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35270 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbcCNVdA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 17:33:00 -0400
Received: by mail-vk0-f65.google.com with SMTP id e185so15860746vkb.2
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=ZvBMgXM4g2Fr2ofTz0fIIlj3VCVQ1PDb1pIM9RZUXDU=;
        b=aaYYDG3QNHCDG0wkAEUDXU1VfTPGAnNhBzFtfD3iJZ4GfwEYUuiGLhaIraJ2SpMmJk
         f5d2HWe2WG9xx09IS/h8bdYzti14MEVhoX5qZLZohotRZneWNoVJoz8CvnVgMfRYGe0n
         kwC89HiZYblIHWxViASfHmEz6oYI9j9YKKcHyaFsF6r4DzdXvYcW/c4nrP8IIhZnZ4EA
         /ij3JqIiSux6W0kLIL24RbQi494yfihevV3+l+0PFXB6PbVb7pXeggR9QWiuv0akho2o
         9fcm8aLHU4shpyxRarDp3WVDemLSC1anEIikIiim4hKjUncJ3ktZdVThkI/7+C2ZUrpz
         j20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ZvBMgXM4g2Fr2ofTz0fIIlj3VCVQ1PDb1pIM9RZUXDU=;
        b=aVP1HCMFPkwAOxAunD7kmFPz5NZwtXOEzAXPk63Q7uHF4MnGtGyxoCOo2Huul+S+hx
         9QM/Le/ul+GLFHIFcWO413idjgEh/iUIXYk0uj6xxg3rmQ+l5KcVi/yW0MGesZBF8uKW
         Rqt9U/BxvdQejfkWcEdtxxFYAxbV83vIojOkYVLt3Hc6cdYf62Nl7CAVmfDlc+K3Ftz/
         cZAALd2AXs0uLP/robOFE/yYHJXuuzzHbYE80PJCkq45vfgYEPYbMru/sVqJDqhFpDfI
         ZXOl1JrrgF8i84IcY5it7/U5vBCalG2kxAPsxATWaTgr4R7JJxVsrNiS6nPLHDo9NrVP
         bmEQ==
X-Gm-Message-State: AD7BkJIrK4KF8fPzfkGtXQ/6gOJ/UeKhTrianb3YKms2o58GeS2H+/gCTeQR9w9UpS+uBl1bWhLqxOte8cqKjw==
X-Received: by 10.31.141.2 with SMTP id p2mr27801594vkd.37.1457991179665; Mon,
 14 Mar 2016 14:32:59 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 14 Mar 2016 14:32:59 -0700 (PDT)
In-Reply-To: <CAPig+cRC5kZCtELhTh3em0bv+mfeR58AKd3Y76VM+0J+C+zzcw@mail.gmail.com>
X-Google-Sender-Auth: Pu0SxsO4bUAW-yDTeQWdeMZGE5I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288818>

On Mon, Mar 14, 2016 at 5:21 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> This is missing the important "-c commit.verbose=false". Without it,

I meant "-c commit.verbose=true", of course.

> you're not really testing anything interesting.
>
> (It was missing in the "something like this" example test I typed
> directly in the email of my last review[1], which I suppose is a good
> lesson that "something like this" is not meant as "final" or "trust
> this".)
