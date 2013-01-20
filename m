From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Sun, 20 Jan 2013 09:22:03 -0600
Message-ID: <CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
	<20130120125838.GK31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 20 16:22:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twwj6-00006i-PJ
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 16:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab3ATPWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 10:22:07 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:55968 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab3ATPWG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 10:22:06 -0500
Received: by mail-lb0-f177.google.com with SMTP id gm6so1641216lbb.8
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=AuAbHRbm0kMaDerUeZBRdVD4GvtAYsSSUOZjnSnaUDQ=;
        b=UHK12vnAiXA/z4nC7csX6JQBLMsuVGww9GcpQSGsOFUAuImbw8OxN7ia/0hQNznNqe
         qkq1zMFKN75GzfpysmItIga85+uOXhIhqRNu7BBchhnf6kYlFwtLUQd8vlrOIyYjuCN4
         85EeNpqTncFDiqT22/nnIS4ULX0s78nF0a55Mmm7W/A3oeh92IsHbeuZQ25xn4rr5vdG
         hUHzhmobRL5I1Pe9AOg/3CgJuQv2a+kwbnSyG5RR7/V1jnqOkC59QSPPgklpLPbbS5iv
         cHR94iv0zb1JSC2hFHHI38iz3mfK/FyTc6/A1RGUdULMErETDGlap4NYv3kJHTfOm7Nk
         1K/Q==
X-Received: by 10.112.26.41 with SMTP id i9mr6329841lbg.77.1358695323823; Sun,
 20 Jan 2013 07:22:03 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Sun, 20 Jan 2013 07:22:03 -0800 (PST)
In-Reply-To: <20130120125838.GK31172@serenity.lan>
X-Google-Sender-Auth: 5j9Vj_JIUb53UtuTbiD5hrHMxdc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214022>

On Sun, Jan 20, 2013 at 6:58 AM, John Keeping <john@keeping.me.uk> wrote:
> Hi Chris,
>
> On Thu, Jan 10, 2013 at 10:27:16PM -0600, Chris Rorvick wrote:
>> These patchs apply on top of of Eric Raymond's cvsimport patch.  7 of 15
>> tests in t9600 fail, one of which is fixed w/ a cvsps patch I've sent
>> to Eric (fixes revision map.)
>
> Did you post the fix for the revision map publicly anywhere?

It's in Eric's repo and included in version 3.8:

https://gitorious.org/cvsps/cvsps/commit/abe81e1775a8959291f629029513d1b7160bbde6

Chris
