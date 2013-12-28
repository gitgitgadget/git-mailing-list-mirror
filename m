From: Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH v2] git-svn: workaround for a bug in svn serf backend
Date: Sat, 28 Dec 2013 13:58:22 +0400
Message-ID: <CANiYKX4fjYYRneqPxFDmpPg7e5ge9-hNktBvXVLQ=JxtM56tAQ@mail.gmail.com>
References: <20131226202805.GV20443@google.com>
	<1388131515-3015-1-git-send-email-rkagan@mail.ru>
	<20131227200708.GD20443@google.com>
	<20131227203443.GA9189@dcvr.yhbt.net>
	<7veh4yj5mm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Benjamin Pabst <benjamin.pabst85@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 10:58:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwqf5-00045G-Kb
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 10:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab3L1J6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 04:58:24 -0500
Received: from mail-qe0-f45.google.com ([209.85.128.45]:61345 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab3L1J6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 04:58:23 -0500
Received: by mail-qe0-f45.google.com with SMTP id 6so9994955qea.18
        for <git@vger.kernel.org>; Sat, 28 Dec 2013 01:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RftidL9S8Jg9Ux4oTPgjaB5rGuR/4eBiqG8g/gJuZ7E=;
        b=pKS5r1SeB33LKChGVZ63BhGsI45V+aDKccpcMGMB9+cMzw+TOvipIBN0Q00iJHJVwg
         8J2b1C20qks/UnGhOGwb3Hf4MdI9ufuIILGa5RUGXmY1v8Jpun4qXa0k2qXag5krF7AI
         tcQFt3pIfjBxFUkVlbIz9V56k7W1nl2PXZS3Cgq1H6qt56oKfLL4I9paohe5gz0Stntp
         q2skAuxqUcxsralHE3Gqv6MdZPrNahm56leXy9hYSy4aaU7u2JMtoF40/iB9Rl1Bn5ru
         /Z3//egt8PLhEVT1NysYFcSDlJJH2hdwM+1VKev6B14+b39MYlyxEBYWWzvctnDJdENR
         HjHQ==
X-Received: by 10.49.84.195 with SMTP id b3mr89660533qez.32.1388224702389;
 Sat, 28 Dec 2013 01:58:22 -0800 (PST)
Received: by 10.224.98.146 with HTTP; Sat, 28 Dec 2013 01:58:22 -0800 (PST)
In-Reply-To: <7veh4yj5mm.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: jvCQNcgOrIqLbxkxUbgMaqXbmZk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239767>

2013/12/28 Junio C Hamano <gitster@pobox.com>:
> Eric Wong <normalperson@yhbt.net> writes:
>>   git://git.bogomips.org/git-svn.git master
>>
>> for you to fetch changes up to 2394e94e831991348688831a384b088a424c7ace:
>>
>>   git-svn: workaround for a bug in svn serf backend (2013-12-27 20:22:19 +0000)
>>
>> ----------------------------------------------------------------
>> Roman Kagan (1):
>>       git-svn: workaround for a bug in svn serf backend
>>
>>  perl/Git/SVN/Editor.pm | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> Thanks. I almost missed this pull-request, though.
>
> Will pull.

Thanks!

I'd like to note that it's IMO worth including in the 'maint' branch
as it's a crasher.  Especially so since the real fix has been merged
in the subversion upstream and nominated for 1.8 branch, so the
workaround may soon lose its relevance.

Roman.
