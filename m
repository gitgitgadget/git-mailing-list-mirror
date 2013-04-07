From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/4] send-email: make annotate configurable
Date: Sun, 7 Apr 2013 11:45:28 -0500
Message-ID: <CAMP44s0g5YfvprwukJ4rnqXrm+S9-KJkwyYB+sxAcQjZpDXufg@mail.gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
	<1365318630-11882-2-git-send-email-felipe.contreras@gmail.com>
	<7vfvz2948b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 18:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOsik-0005eN-A3
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 18:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934085Ab3DGQpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 12:45:30 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36855 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934030Ab3DGQp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 12:45:29 -0400
Received: by mail-lb0-f177.google.com with SMTP id r10so4967006lbi.8
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=0JOLtiDGeKPAyxnrJ40m0xIJsu/hNjK9VetvDmiuRNo=;
        b=sIjrZ1z1j9QwWHOdAAzEeZkoc8MvhoZDLK9HtbPeilV1LbW7sAZ2HI9D6a6oIYsb0T
         qmPMlvqKX1sYubp1tlmG00nVKo7GFuv+C0YwlEU3jY9tB+lcZ/0+c2bv7r7xKuxQIrC5
         VhyN+KTo9k1RuFJ/iuKy4enrekvhAVCiU8mBRb4CmXE6vL1HDuhzVADkdxxs3PXqUTxx
         PJMb9PIVWy2NItPQSdyGIMWG2/pAmejWB5ab/YXUyK+larhJ5bN6C0FgtIoWoZY3TZhK
         Ka0dwGUBUBifdTSs50WTRvP7+OiiN8yNHLgO0wTCnwwhaLcAnFzWEV9zovOxhGxgP1Nu
         Nbog==
X-Received: by 10.152.128.98 with SMTP id nn2mr10147238lab.17.1365353128425;
 Sun, 07 Apr 2013 09:45:28 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sun, 7 Apr 2013 09:45:28 -0700 (PDT)
In-Reply-To: <7vfvz2948b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220329>

On Sun, Apr 7, 2013 at 1:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Some people always do --annotate, lets not force them to always type
>> that.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> Sounds sensible; any tests to protect this from later breakages?

Given that annotate doesn't even have tests, I don't think it's needed
at this point.

-- 
Felipe Contreras
