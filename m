From: Angus Hammond <angusgh@gmail.com>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 16:57:32 +0100
Message-ID: <CAOBOgRab+KSMA_ZsE8z043gm15OkXzuf2a0dF=LeyR+oJvC5mg@mail.gmail.com>
References: <4FE091FB.7020202@desrt.ca> <4FE09C39.50702@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ryan Lortie <desrt@desrt.ca>, git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 17:58:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh0oY-0004z2-OC
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 17:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab2FSP5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 11:57:54 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49290 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab2FSP5y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 11:57:54 -0400
Received: by lbbgm6 with SMTP id gm6so5928647lbb.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rhOulOImwQORNrfnN2hqpWMyBdovJ3vf/X/nywm9qOA=;
        b=dcw+5kqXN3ZHlH5e1J6UBDROTijJG2zfeR22R14lmHv9wB061KTZlYnRD9qkX9N41Q
         px1ffahXkqGNS/jD1za0XaJ797w6zxA0lt1h3NBbA7F8da6YNc5pjJgfh3y2gHtx30A4
         KQGomJaTQaYr7Ec5I3DaiAoYf8qW3vrJ0z63mYl0BJK2ZldU23BSQZzBkjgyQkvLnlrj
         N6tLgVF0b3N1tug33H/Xmya5CVU4ugJDZFO6YhRvXqBB1OwC6RHMa0+AAHdbew7ItVaI
         TsYrS1Ve8l9FkYXvcT6wjWIGiSwRd0hhRWWjHZxdrTpZkU33L7qfAEy/Kz7Wl04ShCZn
         pPYg==
Received: by 10.112.11.38 with SMTP id n6mr8170118lbb.82.1340121472698; Tue,
 19 Jun 2012 08:57:52 -0700 (PDT)
Received: by 10.114.12.1 with HTTP; Tue, 19 Jun 2012 08:57:32 -0700 (PDT)
In-Reply-To: <4FE09C39.50702@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200209>

> This very much violates the distributed nature of Git. Everything
> is allowed, because it's *my* repository.

By the sounds of it everything still would be allowed for a user who
knew that they wanted to create a branch even if it did have a
conflicting name. However (that I can think of) this is not something
you usually want to do, so it's reasonable to assume that when this
happens it's usually user error, so git should tell the user what it
thinks they meant to do and also give them the option to carry on
anyway (probably with a -f flag).

This is (I think) exactly what git already does with local branches.

Thanks
Angus
