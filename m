From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Tue, 7 Jan 2014 22:49:56 +0100
Message-ID: <CAHGBnuND3YEuw7TacH24PB2XP=G3eRniG2n9DEjja5gi9RedBw@mail.gmail.com>
References: <52C5A039.6030408@gmail.com>
	<alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
	<52C5ABDE.1010006@gmail.com>
	<alpine.DEB.1.00.1401022143310.1191@s15462909.onlinehome-server.info>
	<CABPQNSaBbcgpE98j7mChvu6N7QqCG0CEmUgvJRURXLTdUTyFGg@mail.gmail.com>
	<alpine.DEB.1.00.1401071854330.20365@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:50:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0eXD-0004c3-Ju
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbaAGVt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:49:58 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:43489 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbaAGVt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:49:57 -0500
Received: by mail-qa0-f45.google.com with SMTP id j5so966402qaq.4
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 13:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zTEloNzTnePbtwTHnk5dqaryCL83PCTChwX4P3O0AY4=;
        b=vkVdJZ8DJ0275pZLzUb6VoEw78yXPw7XOgDVXgxc8EurXtvhfOvpTWA93jDZjRuoNV
         ry1B4SaWnv2cgl5zafslQgZhAb+wxhKrmPIsOxl6NpJk8N8kFeIPexATnMJFEqbN5KzG
         rCNoqFDV6ehsy3lGDpZ3ABwDobr9MFnFbSM6t/xSrCLDMQObkNwN4xYgd7Z6vOZuRBe9
         NsXOWKJQfO9BrwGFFG3f+Yq+jQPD6IQV07FoC5kq4TrnW81l8fIJFrQZeDjEmBuH08HB
         SIKx+PBjlTYlbJoKmrJMJVafOdLCvXvkNqY9mdJnfe2AXnehZCvwmJ/mFzETzdJKRVdW
         39sA==
X-Received: by 10.224.156.77 with SMTP id v13mr194413955qaw.80.1389131396594;
 Tue, 07 Jan 2014 13:49:56 -0800 (PST)
Received: by 10.96.22.229 with HTTP; Tue, 7 Jan 2014 13:49:56 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1401071854330.20365@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240165>

On Tue, Jan 7, 2014 at 6:56 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>> > Well, you and I both know how easy GitHub's pull request made things
>> > for us as well as for contributors. I really cannot thank Erik enough
>> > for bullying me into using and accepting them.
>>
>> Huh? I don't think you refer to me, because I really dislike them (and I
>> always have IIRC).
>
> Ah yes, I misremembered. You were actually opposed to using them and I
> thought we should be pragmatic to encourage contributions.

Not that it matters too much, but I guess it was me who talked Dscho
into moving to GitHub and using / accepting pull requests :-)

> In any case, I do think that the contributions we got via pull requests
> were in general contributions we would not otherwise have gotten.

I absolutely think so, too.

-- 
Sebastian Schuberth
