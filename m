From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/3] pull: trivial cleanups
Date: Thu, 16 May 2013 05:24:06 -0500
Message-ID: <CAMP44s1H8g37QTdzGsfL7LDwszjDW9hj6YdmDdj54qH=ar0URA@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=tP=v=3Q4dzPc=W0=j_7iFYdGnzkaV6U_MFSg=NCE49w@mail.gmail.com>
	<CAMP44s0sg6zQc9=cD1X61joxSd=LK7qT1k-suej3dYDD826hgw@mail.gmail.com>
	<CALkWK0=RF4cjQ4Lz4Qi2iac_NgLdzBRw5Q9uf8KjYJju8swWDQ@mail.gmail.com>
	<CAMP44s1vMTfrSaU+0S8EOM5g4L0885780SvT_THBr7u==bJ06A@mail.gmail.com>
	<CALkWK0kP1yhdhV7oLA4gYJTJ7VtU2WuhtJ_Q5UsZSS00y=FP_w@mail.gmail.com>
	<CAMP44s08Q3xn13iqptf5jAUThHcEWQK5b77=pWLvOnjGsBfSMw@mail.gmail.com>
	<CALkWK0mAWUV1KgFaY2LpSQ_+=deE5wwV=Je23MuMi=6ktE+DAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 12:24:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcvM5-0000Bn-Ch
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 12:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab3EPKYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 06:24:09 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:38135 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab3EPKYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 06:24:07 -0400
Received: by mail-lb0-f178.google.com with SMTP id w10so1420068lbi.23
        for <git@vger.kernel.org>; Thu, 16 May 2013 03:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=dEwsSMZ0Fo9mRlyVy8NuKJrODNQGFCiTCHWzKqpTQKs=;
        b=kB4412UOu8CHrtcIlpSru3hOEud7Sh9nk0FSYnh8vof02ttnTCL/Bgre+ssqQ/YRqL
         lZ9pk9PxWecCO0hRfaNIVkP5FXrfIo2yvM3O1/n3jhEur6iYPLLJMFiDYFRodG5PTT6U
         LGsQmj9dyzUz4lBllThx/asfwfuGMQ1jWdzU1IrtCx1aLp8mySpRomdKOxaulf6ZwpKH
         afhu8RHxe7uoR+WfG1zyd3Z84NqpP2MaQDwzHhXRpFInZxO6NkCRm4mh2H8scBXZbj4Y
         G4QsOX0fakNmLtFwZEA7YPq/6FnIpddWcocpCqpAl18s5gF+n+ToC/1QsVqGn0TppOOG
         qCcw==
X-Received: by 10.152.27.132 with SMTP id t4mr10757644lag.46.1368699846550;
 Thu, 16 May 2013 03:24:06 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 03:24:06 -0700 (PDT)
In-Reply-To: <CALkWK0mAWUV1KgFaY2LpSQ_+=deE5wwV=Je23MuMi=6ktE+DAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224550>

On Thu, May 16, 2013 at 5:18 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> It doesn't matter if you think it's a bad practice or not, 'git push
>> --mirror' works, and it's possible to update a branch even if HEAD is
>> point to it. There should be a possibility to do the same with 'git
>> fetch'.
>
> So, introduce a configuration variable to turn off this safety feature?

I thought you were interested in fixing 'git pull'. My bad.

-- 
Felipe Contreras
