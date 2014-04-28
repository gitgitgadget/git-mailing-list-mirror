From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 18:09:45 -0500
Message-ID: <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
 <535D6EB1.9080208@game-point.net>
 <535e18cdc7bce_338911e930c72@nysa.notmuch>
 <87bnvl6bdg.fsf@fencepost.gnu.org>
 <535e8e4253196_45651483310b3@nysa.notmuch>
 <152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 01:20:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuqX-00033C-1L
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 01:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbaD1XUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 19:20:21 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:43657 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbaD1XUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 19:20:20 -0400
Received: by mail-oa0-f54.google.com with SMTP id i7so8178703oag.27
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=x+RdH5gZTMAI3654HgRgPpPnLDrCQZf4hBUiAKk7zfM=;
        b=KZ5MyGYdp/P+k1sOfwmp9D4JJ/ReQkfS931oY2VZG1EkaM2cn7bI3LhJhbAdX+tMmU
         sGGmCsN/6B3+n3s8DB4QLwYk0xZtBVNBUT+E7Lx2B4L/kVMf67kk8WHJJtvTvq1tIRsB
         8nRI+aFlbNxRo2aavpy32+24g0gBjqRjjlaSy1rDoLT5EHFundzDcYi3U7rf1w64kXeA
         TcPAy/zDbe48ePsuj8PKK40wdOTvCnoCqy/mdLDb4OZw7dRq1iWd9LD0cN7hTbxWreVE
         Mnv5DFJXnCf0y7A4UX9739Dg0tLRAsUQHNkRHOeqy+KOuVALHO4/9foMThWzS2kaYL6H
         6tKA==
X-Received: by 10.60.131.40 with SMTP id oj8mr24402831oeb.14.1398727219988;
        Mon, 28 Apr 2014 16:20:19 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ut8sm39852979obc.22.2014.04.28.16.20.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 16:20:18 -0700 (PDT)
In-Reply-To: <152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247493>

James Denholm wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > David Kastrup wrote:
> > > It becomes easier to actually change things when communicating in a less
> > > abrasive and destructive manner.
> >
> > That would make sense if I was the only one with the itch. But I wasn't the
> > only one, so anybody could take the patches and send them in a less
> > abrasive maner.
> 
> It's not anybody else's job to take your patches and drizzle them in the
> honey of respectable discourse.

It's nobody's job to do anything. This a collaborative effort and in a
collaborative effort everbody chimes in to do different things.

It's not Jeff's patches, they are our patches, they are part of the project.
And it's not unusual for multiple people working on a patch series; one person
doing most of the work, another adding tests, another cleaning updocumentation.
It's also no unheard of from a person picking up a patch series somebody else
stopped working on.

If a patch series is event considered to be merged upstream, that means it
doesn't just benefit the person sending it (e.g. me), it benefits all Git
users.

So "my" patches where by the project and for the project.

> > The fact of the matter is that the tone doesn't matter, the patches don't
> > get in because change is not welcome. Period.
> 
> You neglect the possibility that your personal view of what git should
> be differs from other people's.

Except that in this case virtually everyone agreed the default was wrong. I
already said that.

Clarly you didn't read the relevant discussions where everyone, including Linus
Torvalds, agreed. Did you?

-- 
Felipe Contreras
