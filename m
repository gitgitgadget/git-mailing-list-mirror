From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] tests: fix autostash
Date: Sat, 8 Jun 2013 19:34:51 +0530
Message-ID: <CALkWK0mBnG7houMKHDorz3oSm=R7u4Va1s=AepSM0CPY6Gy4cw@mail.gmail.com>
References: <1370648714-7872-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=OdcLDCd9OonUS6kBZhA=oz3HYJT8Eiqnh1A++s5yWww@mail.gmail.com>
 <CAMP44s3rYXOmGWR3JM8xy8ON4pqDRhYWVMQqOAyODVr5myq+yg@mail.gmail.com>
 <CALkWK0=qVXL=DtJzYRGFLQQh3_-cGC_t_zpaiTL9KVKN4--mVg@mail.gmail.com> <CAMP44s1p-VDMLNhoym5fH3XAn8CWqu2yqGq0mb+55qHOq-r_ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 16:05:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJlw-00071b-J5
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 16:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813Ab3FHOFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 10:05:32 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45232 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab3FHOFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 10:05:32 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so13403041ied.28
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=k4kB0d3fXhQSSkMRTsMLPRvaD7OslJNGbyopfR9hVsk=;
        b=Xs5RxpEztwlyxy6u9zxiSSWLnKrg48EQA4eGxr+4RQiKwCMq0hbQl580cEQPxHQTqy
         R6xxx+a34Iz9Zn+jqZG5eVDaMzQlRFR+zLIXtHsVh6KQRdNTty2H7V8B1EkvC9Mie897
         i+CKLtaMc9poMKQ7+NRcHfPMEi3hzxjBXpwGZlyTVLGZHUuqEsDHTAc4EtnzS/ZO48pl
         J/oyJGgaT9v0FArlA3xq1EulDOnTPy+lLJwkJ8/EYwUAYYlwtTh35B/ennHqkwJ0eY+U
         UyrPrCAxuP+UKCObB1r0PEZ/GrIQISK3BAS81jjJ75Wvxyv7gtPQ88eHz7hk9agRxDFv
         GKkQ==
X-Received: by 10.50.25.194 with SMTP id e2mr910672igg.111.1370700332058; Sat,
 08 Jun 2013 07:05:32 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 8 Jun 2013 07:04:51 -0700 (PDT)
In-Reply-To: <CAMP44s1p-VDMLNhoym5fH3XAn8CWqu2yqGq0mb+55qHOq-r_ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226827>

Felipe Contreras wrote:
>> Ofcourse they're implementation details.  Even in this very test, I
>> check $dotest/autostash plenty of times.
>
> The more the test relies on implementation details, the worst.

I'm not convinced about this.

>> Then show me how to do it correctly.
>
> Something like this.

Yeah, this is definitely better.  Can you submit this patch?
