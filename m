From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Silly Question About Timing
Date: Thu, 9 Feb 2012 13:10:58 -0800
Message-ID: <CAE1pOi1+FQNoPZ_P-fmFx-YhnUYzMQT=6zh3s-OyT71vcDm=wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 22:11:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvbGj-00081G-7k
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 22:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979Ab2BIVLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 16:11:00 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58815 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab2BIVK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 16:10:59 -0500
Received: by ggnh1 with SMTP id h1so1166158ggn.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 13:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=biqHJwFfdv5RIv75IMBrLoCt4dt9UkWTncACCBb/nlk=;
        b=D/7rkG/7oHWL/rd35u+OUqI/PtB7YrGLBcUBqbAV6qhrTdL3BWFLbA0jnU68KoFrle
         yWC+qDOEju6uEIE+vRBWBYimrPHK1qkk99UKwAQ/tz+t56QMazrV0h1ae9FARqUHnz19
         bEyg8VqYwPHcRperdjcPPRjRQSioNsvLTnwr8=
Received: by 10.101.143.14 with SMTP id v14mr1581404ann.1.1328821858903; Thu,
 09 Feb 2012 13:10:58 -0800 (PST)
Received: by 10.236.73.130 with HTTP; Thu, 9 Feb 2012 13:10:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190323>

Hi all,

This is a bit silly but I'm trying to time how long it takes to enter
a Git controlled directory. I guess this is more of a GNU/Linux
question then anything else.

I've noticed that entering a Git controlled project directory takes
quite some time so I wanted to measure exactly how much (it's the
prompt I'm using that's taking the time, I suspect). I first tried (a
bit naive, I admit :-) )

time cd my-project

This doesn't work of course. Obviously, writing a script doesn't work
either because then the prompt isn't calculated. Next I tried

date +%H:%M:%S.%N ; cd my-project-abc ; date +%H:%M:%S.%N

but, surprisingly (to me), that doesn't work either. It simply prints
the two timestamps and *then* does the cd (or, at least, that's how it
seems to behave).

So how would one do this? :-)

Cheers,
Hilco

P.S. This slow cd is only the first time, afterwards things have been cached.
