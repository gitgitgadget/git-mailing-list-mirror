From: Rahul Bansal <rahul.bansal@rtcamp.com>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Thu, 18 Jul 2013 21:27:07 +0530
Message-ID: <CADtAFQ=DwTHv3n56xoTEN7JmwT+b3Bv0CdR_nBbyYudgoCmZUA@mail.gmail.com>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com> <CACsJy8CpZHTCr0=MkSpfurPW_fyLGN_zd4uSzvBSYbuqH8aXew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 17:57:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzqaB-0003iw-OG
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 17:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812Ab3GRP53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 11:57:29 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:38246 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757635Ab3GRP52 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 11:57:28 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so7446984iea.32
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 08:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=Fs4wJI3mQJKz3h4sKT591t80DaB9xJnrIkTuPDdUGPk=;
        b=UTJMYUkaMiMGjEEW5TLm8AOFjT2GPmJwZ8omyci2HY6rHxzPY8AkydSJdRcl99yb9W
         ydxWk3zvgDklaWJlri6+h/AfpUUFoEKCEbdn7B4SKEjBLgiEmjENXtlNVgt1DzpBcMUu
         ApW+li1Zact3LS2HXGk5W0vhmFjEBCMKu0wZVy2XXvfUqFfouX0SLfemvtePtZlUnGCh
         uQ5HdtciryWJMjUWNt/0uweudfQgD9t23yB2nH5fSMV1WLbu1eAgYr3mu2gYkibk8V9g
         m5I2IuvK2cFpJazpHdFfHUBnsQMbTR1on5+1Z2rUWu5x4YjHcx4CTOl+0xcWwrRJkk6s
         oUBg==
X-Received: by 10.50.164.167 with SMTP id yr7mr3418589igb.22.1374163047808;
 Thu, 18 Jul 2013 08:57:27 -0700 (PDT)
Received: by 10.64.53.3 with HTTP; Thu, 18 Jul 2013 08:57:07 -0700 (PDT)
In-Reply-To: <CACsJy8CpZHTCr0=MkSpfurPW_fyLGN_zd4uSzvBSYbuqH8aXew@mail.gmail.com>
X-Gm-Message-State: ALoCoQnHSuC8HEOIk7abhyyvHmWhlkfdEbRq5UoMpi/MPCNTmcnRdusAIphxv8vjgstPtTu7AZHU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230697>

Hi Day,

I am aware of that command as well.

I think `git tag` current default order is string-based sorting. I
felt version-number based sorting and/or create-date based sorting
will be more appropriate.

--
Rahul Bansal | Founder & CEO | rtCamp Solutions Pvt. Ltd.
Skype: rahul286 | Twitter: @rahul286 | Web: http://rtcamp.com/


On Thu, Jul 18, 2013 at 9:21 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, Jul 18, 2013 at 10:27 PM, Rahul Bansal <rahul.bansal@rtcamp.com>
> wrote:
> > I am posting here first time, so please excuse me if this is not right
> > place to send something like this.
> >
> > Please check -
> > http://stackoverflow.com/questions/6091306/can-i-make-git-print-x-y-z-style-tag-names-in-a-sensible-order
> >
> > And also - https://github.com/gitlabhq/gitlabhq/issues/4565
> >
> > IMHO "git tag" is expected to show tag-list ordered by versions.
> >
> > It may be case, that people do not follow same version numbering
> > convention. Most people after x.9.x increment major version (that is why
> > they may not be affected because of this)
> >
> > Another option like "git tag --date-asc" can be added which will print
> > tags by creation date. (As long as people do not create backdated tag, this
> > will work).
>
> Try
>
> git for-each-ref --sort=committerdate --format='%(refname:short)'
> refs/tags
> --
> Duy
