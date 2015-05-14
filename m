From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Show all branches and ahead/behind states
Date: Thu, 14 May 2015 12:18:58 -0500
Message-ID: <CAHd499CQTW0J6ms+XYUBbyfT6gGKuiFFCiP57i8-eTwng+UzNQ@mail.gmail.com>
References: <CAHd499AyEDNM7mDstFugD0Ah46=gAS=BRocDmpmOK-1k+qMCmw@mail.gmail.com>
	<1431618938.31573.3.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Thu May 14 19:19:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yswmu-0007cy-FU
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297AbbENRTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:19:03 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36584 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933255AbbENRS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:18:59 -0400
Received: by iepk2 with SMTP id k2so64986850iep.3
        for <git@vger.kernel.org>; Thu, 14 May 2015 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TespSDgmp4PlOemC3JL/fwHhUz0vtjlPqlDtDpMspU0=;
        b=dF3Vi0csVzF5pHf0h4L3TrwYt3YTvhPpPvdgOoUGDAC33+uwPhhkFo2YTwYNeizUEn
         SPI5P4v06Ui0pfB+EKY6DKo3fOAVxML9Lkftq5XD7W8Gk/yQvT+cauHqJWnLAanFbYHM
         Yd0SCKsYR56YMUmAJUkZeAWtKFvPioB5xjcZdxaA3RcvnotyPJzeWkzz6cC+vaT126vy
         Mb0KssSQNRQNbu//8doPkn7PQCKGCnqeJbr3HSvFvAqUjcOS9refMfo8GJpTfXkp9d57
         QjhXauO2PPr1YsW+SLIBbfog224Gkct22UAUzQGCIanG3qDtpaP6XKcUXQrJep8R/W1Z
         +NeA==
X-Received: by 10.42.104.143 with SMTP id r15mr15787088ico.33.1431623938987;
 Thu, 14 May 2015 10:18:58 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Thu, 14 May 2015 10:18:58 -0700 (PDT)
In-Reply-To: <1431618938.31573.3.camel@kaarsemaker.net>
X-Google-Sender-Auth: lws2j3brd8fUcOSvjjpAu5VDHXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269049>

On Thu, May 14, 2015 at 10:55 AM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On do, 2015-05-14 at 09:57 -0500, Robert Dailey wrote:
>> Is there a script or built-in functionality in git 2.4.1 that will
>> allow me to list all local branches with the ahead and behind status
>> of each? Basically the first line of:
>>
>> $ git status -sb
>>
>> But for every branch would be roughly what I'm looking for. Any ideas? Thanks.
>
> git branch -v (or -vv) is what you're after.
> --
> Dennis Kaarsemaker
> www.kaarsemaker.net
>

Nice, I never noticed that -v showed ahead/behind status. Would be
nice if branch had a --format option to customize the coloring of the
"ahead" / "behind" text so that there was more contrast. It's a lot of
information to consume especially with a lot of local branches;
coloring would bring some sanity.

Thanks!
