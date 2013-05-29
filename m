From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/7] Rebase topology test
Date: Wed, 29 May 2013 02:10:04 -0500
Message-ID: <CAMP44s1a-C7upUvouH+7=Zc-V16BOxUVDv+UVzkuOt9bpip1Eg@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 09:10:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhaWS-0002UE-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 09:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935073Ab3E2HKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 03:10:08 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:49966 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933784Ab3E2HKH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 03:10:07 -0400
Received: by mail-we0-f181.google.com with SMTP id u57so6134120wes.40
        for <git@vger.kernel.org>; Wed, 29 May 2013 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5uwsLyIMlt5mVG+lxV+Eq+FchKkkwNtnMaNzuWH+4OE=;
        b=0zuuqpVN9I/syau/NogE0ebBw4JyCXCRNB549FP0SVMzU7FCTM2ag1ayjMYlNVlrEV
         1zJEpasKzMwJNcBMAhZZvEQJlJjhh0r+LHVX1EccyflPvB2r+yx30csdHkGrMfI8+X9K
         KKjCCkGIU71Xq69RcRCWjj7noPfOozcXrIHX4PrhznpHO1pUKn+s//Nv7vZpLiexW8Qf
         9aWJSaMZEyMGWBCcvNExiaDPJEPdo/GH/rvc0moOC6OEOZxoS8WWFL9BRB3ZHXg6ChKk
         9HFfRwAVuv0lccgCam9V1DMQ5pgEWE7ytFAyBerKWpwH77CiA9UeEVLljb0ayqotgmwM
         WZsQ==
X-Received: by 10.180.205.177 with SMTP id lh17mr15138441wic.45.1369811404912;
 Wed, 29 May 2013 00:10:04 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Wed, 29 May 2013 00:10:04 -0700 (PDT)
In-Reply-To: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225765>

On Wed, May 29, 2013 at 1:39 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> After way too long, here is finally a new version of the tests I sent
> at: http://thread.gmane.org/gmane.comp.version-control.git/205796.
>
> I have split the test up into two files. They stil take quite some
> time to run.

This is definitely needed. I'm doing some experiments with 'git
rebase' and I see so many problems in the code that these tests do
exercise.

I think a lot of the functionality of 'git rebase' should move to 'git
cherry-pick', and then all the 'git rebase' code can be simplified
greatly, and tests like these would help a lot.

-- 
Felipe Contreras
