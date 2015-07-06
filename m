From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 13/23] worktree: introduce "add" command
Date: Mon, 6 Jul 2015 16:24:37 +0700
Message-ID: <CACsJy8D6jye_JqkU0ZfQvxZfK9vspcrVWJvwpmqXyJ=6Q9_SOg@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
 <1435969052-540-14-git-send-email-sunshine@sunshineco.com>
 <CACsJy8A2eB2-t4t4oxvWiTnEFr7jJxcVBnn+zHq4uNNTk3sypg@mail.gmail.com> <CAPig+cSKDUr2GjVqNLKQ7Cb7LooE9bvUzZXEv3cEr3kzyCuSTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 11:25:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC2eH-0006Qf-0g
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 11:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbbGFJZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 05:25:08 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38193 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbbGFJZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 05:25:07 -0400
Received: by igrv9 with SMTP id v9so110679741igr.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XKRylUwJNpfP/vzuI3XNtStoG+bB/6Qw4oW75082v2o=;
        b=TOpSIELzk8bZP37aKUMwzH3Uyvj6fjANF1QAdlgjzNf7mZjADXHPOVhysrAuuBcB5L
         z8OBl0k4Q211v/nI9xHVbCeNdDtBJdyH/oQaeFZ/V9t5CqZo5pGgpypb4AVt18jSKZZO
         jHU+qDbr4+PvDKsAI12Wqx2SCvDlzevCuAVMpz3d2wgC4jf/6EW/M3ZePlL7F/uOe8h/
         zJQxG+y/0HHktT9oJCRW+RE/0+ekIQEUkP3gCFAzK0eUN1BMXXBh6yvQAUObupiPrqf6
         y6hqTTQLspA2/5ytMC1tN9N0wYIWMmdJdpydmqeKPYQCzij1om3rNSwnhu4Fq0SWs1hl
         +6Kg==
X-Received: by 10.107.128.72 with SMTP id b69mr69891082iod.84.1436174706732;
 Mon, 06 Jul 2015 02:25:06 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Mon, 6 Jul 2015 02:24:37 -0700 (PDT)
In-Reply-To: <CAPig+cSKDUr2GjVqNLKQ7Cb7LooE9bvUzZXEv3cEr3kzyCuSTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273379>

On Sat, Jul 4, 2015 at 3:54 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jul 3, 2015 at 10:53 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sat, Jul 4, 2015 at 7:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>  COMMANDS
>>>  --------
>>> +add <path> <branch>::
>>> +
>>> +Check out `<branch>` into a separate working directory, `<path>`, creating
>>> +`<path>` if necessary. The new working directory is linked to the current
>>> +repository, sharing everything except working directory specific files
>>> +such as HEAD, index, etc. If `<path>` already exists, it must be empty.
>>
>> Side note, "must be empty" is an implementation limitation. I think
>> the two-way merge employed by git-checkout can deal with dirty <path>
>> and only perform the checkout if there is no data loss. But we can
>> leave this for later.
>
> Perhaps we should omit the bit about an existing but empty directory
> for now? Like this:
>
>     Create `<path>` and checkout `<branch>` into it. The new working
>     directory is linked to the current repository, sharing everything
>     except working directory specific files such as HEAD, index, etc.

I think either way is ok.
-- 
Duy
