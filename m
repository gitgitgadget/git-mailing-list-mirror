From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Tue, 8 Feb 2011 18:46:47 +0100
Message-ID: <AANLkTi=Uqkzv+ucBzww6R1V+0ujmfH-dED8XJhyRvWQF@mail.gmail.com>
References: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 18:47:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmrf3-0001X1-Ob
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 18:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab1BHRr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 12:47:28 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:58575 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab1BHRr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 12:47:28 -0500
Received: by yib18 with SMTP id 18so2356657yib.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 09:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=XK8ytrGpvZ8RAbR5XvXR9yD0GR4GQW/6xBmiXZI4Zhc=;
        b=Sv+QdI/VNVao7pNHXE4aYj9Aiymf9dmkfwvU2Qpc8ArcHaBlFD/yVnkmEJzQQ2nQzw
         oD4SGTk77Wcit/uGb+U7Gh6TgRH0/Dw8CyWMU89UUlKhde15if0g5gFIgRImfwzCBqli
         lQu8vJ2dosxblW0O3MPOqDQ2VXb5O8KbkBnXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WA2hgp5kRrlzW8nlxoCNOpBkBkizzgNqHpFsXEhnEwPSyP8lUr09oajjWwjlP0ORge
         NQl8t45OPNsA/4LwBWDc4PpqlS6jaxUAwrtKnDw+quaayFR1nubzYAdhn4GQl2IN5XSd
         QpZX3iTyYAGuSD9tCuHoKE7YYOsTvtpdI7rtc=
Received: by 10.150.229.16 with SMTP id b16mr259118ybh.226.1297187247217; Tue,
 08 Feb 2011 09:47:27 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Tue, 8 Feb 2011 09:46:47 -0800 (PST)
In-Reply-To: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166361>

Heya,

On Tue, Feb 8, 2011 at 01:37, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> Defaulting to @{upstream} will make it possible to run e.g. 'git
> rebase -i' without arguments, which is probably a quite common use
> case.

I particularly like that you explain to the user clearly what they
have to do to make this work (e.g., configure the upstream). Nice.

-- 
Cheers,

Sverre Rabbelier
