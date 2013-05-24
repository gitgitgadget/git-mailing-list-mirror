From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [QUERY] How do you sort completions?
Date: Fri, 24 May 2013 21:48:41 +0530
Message-ID: <CALkWK0n8iuwNHfxV4AHUV+721pqLUOPhM6h+e0_opmkVuOV_4A@mail.gmail.com>
References: <CALkWK0k=nVHOBe5SgRH9xQK1+yAYBzbNMqsWxhYPo0MTZPp63g@mail.gmail.com>
 <20130524161243.GB2104@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 24 18:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfuiE-0006Ji-3f
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479Ab3EXQTW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 May 2013 12:19:22 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:51285 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710Ab3EXQTV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 May 2013 12:19:21 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so12338144ief.26
        for <git@vger.kernel.org>; Fri, 24 May 2013 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dMqOIFTa+kesHjRobj84QzSEvUr2cppcaF3/4ilkh+Y=;
        b=nNEyy8xs1a6vxQio+mJkTn6NDVAiP7oVbw4evt1fJZmyM24Pzv6ys0dk6BMkyP/vof
         i1fauX6mI24VSjExK+KwVRJk+zxFVfdc8CwME5ZVxdhCM3mdUTwaf46xJqRUJAJM35Nk
         TYC+HaC5F/Wv14S2XIqDZv8RBBmMtGBpK0Dumz4rOzqAkK6Sbmji8BSS53a3S4GgkvGi
         R1qSYCfwHGz6dcZN3NeC7+o828SFoGGoui/3vxCt/+DiDjpr/cCkl4rG6OecyDnh0HQ2
         koWEQR/6WOzBreIwBpTGXZ3bJJZPt5QkA3A+qNYy3v0AqBIAucQKuqddt9fNbmdkKZU1
         BB+g==
X-Received: by 10.50.66.140 with SMTP id f12mr2794917igt.63.1369412361374;
 Fri, 24 May 2013 09:19:21 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 09:18:41 -0700 (PDT)
In-Reply-To: <20130524161243.GB2104@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225373>

SZEDER G=C3=A1bor wrote:
> I don't know who does the sorting (Bash or readline), and I don't kno=
w
> any way to disable it.

Damn; so it's impossible to have a custom-sorted completion list in
bash.  Any idea about zsh?  I know that there are completion groups,
but I'd really like custom sorting.
