From: Woody Wu <narkewoody@gmail.com>
Subject: Re: Off-line deverloper workflow?
Date: Thu, 27 Jun 2013 21:37:32 +0800
Message-ID: <20130627133732.GA5047@zuhnb712>
References: <20130627124656.GA2620@zuhnb712>
 <20130627080605.067af4ae@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 15:37:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsCOD-0005jX-GM
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 15:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab3F0Nh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 09:37:29 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:52395 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab3F0Nh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 09:37:28 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so1070957pad.9
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 06:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hqJiCkfUjQBd833ZLKvmsW1hHuYanRi6oUX+9p3YvYA=;
        b=Vc9ib18Q9coqgTp9/yRX01xFhPmXUpcpN/M6PqPb0gUjD1v3SptxgSXgMIHFPyEz8A
         eV9g79mNpbHQlKUS7MWfM1Y69CwppGzEjTkHzY5pdMIu1njzdxIAfaz+U7vYAS3FUyoe
         90Q39qmyI/u6ydExtYdIkGU4oE3pHJHSO7Zs9g9zxxe4wZmtRVHr2fkzlCsxcLaFXyzU
         RPfEpMh7O25yLnPiNH+qJuSy9/RE0Q4acjmhbkDXqxK6u7F8xUdWFm4UzCZ+eeizwWIO
         97l8haEdTR7WJ+sdMbUJHqZG+MMBkGyTOSSU3zPmsUOz3WTCJ4Ljc+VtXTRfU+wXPM07
         XYHw==
X-Received: by 10.66.246.194 with SMTP id xy2mr6137838pac.131.1372340248461;
        Thu, 27 Jun 2013 06:37:28 -0700 (PDT)
Received: from localhost ([119.120.31.222])
        by mx.google.com with ESMTPSA id sq5sm3845528pab.11.2013.06.27.06.37.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 06:37:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130627080605.067af4ae@bigbox.christie.dr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229102>

On Thu, Jun 27, 2013 at 08:06:05AM -0500, Tim Chase wrote:
> On 2013-06-27 20:46, Woody Wu wrote:
> > I have a colleague who has to left our office for three month, but
> > still need to work on the project which is hosted on our in-office
> > git repository. Problem is that our company has firewall, it's not
> > possible or not allowed to access the company LAN outside the
> > building.  So I want to ask you expert, can you suggest a best
> > practice of git workflow that suitable to my situation?
> 
> It would help to know a little more about the information flow and
> the starting conditions.
> 
> - Was a clone of code made before leaving your office or does your
>   colleague need to obtain the initial copy too?

Yes, he had a clone already.

> 
> - How securely do you need to transfer matters?  (email?  shared
>   external service like Dropbox/Box.com/etc)

I prefer email.

> 
> - How frequently do updates need to be made?
> 

Maybe once several days.

> - In which direction do commits flow?  Just from your colleague back
>   to the office, or are there other updates happening in the office
>   that your colleague needs to pull down to keep in sync?

Bi-direction, means my colleague and my in-house team need to modify the
code.

> 
> Without such answers, it's a little hard to suggest more than
> transmitting either patch files or bundles using any of the following:
> email, a shared cloud drive, a shared host out accessible on the net,
> or sneakernet media (flash-drive or CD/DVD, perhaps via the postal
> system), or possibly other means.
> 
> You may want to read more at
> 
>   git help format-patch
>   git help am
>   git help bundle
> 
> -tkc
> 
> 
> 
> 

-- 
I can't go back to yesterday - because I was a different person then
