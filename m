From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 19:48:22 -0700
Message-ID: <20131101024821.GB41400@gmail.com>
References: <1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
 <xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
 <CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
 <xmqqob655kqi.fsf@gitster.dls.corp.google.com>
 <ADB546B4-992E-4B54-953E-B721BECD19B2@quendi.de>
 <xmqqzjpp447x.fsf@gitster.dls.corp.google.com>
 <xmqqfvrh41e0.fsf@gitster.dls.corp.google.com>
 <CAMP44s14_GbN0nEm4Eu2Jdb5cO+jVaTVOnDqzwv0GK4_jfD93w@mail.gmail.com>
 <20131031234048.GA41400@gmail.com>
 <CAMP44s0rtJyJTW36iYX-RRu6NcQ1yF0NUUTXQoCUpMkWVg2Zmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 03:48:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vc4mh-0003V4-DL
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 03:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab3KACsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 22:48:23 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:63920 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab3KACsW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 22:48:22 -0400
Received: by mail-pa0-f53.google.com with SMTP id kx10so3439540pab.12
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 19:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UmZn2miKhUO5oGtM4H9Lt4enY4mIlY1BYo8djkxCBqI=;
        b=GX/qJwI7yFoRVTGqHhpWC7qLdug6O0wxv88jBKEwB55Sayg/b4+JUIGXh/QXNCI9m9
         YkTnfsjaa75Sx9Ah4WgPSL8Xo5J6TzlvHNNDkuPzJ9GZ0hcNyMVnSLjaS9a9vwoNtliG
         c7NVh8v7VXNOKNdv+nrlo4iRzEpkgmMUDhRmL4+c7uRooOUdVe5wuJBCI3ho/zjur4Ag
         3TaKQ5GolUCELJY2c77Moj2cuo57ARCOUPJ3mkipN3u1WIAKB75EgXltrBLi15VXjkL5
         hIJFJAAEY6xeh3ohg2io4npzdJmlrgwKpcz9gkibO88JFwk/0uYC5mw6n7S//gimrsmI
         grzA==
X-Received: by 10.68.203.34 with SMTP id kn2mr844364pbc.82.1383274101910;
        Thu, 31 Oct 2013 19:48:21 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id qn1sm7396325pbc.34.2013.10.31.19.48.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 31 Oct 2013 19:48:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0rtJyJTW36iYX-RRu6NcQ1yF0NUUTXQoCUpMkWVg2Zmg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237200>

On Thu, Oct 31, 2013 at 07:56:03PM -0600, Felipe Contreras wrote:
> On Thu, Oct 31, 2013 at 5:40 PM, David Aguilar <davvid@gmail.com> wrote:
> > On Thu, Oct 31, 2013 at 03:16:57PM -0600, Felipe Contreras wrote:
> >> On Thu, Oct 31, 2013 at 2:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> > Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> > The other reason the original did not say "origin/master" is because
> >> > this holds true even if you do not have such a remote-tracking
> >> > branch for the master at the origin, but the illustration that shows
> >> > the history after "git pull" finishes spells remotes/origin/master
> >> > out, so I think it would be an improvement to make the two pictures
> >> > consistent by drawing where the origin/master is before this "git
> >> > pull" is run.
> >>
> >> So you care about "reality" when it fits your argument, but not when
> >> it doesn't. Got it.
> >
> > What exactly do these flippant remarks accomplish?
> > Keep these to yourself.  No one deserves this treatment nor does
> > anyone care to read it.
> 
> Nobody is forcing you to read them.

You're missing the *key* point.
No one wants to interact with a rude arrogant loudmouth.

You could have explained this without being sarcastic and annoying.
It does not help your cause.


Sure, these are "subjective" people skills (that don't "matter"
to the code) but this is a social activity.  If your defense is
to whine and say, "well, people on LKML are rude and flippant
all the time!" then that's a lame argument that's not
even true.

Your patch may in fact be a good one, but your anti-discussions
hurt them.  Discussion are good, not an insane attack fest.
What fun is that?  It's soooo lame.

That's all I'm saying.  You can defend it but no one cares.

Anyways, I'm out to have fun at a party with friends.
Try and get out, have fun, and come back when you're not looking
for someone to abuse.
-- 
David
