From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/9] t1508 (at-combinations): increase coverage
Date: Thu, 2 May 2013 10:26:02 -0400
Message-ID: <CAPig+cQegm8PsskaWJ4F4+jz3mmwaQEhx5FAfatnLU3ar-FMAw@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
	<1367501974-6879-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 16:26:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXuSn-0003Qq-0Q
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 16:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759226Ab3EBO0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 10:26:06 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:50110 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757941Ab3EBO0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 10:26:05 -0400
Received: by mail-la0-f54.google.com with SMTP id fd20so561012lab.41
        for <git@vger.kernel.org>; Thu, 02 May 2013 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ACVSnaro4Ouw6joDO7mimO0+Sn5k2/yjRZJytjeQMwE=;
        b=xua2sXTR6FxxpvPdPOGSVEAwGeybpLbYK6kp60kXGRw7ujpVnKoWwkK9vPJaVCNW5e
         4VnGrV7U61zoZJfwThA3r7UtvGfoTSMH2i+fxmvy1eKQZq1evOcUFmkaTJizLvhP5vjr
         O9rZIYUG7XgYVmrCpw/GdTEPXdTLtiZnxUDxALXy5vegLQX3k7Vm12y5FnTtGocaSQQ7
         Y+URGu7gF+Pmdbrwl8q8iDwm5VmLyRtfz1y4FtLn+V4wMIjEXuJcwm7oxA6FfZ/jlybE
         GgZGM+1FXm03rYhC2svsctqjhl8dcahViaJRQRhavHEHmywqbL36F0AyWonMJLqL62SB
         XV6g==
X-Received: by 10.112.189.133 with SMTP id gi5mr2694530lbc.91.1367504762671;
 Thu, 02 May 2013 07:26:02 -0700 (PDT)
Received: by 10.114.186.233 with HTTP; Thu, 2 May 2013 07:26:02 -0700 (PDT)
In-Reply-To: <1367501974-6879-5-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: VXKeaBODx6tYyONZFdvbU50XPR4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223208>

On Thu, May 2, 2013 at 9:39 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Add more tests exercising documented functionality.
>
> It is worth nothing that HEAD@{-<n>} is senseless because @{-<n>}

s/nothing/noting/

> cannot be used with anything other than HEAD anyway.
>
> [fc: contribute a couple of tests]
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
