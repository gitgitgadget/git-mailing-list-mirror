From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 17:01:51 +0530
Message-ID: <CALkWK0nOp_w1LXnN9SoAS9zvhwb5W37csx42KKau5aYCqdwTkQ@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org> <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org> <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
 <8761zm4wzg.fsf@linux-k42r.v.cablecom.net> <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
 <CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
 <CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
 <CALkWK0nji4m0zJPf_s0G5jfWaAN_RTGFZ6dSxfahq2OcRsu5xQ@mail.gmail.com>
 <CAMP44s1RpgM5U0ySsof_sgEHNS1p-seQ=ciVCth9gOJMG0cpHw@mail.gmail.com>
 <CALkWK0krWM4kJ5GTnQ2SL7HoNfNMNA0-xdRVbeatAFpyKW_RtA@mail.gmail.com> <CAMP44s0KW4_Q6-d-3=M7GzWmHwy4H--FcemK4UF5FS0t3wnOgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 13:32:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USn51-0005gt-CE
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 13:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965458Ab3DRLce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 07:32:34 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64535 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936028Ab3DRLcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 07:32:32 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so3116513ied.5
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hLtP/bKfHRDrl2dIY/osyRkHsSXwYEku7fD0/Ru1A58=;
        b=cR3XXnPUTKaCGe22ADO5iYQPD/vrB7xPtyduTA8XWPJ8pDCBFpa3iweU4ztDlU1SXD
         c7pXeWwZ5S8BWDX63EFSdW2oHvJfqDlVdasbn76nX3c8bJYvBy8vVshDhjphsjb7jNdx
         Bf86F6o/rm5FGUb5bKw31Aa8FwChtLFy3GV1RMbHiId4lzYuUaOTPhP0RjHbgtjx+iFl
         P+Oql6z2FpSpCvHJndbm4y3fIgStkBF9sLsi6kUcQiwFIdjRbupc5kyBIP1BOqRFkwkO
         gnWVTqV/MjGv0dcb8jtXrf/emVIbOmE4SpT/Kd68OU3mQmf0VvpS5dXWCXTmcH7EypSD
         80AA==
X-Received: by 10.50.119.102 with SMTP id kt6mr6670844igb.12.1366284751830;
 Thu, 18 Apr 2013 04:32:31 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 18 Apr 2013 04:31:51 -0700 (PDT)
In-Reply-To: <CAMP44s0KW4_Q6-d-3=M7GzWmHwy4H--FcemK4UF5FS0t3wnOgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221651>

Since you disagreed with the rest, I'll only respond to this part:

Felipe Contreras wrote:
> But I won't bother trying to convince you that no project is more
> important than its users (in the words of Linus Torvalds), because
> most people don't see the big picture.

I didn't say otherwise.  What I'm saying is: my personal incentive to
write code does not prioritize the supposed benefit of some unknown
"user" somewhere on the planet above everything else.  My personal
incentive prioritizes me, and my immediate circle (ie. the git
community).  The benefit propagates outwards to extended circles until
it reaches the people I care least about: incidental end-users.
That's how people are connected: how can I care about distant unknown
people I'm not connected to?  The people in the outermost circles
benefit the least, because they didn't get a say in the development.
All they can do is write a rant about it on their blog, and hope that
it gets fixed someday.

You just ditched us, the inner circle of people who care about your
work the most, and are instead trying to convince us that we're
hurting some unknown hypothetical "users" by not merging your code
immediately.

If you think these users are more important to you than we are, then
why are you posting your code on this mailing list?  Start your own
project that's focused on satisfying these users.  It doesn't even
need to be open source or have a community of reviewers, because all
you care about are users.
