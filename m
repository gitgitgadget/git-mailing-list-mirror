From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v2 0/3] fixup remaining cvsimport tests
Date: Sat, 12 Jan 2013 01:01:34 -0600
Message-ID: <CAEUsAPYx3DtUg6sV0PRYjqY8Ss-dwGKoQX7Q7xNKBgGO_KvbeQ@mail.gmail.com>
References: <1357971703-28513-1-git-send-email-chris@rorvick.com>
	<7vr4lq9acu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 08:01:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttv6K-0004fk-IX
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 08:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab3ALHBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 02:01:36 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:33203 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3ALHBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 02:01:35 -0500
Received: by mail-la0-f48.google.com with SMTP id ej20so2402476lab.7
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 23:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=mSw4RSB73VBwBSGIjk5RriLyXi5tAvZLg/7bGBIqpyc=;
        b=QxKAQdLlJTygk7Gkd9AkHrqMnr0BSiYbE52aokAxkJlIyAQtDUEmmHfW2nZw0Ogbk4
         4IyIMiWI407jZHDlasmHjFrJ9+KB3iXMQ3b5fhCLKt3uHS6Ad7WBu1QwD2btYdmfu5Lz
         4cvrMGQk5rlBX9WNtiPHFcO57vIyd/5qxmoK1fIdAYZ6wYM5uAhWFnesj2VHN35FEpSJ
         g3BSQAqrVgEAClalR23unXWdf9vk0ck8uJL2l92KnpMo2S4FjgEJLu9h/sJuLzVSPIyU
         uB3APuaGgydCMY7BbQbu4qZFm3Pw3T/9jbSbyCfoa5MjMZcL1/3e9rgo+f9Lhc1hn8Kg
         rgcQ==
Received: by 10.152.114.42 with SMTP id jd10mr13282149lab.31.1357974094158;
 Fri, 11 Jan 2013 23:01:34 -0800 (PST)
Received: by 10.114.94.228 with HTTP; Fri, 11 Jan 2013 23:01:34 -0800 (PST)
In-Reply-To: <7vr4lq9acu.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: q8E7m--CHi0HjqaaenlrAYMdMQA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213273>

On Sat, Jan 12, 2013 at 12:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I too noticed the droppage of "-a" support, which may not be a big
> deal (people can drop it from their script, run cvsimport and they
> can drop newer commits from the resulting Git history to emulate the
> old behaviour without "-a" that attempted to find a quiescent point
> if they really want to and suspect that the upstream CVS repository
> was not quiescent during the import).

Is there any value to -a when fuzz is exposed (-z)?  I mean this is a
functional sense.  I think there is a lot of value to maintaining the
interfaces of both cvsimport and cvsps where possible.

> Likewise for "-x".  You said "no longer can be told" and that is
> technically true, but it is more like "no longer need to be told, as
> stale cache cannot get in the way", so it is probably not a big
> deal, either, for people to drop it from their script.

:-)  I originally wrote "need" and then changed it to be clearer on
why it was being removed.
