From: Angus Hammond <angusgh@gmail.com>
Subject: Re: [PATCH] send-email: support coloring dry-run output
Date: Thu, 17 May 2012 15:27:40 +0100
Message-ID: <CAOBOgRaEnFOJ9=ZHczAq_TNerrrMciG8g0SHYDiKrqfhASU-iA@mail.gmail.com>
References: <1337260596-15498-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 16:28:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV1gG-00021Y-Jw
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 16:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760684Ab2EQO1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 10:27:43 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48029 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab2EQO1m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 10:27:42 -0400
Received: by lbbgm6 with SMTP id gm6so1336598lbb.19
        for <git@vger.kernel.org>; Thu, 17 May 2012 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dI11DNd7iuDnKPdvwoILoZJkKvm9nGUwnJp+/o9vc8o=;
        b=avjgzRFu7gSo0+pnkVaoOoPuwIX0kZtGClv2sFTL0jdX4dS5hXvqXtkMFnZvezSCo+
         u+ZCiJH9tD8db59Pmkm3AgLhe1ZrYrAcuiz3yu49RkZIsC4CQKdqsc5OlC75a1v+RySl
         rYywKzfRdYvbEm3XXCfABrUXnr++ZLl99viXkR0n9/TByNVr2LT2thLBMo8HqErKagt7
         /cv3uzjrnm0K1xmGu0dzYas568fiqQBeSB/15kbZCtvigm+V82Gkldxv+JNgFCYvSyNG
         Nf88/qbk3sNEc7SxqGYC/XKcZjuy85cb2m1+1o6PFmhthfFhlnPd2we5lUCahev0inus
         80Sg==
Received: by 10.112.11.38 with SMTP id n6mr3040201lbb.82.1337264860626; Thu,
 17 May 2012 07:27:40 -0700 (PDT)
Received: by 10.114.12.1 with HTTP; Thu, 17 May 2012 07:27:40 -0700 (PDT)
In-Reply-To: <1337260596-15498-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197918>

This seems like it would be a useful patch for those of us using sendmail.
I'll admit I don't know any perl at all, but one bit seems a little
odd to me. Is there a reason you use 3 separate print statements to
deal with the colours on the Sendmail line, but a regex substitution
the second time? I have no idea which would be considered the better
practice but surely we should pick one and be consistent? Unless
there's some difference between the two that I'm missing.
Thanks
Angus
