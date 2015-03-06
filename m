From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Re: Slow git pushes: sitting 1 minute in pack-objects
Date: Thu, 5 Mar 2015 19:37:43 -0500
Message-ID: <CAH8BJxFF9TMDo=s+omcsMx2qEReHKEXb6snrsuKSQekOhPY+ag@mail.gmail.com>
References: <CAH8BJxH1uVv9J7yLx1D4GRPKfWYqDw8SRFZKGR_yhjcoTCCT2g@mail.gmail.com>
	<CACsJy8CKdcHSNEpRZDTtR36Xcv+SF2tUizNjXd_sAb1eUBgTzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 01:37:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTgGz-0003WM-7M
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 01:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbbCFAhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 19:37:45 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:34804 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbbCFAho (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 19:37:44 -0500
Received: by wesx3 with SMTP id x3so3009394wes.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 16:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=szJf41BiRISfjxKAtORiMiztBi9H2Hfyw2oQM2vjv5Y=;
        b=PNhhVSWlmesVLlMsT29Vry/LabkKOoSj1VLVrMMZ2snFyz/DT8WHTS/e3HCZEbwjFc
         kY/Xf9dQt6OQLtDrBH+mAX8dbsrUV518tSD9j8m63XtU0DE/B+x+0cAtLPRqjURzA/tq
         UpiUHXhCqjvGvrHFPke26OAcE5dsmTQi8ntqhUE9qQHilzz/knu0UyqH8jRMfTSohdC7
         Okn8zptNZHFK2lULlQteRyQyrPpNgjfM+LqKQ8tcrQBCrlfudmG5zAwXjZUwgyuW1BbM
         aFD6EhTy/wuX0+Lcu0UCKII7gKaw+NiHETnZ0H+5ThwU6e/okjvBUV1jdOuJsWrb6Vqn
         y70A==
X-Received: by 10.180.219.102 with SMTP id pn6mr27128054wic.50.1425602263165;
 Thu, 05 Mar 2015 16:37:43 -0800 (PST)
Received: by 10.194.159.98 with HTTP; Thu, 5 Mar 2015 16:37:43 -0800 (PST)
In-Reply-To: <CACsJy8CKdcHSNEpRZDTtR36Xcv+SF2tUizNjXd_sAb1eUBgTzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264883>

8GB of RAM.

Sorry, typo.

Steve


On Thu, Mar 5, 2015 at 7:25 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Mar 6, 2015 at 4:03 AM, Stephen Morton
> <stephen.c.morton@gmail.com> wrote:
>> I'm experiencing very slow git pushes. On the order of 1 minute to push a
>> trivial one-line change. When I set GIT_TRACE=1, I see that it seems to be
>> taking a lot of time in the pack-objects phase.
>>
>> Others are not seeing this with the same repo, but I'm the only one working
>> in a VM.
>>
>> ...
>>
>> Details:
>> git version 2.1.4
>> OS: CentOS 6.6 64-bit in a VM.
>> repo size: huge. 6 GB .git directory, around 800 MB working tree.
>> VM has 8 MB RAM and 8 cores.
>
> Is it 8 GB or MB RAM?
>
>> CPU: i7, 8 core (4 cores hyperthreaded)
> --
> Duy
