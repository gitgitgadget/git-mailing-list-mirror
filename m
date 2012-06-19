From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git on 64bit windows - state of the art?
Date: Tue, 19 Jun 2012 19:10:02 +1000
Message-ID: <CAH3AnrppdYOC_Z4PWnzNLWXPSSQMBvHd9KPnQyAt40=FTn2dFg@mail.gmail.com>
References: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
	<CAGK7Mr62y4-fTFzuLGmuOd+zLkk+h1Q-rCb30TW3dWd8VLhhAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 11:10:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SguRy-0005iv-2h
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 11:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176Ab2FSJKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 05:10:05 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:42040 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2FSJKD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 05:10:03 -0400
Received: by weyu7 with SMTP id u7so4249322wey.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hy64AuKkf/W2wnNxNFsj5hjgAzvcz5R/UOLtoeWMW1M=;
        b=jvXzSAmaO9kI9iFNnyNvoHi6H828NSlUuA75MknZFkWCBle5yDGvsTB6FtTmi2guWH
         g3+FTC5RktosSjsMCxXnBsOIVhZ8WAgZ6zowzfBZCWKBkwrCkUwrob88LaAsrGhO7Q/Q
         s1k89TE7VIVVMzRS1JPofGmty7uqe4/1jf0HoyBZSUvVQeMZIBTm7B8YyGRSqQ4n5zyU
         qIxRPF+fN98YYd+8wdPWgvoDULJlF7rD/eGRfbL9A81n5B266ek83lx7yxKaoC8eSBhw
         BFOlNkMu0uZFOKcq8/kPd+Ia4EF2uSFL7jEDxkkkquHTp8IaZQTthtwXtrcLXyFNlNAd
         1Pow==
Received: by 10.216.144.228 with SMTP id n78mr9612387wej.26.1340097002252;
 Tue, 19 Jun 2012 02:10:02 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Tue, 19 Jun 2012 02:10:02 -0700 (PDT)
In-Reply-To: <CAGK7Mr62y4-fTFzuLGmuOd+zLkk+h1Q-rCb30TW3dWd8VLhhAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200187>

On Tue, Jun 19, 2012 at 6:59 PM, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
>> I was wondering what the state of the art for running git on 64 bit Windows is?
>
> Did they try msysgit? In my experience it has way less issues than cygwin.
>
> Philippe

Erik and Philippe,

Thanks for the quick responses. I'll take cygwin out of the picture
completely and see if that improves things.

I was hoping to use cygwin because I don't like the (understandable)
limitations of the msysgit toolset (restricted set of available tools,
invoking bat files is painful, symbolic links don't work the same way,
etc)

jon.
