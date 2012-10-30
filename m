From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: change symlink
Date: Tue, 30 Oct 2012 22:22:04 +0000
Message-ID: <CAH_OBidmrJsmw1QQ2WONieA1EQmS_Y4WJ8Mu2Mh90tEPU0uWgw@mail.gmail.com>
References: <CAH_OBie-irmpBrJG6KB3W8bgYjQdyVYiUR-SvJPnx1FXUya0uA@mail.gmail.com>
 <m2mwz3odys.fsf@igel.home> <CAH_OBidWxkhG3o4C4OPP4OxyQQfw_fF_h4C9KR9AnoOZ27=9TQ@mail.gmail.com>
 <m2fw4vod81.fsf@igel.home> <CAH_OBifch3uuXYHQ1R9vS6xFu8LuY3mUfiPsHcs3F=HMvnBzyg@mail.gmail.com>
 <m27gq7ochp.fsf@igel.home> <CAH_OBif=Zr-3GO3CE4D6O3wJJZysB6=vvmA37K6ujTHTr-un7w@mail.gmail.com>
 <m2390vobnh.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:22:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTKCn-0007pE-3G
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758220Ab2J3WW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:22:27 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:55556 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab2J3WW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:22:26 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so610062lag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 15:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EKAtVoYk5THBoUp0SJ0bs/P5/LB/8On7/fDJqJelqac=;
        b=DM1EBf5CPM8lDoB0eeJq6aMDiLZK9XyPT7nGA01UC+ARoeuyey0hBxcJpoqrd+a3hp
         yotCR5E6IfiuSuWvGHD498xf3Yq/gbxyGHIuGHGHM+fD7MWdhTNpSrkIUxJZW6n8BKTg
         gl2e7QIL7/29cXAHCh3HQOovkgy/RyajKhuoOsAQT1KwK3w7gRD4qt1h3ZSVT1Uq1kpp
         jhwx8sHRBSRkdk8r753dYrRNA79ToO+rdItitLb6K5xe4K0WPltMQYzrd3S46fBN4nT5
         nAU7pP615naThF+P1UihKMyCwd5kBRVkejoUW6JEP4ZAdGxcoAYw5VwosrN2dZ0cmvqI
         eaXQ==
Received: by 10.152.47.97 with SMTP id c1mr31221545lan.37.1351635744798; Tue,
 30 Oct 2012 15:22:24 -0700 (PDT)
Received: by 10.114.63.42 with HTTP; Tue, 30 Oct 2012 15:22:04 -0700 (PDT)
In-Reply-To: <m2390vobnh.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208760>

On Tue, Oct 30, 2012 at 10:09 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> shawn wilson <ag4ve.us@gmail.com> writes:
>
>> and once it's added, status says:
>> #       renamed:    t2 -> t2/one/test
>>
>> that's not exactly true, but...
>
> What's wrong with it?  Both files have the same contents, which is the
> link target for symlinks.
>

ok, you're right about that (another test where i changed where the
symlink pointed):
#       deleted:    test
#       new file:   test/one/t3


however (what got me started wondering about this and a point i forgot
about) - t2/one/test doesn't show up under 'untracked files' in in
status that scenario. shouldn't it?
