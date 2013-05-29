From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC/PATCH v2 3/8] rebase: cherry-pick: fix sequence continuation
Date: Tue, 28 May 2013 23:06:47 -0700
Message-ID: <CANiSa6i5hzkNXJMDOPa6gHEkQKjgva4vprbD6UvqGtNFM4Qi-A@mail.gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
	<1369801000-3705-4-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6ivOnRfOVMTsgDygi=2dvxmMOqqWdqs7CBYohThOVzt7Q@mail.gmail.com>
	<CAMP44s0Zy4KpPN1n6HOVXWyCuevenbSFnH589YngMB9NVWcamQ@mail.gmail.com>
	<CANiSa6h7fY=GNM0VvFXvE-LD=nVWbEBGqWbaheZ6gr518_aPNA@mail.gmail.com>
	<CAMP44s0MQ-u=Yo1RAoxsVyiAe7xcorCW992xsa4YsEyH9RbzoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 08:06:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZXC-00006c-KR
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759488Ab3E2GGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:06:49 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:58101 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab3E2GGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:06:48 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi5so3175476wib.2
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uC/DMEr7DAIWcB9jhD9L/hoNU9/YdboU1h2QavjNauA=;
        b=XiCPzQ2X/VvufWIevJKPGF9H5rE1H+XdOfYze3ESYKDutCf2d/m8Cd3UH3uVQGkyI7
         xGwngX84XnXDUbtysvZjm2zxojUofYcAu9jH7Lf9kICq9X0b9zraKPsfdJbZu6Tj6tBQ
         LSMjsgZL7FDCDsWcBmgaVzFM0YTtZM+5nx8zSuCkiN6sWlAfT1rCkuIdLo4Vyc91Xi/Q
         hwgsEOI1Jg16Gt2vBkDV5iH2BvOaA1Y+wMCMu7aQRW/Rye4+w0YhqhnGq4rHxTZDXboL
         x5M7NsBpz9ovjjJnoUfgnoublFZY+ughulslDix46bqRior/BQQx+oM9Ld057EJ93e9k
         9DNw==
X-Received: by 10.194.120.134 with SMTP id lc6mr854162wjb.55.1369807607501;
 Tue, 28 May 2013 23:06:47 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Tue, 28 May 2013 23:06:47 -0700 (PDT)
In-Reply-To: <CAMP44s0MQ-u=Yo1RAoxsVyiAe7xcorCW992xsa4YsEyH9RbzoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225750>

:-)

On Tue, May 28, 2013 at 11:05 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, May 29, 2013 at 12:51 AM, Martin von Zweigbergk
> <martinvonz@gmail.com> wrote:
>> On Tue, May 28, 2013 at 10:41 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>
>>> One change splits, the other change fixes, what's wrong with that?
>>
>> I didn't say there was anything wrong. I was asking if the bug was
>> there before (and I didn't see an answer when Junio asked).
>
> Why wouldn't it be before? Did I mention a commit that introduced a
> problem? No. Did any patch in this series introduce a problem? No.
>
> All we've done in this series is 1) reorganize the code without
> introducing *ANY* functional changes, and 2) fix a bug.
>
> If you see 1) introducing a problem, or 2) introducing a problem, then
> mention that in *those* patches. If there is no problem with 1) or 2)
> then it follows the problem already exists.
>
> --
> Felipe Contreras
