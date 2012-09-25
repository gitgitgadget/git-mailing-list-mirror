From: Jean-Baptiste Quenot <jbq@caraldi.com>
Subject: Re: [ANNOUNCE] tig-1.0
Date: Tue, 25 Sep 2012 09:46:27 +0200
Message-ID: <CAK6bCaypdgo=cWOk6JskYRYALCT8FrHQ8Obh_p4HULXqGvpfag@mail.gmail.com>
References: <20120510134449.GA31836@diku.dk> <CAK6bCaz7yPR0QmcOwY0iUP0hyisTf-bz=c0G_1nZkjCLDWDR+A@mail.gmail.com>
 <CAFuPQ1+22erJZ11fm1381-RPs0rKZr=EZJgZWQ1Jp00r6Wc8HA@mail.gmail.com>
 <CAK6bCawaqEvKFf43wzv+Yz5eem5W-qi9p1i+-9+jiMFs=tZ8xA@mail.gmail.com>
 <CAFuPQ1+6EkeVDmkQg-r0_KegDDmC0QnO4mtn0ad=4UK8G=9iCA@mail.gmail.com>
 <CAK6bCawuaYnd=YnevU6cXKmy=X9ExQ5kKxZopHC12+VTyPp-qQ@mail.gmail.com>
 <CAK6bCazQvYP8dgQzF5BY5+UNfGvm_SOcrVZoREdpszyrHOjEuQ@mail.gmail.com>
 <CAK6bCazoVPSmyGtU_7qWTZpfnmVikkZa1zAz9S02OwFN0qh1dg@mail.gmail.com> <CAFuPQ1KW3HkxPCDDtzOB+UJWh6KiLSXQc1A_yQyMYrBvnP7VQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Sep 25 09:47:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGPrT-0006SA-4p
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 09:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab2IYHrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 03:47:09 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51799 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab2IYHrI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 03:47:08 -0400
Received: by vcbfo13 with SMTP id fo13so7284750vcb.19
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 00:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=jiwf9ITh2zF0wRyCjR2GbpMk5GV5ICg1cC0OULA2bVg=;
        b=o/b77j+KrbsqbpLVKfmJ67mbJq39gOuOhHVeOo76CVxjytRLEIQ9DuP5abnt5bu5GP
         2OMFq9FBzAy0buRrjP3oF+gBMfKvJgJkIa24PGXdy5UpDaCMpYJ9KWf8bxtwkfeslLXg
         BT0PkdysiKDu8xG/DcJNGdBe5lRVKdC/whRvQeHcD/p4rSLERU1YlIO57ZvNyI0vfRMe
         3OehUooyoEoj0eLC4V64Fy6Q/uQpIwnUYsNvR0iHUyMgb7rRWztQobLBdXZwulClzad8
         qqChr27+CLgWtBtguW1lklq1VIVh1xJ7/fgGHRFOcNSkr0O8aFQiuDWXpJbbp3h1YVe2
         4pRQ==
Received: by 10.58.227.106 with SMTP id rz10mr9195841vec.19.1348559227933;
 Tue, 25 Sep 2012 00:47:07 -0700 (PDT)
Received: by 10.58.19.73 with HTTP; Tue, 25 Sep 2012 00:46:27 -0700 (PDT)
In-Reply-To: <CAFuPQ1KW3HkxPCDDtzOB+UJWh6KiLSXQc1A_yQyMYrBvnP7VQQ@mail.gmail.com>
X-Google-Sender-Auth: aP09AMlhvV_8L-3kH6jMgNesr9k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206354>

2012/9/24 Jonas Fonseca <fonseca@diku.dk>:
>
> If I have understood the problem correctly, you have a keybinding
> mapping 'M' to `git merge %(commit)` or something like that and when
> you type 'M', tig will list the commits in the master branch after
> executing the external command.
>
> I didn't account for this in the patch, and I will have to figure out
> a way to disable the current behavior of reloading the main view after
> executing an external command.

Yes, actually you can test with existing key bindings like cherry pick
(C).  The main view is reloaded with the tip of the current branch, as
if the no-walk option was correctly taken into account, but not the
list of commits in stdin.

Cheers,
-- 
Jean-Baptiste Quenot
