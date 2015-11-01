From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v6] checkout: add --progress option
Date: Sun, 1 Nov 2015 15:12:10 -0600
Message-ID: <CAOc6etagi4C-9J-zS9z0YtvebQDOpyGMVWXi31uFT73gN7YHWg@mail.gmail.com>
References: <1446409674-17951-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cS1ajnRUiS7JXZ-jvtZV9k0hdnY7+R0nTnQU+kMk_zAqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 22:12:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zszve-0005Jj-DK
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 22:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbbKAVMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 16:12:12 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35665 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbbKAVML (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 16:12:11 -0500
Received: by pasz6 with SMTP id z6so126109006pas.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 13:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DwsEoI4EWSb6xXWPb6QVz8+AamQkeinZiyd0xrPCZ04=;
        b=nZ+sdEGzVD7ADtylCanqVwP1KJAlhM4uWDSIDZdHjxUre1Sg2knx0m/M/4qn28Fwcj
         uYCoPuYfudtbDxEfrYG09+05PDa+yhzttinvUOtaSPDCtBCooKh2mYsoYSyeEivWgaE2
         ylEmbnam/aqZdiJF9kZKi2kieo3YKZkVFeiX3KdXl7hd0s9NvdosPw0ysoDZvjBMZI0e
         kz/gWaq1Vczzn59MWnwisrwbZUTPurQyQnM4yHfjy/f/Y6anzT4JiU+1XLp+nz/9l6DP
         3StxZ1JDoLhiW7I7m4fC4soEwguTUOAO4QJXDih4nsiPgKiW8gDB7P63sBVnWKfF1CN8
         cdjA==
X-Received: by 10.66.55.42 with SMTP id o10mr22738031pap.124.1446412330989;
 Sun, 01 Nov 2015 13:12:10 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Sun, 1 Nov 2015 13:12:10 -0800 (PST)
In-Reply-To: <CAPig+cS1ajnRUiS7JXZ-jvtZV9k0hdnY7+R0nTnQU+kMk_zAqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280669>

On Sun, Nov 1, 2015 at 3:06 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +--[no-]progress::
>> +       Progress status is reported on the standard error stream
>> +       by default when it is attached to a terminal, unless --quiet
>> +       is specified. This flag enables progress reporting even if not
>> +       attached to a terminal, regardless of -q.
>
> The mix of -q and --quiet is inconsistent and potentially confusing. I
> suspect that your intention was to hint that they are equivalent,
> however, the reader who is not familiar with -q as an alias of --quiet
> may now be forced to look up both options, rather than just one, only
> to discover that they are the same, thus potentially requiring extra
> effort. It probably would be better to consistently use --quiet.
>
> Also, quoting with backticks is recommended: `--quite`
>
> The rest of the patch looks good.

Good! Going for v7.
