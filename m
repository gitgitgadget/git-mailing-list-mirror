From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v2 05/19] am: split out mbox/maildir patches with git-mailsplit
Date: Mon, 15 Jun 2015 18:08:22 +0800
Message-ID: <CACRoPnQ5=wYv8S8ZoijNK9-XwQQTwC_fVKZNYFVMpPFMCAnWjw@mail.gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
	<1434018125-31804-6-git-send-email-pyokagan@gmail.com>
	<CAGZ79kYUK=UhfR1CQREH9GLNuo_7=AmcGwMw15_f_zYFZLarsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 12:08:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4RJd-0004UA-Sb
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 12:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbbFOKI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 06:08:26 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33627 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbbFOKIY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 06:08:24 -0400
Received: by lblr1 with SMTP id r1so23752743lbl.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 03:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SKSYVioBkn/N+jL+dcsX0nMntyy+PWMszcluBFYZzk4=;
        b=uzFsqd2lzISdWwJ4SWR1P5FcWMoKcHSQ24HjnW+NYXHpoMIXLs+3FJuGk8DVdfP0/U
         gztWD1uzq9oR+2O3KFFFgfZACKUwrEcsoYUyLhJiEgvy7fEi6DnxX3LZQ/vOdGdn1WWB
         eSfN9l5oJB8KxiBNJ9JFMqf1JkD6593jA3RcCisBoa/z45RgwD92epVcdWY27fBeva9l
         MX2TbUyyDSfRy3OXFnbkeRrXqEOgNLSFWzJhkvSRgoWFmt1+oAIo+JZFtizvqNoLD534
         tWqygHUx69od6tMZIg+uXLAz7c829WpCLkhIAR21MzCmHziVjO6ww1o4F9uCdb2uz/uM
         03mA==
X-Received: by 10.152.87.13 with SMTP id t13mr26719387laz.66.1434362902554;
 Mon, 15 Jun 2015 03:08:22 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Mon, 15 Jun 2015 03:08:22 -0700 (PDT)
In-Reply-To: <CAGZ79kYUK=UhfR1CQREH9GLNuo_7=AmcGwMw15_f_zYFZLarsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271669>

On Fri, Jun 12, 2015 at 1:45 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jun 11, 2015 at 3:21 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> @@ -138,13 +202,33 @@ static void am_next(struct am_state *state)
>>   */
>>  static void am_run(struct am_state *state)
>>  {
>> -       while (state->cur <= state->last)
>> +       while (state->cur <= state->last) {
>> +
>> +               /* TODO: Patch application not implemented yet */
>> +
>>                 am_next(state);
>> +       }
>
> When reviewing the previous patch I did look at this loop for awhile confused,
> if you want to apply patches in am_next(state) and thought there might be
> a better approach.
>
> Maybe you want to move this chunk with the TODO into the previous patch,
> so it's clear after reading the documentation of am_run, that the actual am is
> missing there.

Ah right, this is a mistake. This comment should be in the previous patch.

Thanks,
Paul
