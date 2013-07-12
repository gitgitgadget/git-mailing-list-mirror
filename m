From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: merging commit history
Date: Fri, 12 Jul 2013 10:11:41 +1000
Message-ID: <CAH5451njL_AQqi0pHMsUvW9iC69Y8sEEwgHr9iCA9FoG=a8E_A@mail.gmail.com>
References: <3186432.VaN86YJOtL@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Stephen & Linda Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Fri Jul 12 02:12:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxQyI-0007M5-Cm
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 02:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab3GLAMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 20:12:22 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:59181 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472Ab3GLAMW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 20:12:22 -0400
Received: by mail-ve0-f171.google.com with SMTP id b10so7759696vea.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 17:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C54wKlQmFwywdhkQzn0n7S/H3r0sxxfYKbPb//e5BAM=;
        b=b5Alcxd+mTB1DDi4jaK0YvvUcB1AIxwUEnXRcJAtAOYuVR7PL5D/HedQPSnm3k7LLA
         PlqY0X5i2nQADt+y1ebbbn0tmfpLi5Q8sUHzVlx/pxjsua4mB7C81QHLTxR3QWFta+hj
         sVOJnUV/KOc5MjPwSdnaXGnuXjcb3ReO+4+XA4yvsdm1HI2ZVNZ7wyaefqRtB+3dYD+c
         lH1F9Vv1Mvl/qcoIWmPMuo8j7oxNEyUAiQRJtOxz+99UxK6zdaUBc7Y7xVVdLy6yLqUq
         eeAvbQHP+1JH1lXp86lyjrKVFRGfbNenpf2BRuT7DH8xAZ+p/8VTo6eF29NhAdOXyrUl
         ifCQ==
X-Received: by 10.58.85.161 with SMTP id i1mr22783934vez.97.1373587941250;
 Thu, 11 Jul 2013 17:12:21 -0700 (PDT)
Received: by 10.220.14.71 with HTTP; Thu, 11 Jul 2013 17:11:41 -0700 (PDT)
In-Reply-To: <3186432.VaN86YJOtL@thunderbird>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230154>

On 12 July 2013 09:43, Stephen & Linda Smith <ischis2@cox.net> wrote:
> I'm working on a project that used to use a proprietary CM system (aka oldCM).   At a point in time, the state of the code was frozen and used as the basis for commits in SVN.
>
> What I would like to to do is take the individal commits from the oldCM and place them into git knowing that the time/date stamps won't match.  Then I want to do whatever is necessary to
> setup git so that I can run "svn rebase" to pull in the commits from the SVN repository.
>
> What is the easy way to do this?


There may be other tools that make this easier, but if I had this
problem I would simply create two repositories, one for oldCM and one
for SVN. I would then merge the two together (as branches with
different roots) and do my rebase from there.

I haven't tried this, and maybe there is something I am missing, but
there shouldn't be too much pain going that way.


Regards,

Andrew Ardill
