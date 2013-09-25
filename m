From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Wed, 25 Sep 2013 10:16:53 -0500
Message-ID: <CAMP44s05ggre-ZcURLyTyYsFG1_f=gVDW-dj2LsNK8_tGTqyyg@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5WQLx4rsN+yRs62fgTBWkuAhCSWDRkoCc8M_akpSqMKvg@mail.gmail.com>
	<CAMP44s3nQv97B2=mq-mn8S41sMA43qRfr+nC7eQ=Jft=zRgTRw@mail.gmail.com>
	<CAEBDL5V1kyRwtKSM+L_E_XbJRauvdmOLc+g2acbixt0+pd6_ag@mail.gmail.com>
	<CAMP44s2j_ra_Tk_s-tjwwvX=T8y=bKPTaUdOQk1jD8QpUm+-zA@mail.gmail.com>
	<CAEBDL5X1QRLaTvxhEu4e5_NE5fEWc6fd60YJyA8wye4d4T3wpQ@mail.gmail.com>
	<CAMP44s2EtgXXdfa+QtUmmRh6wZ1fD8YTWtzLJ2mN6y_6faMM_g@mail.gmail.com>
	<vpqr4cdt0gk.fsf@anie.imag.fr>
	<CAMP44s3qv==GZt7BYMc-FuQvVoNGf3kkGAGzk=-=F4A8KZojKQ@mail.gmail.com>
	<vpqk3i5szng.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 25 17:17:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOqpo-0003Wr-QD
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 17:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab3IYPQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 11:16:56 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:40573 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018Ab3IYPQy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 11:16:54 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so4995056lab.2
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vur1HUbhA+2MhEar9rqlUJhz3GEASw3lpQYaduMJqwU=;
        b=Q3HOuZXAeNIafQjY5OYjp8MQrcRZpVw6LPD6gF2WzY4WZA2ZyeEBNb/h9AXJlugVZ4
         GMvCHA3zJ1STK5EQviyrwAwkLP5HXfAh1q0h9HYyVrGZ8Q4lc2aq/iT/8a4vNIEdN+rI
         rzWwZFdfMtVmdOyRKd1HkRcEwtHjamyFFQLJ2IX34iU4FFG8NzwizJGrQ/Ss/ay6pnkk
         Jo6WUU7QPmhh6+smzmTuuUijPQrwW39Qzudemjq9jtCiU0UeITFhan8/YsaLGpOibfBP
         cZ7sUfbRSpEF2JIhCkcXYTuh3+9zz+3TIEdspSFUi183U6ZoCjMusG8XYaXqRVtdlUpk
         vgaQ==
X-Received: by 10.152.6.202 with SMTP id d10mr644028laa.49.1380122213230; Wed,
 25 Sep 2013 08:16:53 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Wed, 25 Sep 2013 08:16:53 -0700 (PDT)
In-Reply-To: <vpqk3i5szng.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235354>

On Wed, Sep 25, 2013 at 10:13 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, Sep 25, 2013 at 9:55 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> But let me help you; you can't mention one, because there isn't any.
>>>
>>> Or because you didn't really look. Read the release notes of every Git
>>> release these days, there's a big section about ongoing backward
>>> incompatible changes.
>>
>> I said *important* changes from the common user's point of view.
>
> Call me fool, but I do consider the default behavior of "git push" as
> something important, indeed.

Last time I checked nothing has changed, the default remains
push.default=matching.

-- 
Felipe Contreras
