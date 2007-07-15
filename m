From: "Satyam Sharma" <satyam.sharma@gmail.com>
Subject: Re: Confusing language in man page
Date: Mon, 16 Jul 2007 02:55:42 +0530
Message-ID: <a781481a0707151425q11e35280rd0118ac9e122c55d@mail.gmail.com>
References: <a781481a0707141108g4664a627w94e0d21c3629cb49@mail.gmail.com>
	 <a781481a0707141327k5b6f8f43sc6330ff8cc504dd1@mail.gmail.com>
	 <20070715094038.GE2568@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 23:25:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IABb9-000121-BY
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 23:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbXGOVZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 17:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbXGOVZo
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 17:25:44 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:6149 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbXGOVZo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 17:25:44 -0400
Received: by nz-out-0506.google.com with SMTP id s18so686565nze
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 14:25:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ecknyP5SwXCK4hJblmvMsiXyzj+W96X3ceEyvnKjIiccIleKsXFXyTRkjnigJ7W6aJkC5ZQ2hpAtLLr8iDcGpZZNMt5B67OT8/VenaxdBfAPMal0r5uUtJtXT9J3sH7IXHcVpgcKZy2vk3UjvCMixMvNsd4yBHvVif5rEOT3K3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a+cSrpjlS3vCy3+9i7+SjsM067KaCzYSJ1oT+Tf7I6hTczlQWmqk6p+udE2xInF+TH/58TWV1vaBlR7pCCR+RiwZTyon/WYK2XI2J9xIg+ZXmWIySMRoAl7YAlI/w/KUyaCvdyeFWrTRDPnv3DiC8kLVGM+s/pixvZ7AXyCdYgU=
Received: by 10.142.155.4 with SMTP id c4mr271260wfe.1184534742999;
        Sun, 15 Jul 2007 14:25:42 -0700 (PDT)
Received: by 10.142.83.19 with HTTP; Sun, 15 Jul 2007 14:25:42 -0700 (PDT)
In-Reply-To: <20070715094038.GE2568@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52586>

On 7/15/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> Satyam Sharma, Sat, Jul 14, 2007 22:27:52 +0200:

Ok, the first two were silly questions I got answered as I got to
know more about git automatically :-)

> > * On my system, doing:
> >
> > $ git diff
> >
> > with no outstanding changes in my current working tree produces some
> > bogus newlines, throwing the prompt to the bottom of the xterm window.
> > This sounds like weird / undesirable behaviour and I have a feeling must
> > already be fixed in latest git (?)
>
> It is not git. It is the program less which git uses. The problem is
> known to the author of less.

As for this one, I sent out a mail to bug-less@ just in case -- it's a weird
and annoying thing.

Thanks!
