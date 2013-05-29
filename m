From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/7] Rebase topology test
Date: Wed, 29 May 2013 08:54:07 -0500
Message-ID: <CAMP44s2nJD1wLRY8JRQOdcmnMjtrFK852qCJtWS0N2GPE8Q1tA@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<CAMP44s1a-C7upUvouH+7=Zc-V16BOxUVDv+UVzkuOt9bpip1Eg@mail.gmail.com>
	<CALkWK0nXgbtYXVG5tosee9eQG5ody0OvFdF9bjfAzuAoRMchow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:54:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgpU-0001HF-2N
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935132Ab3E2NyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:54:11 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:48764 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759565Ab3E2NyK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:54:10 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so8721941lab.15
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BRYLdxw3pzn9Xhf26U8U5I5pP5dcKAI2YmVOAalnFgY=;
        b=BZDDCXqp7hJPTv8NMkWS5mVHONeZdBR6rAZ9bO51BUFeMAxpHXaJuBCnTGRVe4+Pgm
         5M0ADwetvio1KXe12cMCS+bdnsc6A3pxj/ZtVNVdFXMpKzxcdGlZgxKVaCigMxnNdP7z
         RoeFnKYIiI66lojWdl6FqbwZpELsD/Q5o2D3IjOCwOAuutbpOtKL2bxjlk4eiSs2e+iy
         hmn8D/DXkmw5NdFRXK3wOX7nTHc5i0zuv5NnVhk3+SX70+thG5dsDVi4X5Ds0A+DUkRR
         gC4IEy2+ykiHR4VdWhcB0OqrRZ9erMGCiJMDMBEpLSlJmqEi7PO9AnDUScrqGmIUAA7M
         XESw==
X-Received: by 10.112.88.166 with SMTP id bh6mr1681824lbb.47.1369835647760;
 Wed, 29 May 2013 06:54:07 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 06:54:07 -0700 (PDT)
In-Reply-To: <CALkWK0nXgbtYXVG5tosee9eQG5ody0OvFdF9bjfAzuAoRMchow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225828>

On Wed, May 29, 2013 at 7:50 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> I think a lot of the functionality of 'git rebase' should move to 'git
>> cherry-pick', and then all the 'git rebase' code can be simplified
>> greatly, and tests like these would help a lot.
>
> What do we do about the leakages?  Want to take on the task of fixing
> the merge-recursive machinery?
>
> Cf. $gmane/222887

Hmm, I saw that, but I also saw the fix.

Anyway, if this is such a big issue, I'm sure it should be possible to
trigger it in our test frameework.

-- 
Felipe Contreras
