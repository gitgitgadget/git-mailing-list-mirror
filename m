From: John Tapsell <johnflux@gmail.com>
Subject: Re: git reflog --date
Date: Tue, 21 Oct 2014 19:12:04 +0100
Message-ID: <CAHQ6N+qkQbmhY-nueF28+iRhbVvH__gihXb6yyj3dRbgpbV18g@mail.gmail.com>
References: <CAHQ6N+oQV8Uesv_eCBZc+hpwR5rDWA22OXR05AJ_zXcf7bfQ7g@mail.gmail.com>
 <xmqqh9yx1gkt.fsf@gitster.dls.corp.google.com> <CAHQ6N+rb6eNC0_uzCAdH-HNb_SmdG4-W9DgmVKjfNpRcKKxk=w@mail.gmail.com>
 <xmqq8uk91emg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 20:12:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgdv3-0001WZ-8p
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 20:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988AbaJUSMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 14:12:25 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:40810 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbaJUSMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 14:12:25 -0400
Received: by mail-ie0-f182.google.com with SMTP id rp18so1774921iec.41
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GSTGwXuayYDY2aHTDRyGGvdtsVRR4ZzgzbfXrktZT7o=;
        b=k5232znBx4BDugip5uRQNlLIms98DRuCy/L6MqG0FotemXfi7aZTMbUfVjtYfERhPV
         hHoQHH1/IcSLPrmn1rm+FduQUOK9AWzl7isH5gWmisi+3yU5nFKWVr2YlZdOnQS5ZquZ
         AMSXDloFB3FHzSntxZ9RlQD2+/NcpsiRLe+vF1ODox19dV5+ASWUd16ucFhEJ+DvdWE1
         DXkFq3CiT9/ZWo96sFCcfgDXfwpLh//ImsFRxN2+hP9qXG3JMxOxnrZV+J40P/nYSJr6
         am8JZS3071P++eA6UEa2ACnFJRojRrJYvERW5jX5vAwCTInMeAlYBSPGFqlCMoHDbZZb
         cL5A==
X-Received: by 10.107.8.152 with SMTP id h24mr5099234ioi.84.1413915144252;
 Tue, 21 Oct 2014 11:12:24 -0700 (PDT)
Received: by 10.107.11.96 with HTTP; Tue, 21 Oct 2014 11:12:04 -0700 (PDT)
In-Reply-To: <xmqq8uk91emg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Great - now I just need to persuade someone very nice nicely.. :-)

On 21 October 2014 19:06, Junio C Hamano <gitster@pobox.com> wrote:
> John Tapsell <johnflux@gmail.com> writes:
>
>> For me, writing "git reflog @{now}"  is a lot less intuitive than "git
>> reflog --date"
>>
>> Currently the top google search for this question is here:
>>
>> http://stackoverflow.com/questions/17369254/is-there-a-way-to-cause-git-reflog-to-show-a-date-alongside-each-entry
>>
>> Which doesn't mention "@{now}"   at all.
>
> I would say that a site where cluelesses attempt to lead other
> cluelesses is not the best source of information ;-), but that tells
> us that either our docs are not read by people or they do not give
> necessary information to them clearly enough.
>
>> My opinion:
>>
>> 1. Add --date   as an option to reflog.  Perhaps using the log.date
>> format as the default.
>> 2. Document --date in the man page for "git reflog"
>> 3. Document @{now}  in the man page for "git reflog"
>>
>> Sound good?
>
> The order of changes is questionable, but other than that, I think
> that would be a good way forward.
