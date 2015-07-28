From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Log messages beginning # and git rebase -i
Date: Tue, 28 Jul 2015 07:53:55 +0700
Message-ID: <CACsJy8BE8GOj6g-pH7UgQ6sEQk_ZbtgqHkAHQvTkCDJU=2dBYw@mail.gmail.com>
References: <loom.20150727T133256-715@post.gmane.org> <CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ed Avis <eda@waniasset.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 02:54:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJtA5-0006Lx-HG
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 02:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbbG1AyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 20:54:25 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38116 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629AbbG1AyY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 20:54:24 -0400
Received: by iggf3 with SMTP id f3so100542146igg.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 17:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l+/yiJQF8x4AgadKEQ5uR9trUtLQEw62D0+U84rq974=;
        b=Vw2DClBQxYHYZ6KGQfj36JKnY7OVLV7x1Szzpxu/w4XYS3Vxi1jdM35uRe+Ag/ssOx
         nS72bAw7kHrXIbYQcA81/jTc4QNod8zJqZdRGHYOLfWLyuBuUb1G4GbA5zG0r43XKNo4
         WK1okpGZeWQOZQnHu36/5KKT73UJyEKOLOD6emnTs3XyIEpNqMaAYRfkjHe50YAYBqnJ
         L27egOXu6EudZCYQ+IMEkR2wGFd/NuIjo+zfOni8rQgFlA4b9LOwAwEyoPKXetcxDe2r
         qhi5D+zCi122QU3uJvUXUg1OPH65bA4PuOQmdtHFk7q8wGTXBqJO0bOT9L/ORP9Jc37k
         YflQ==
X-Received: by 10.50.142.9 with SMTP id rs9mr1158758igb.17.1438044864334; Mon,
 27 Jul 2015 17:54:24 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 27 Jul 2015 17:53:55 -0700 (PDT)
In-Reply-To: <CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274724>

On Tue, Jul 28, 2015 at 6:25 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jul 27, 2015 at 7:38 AM, Ed Avis <eda@waniasset.com> wrote:
>> git commit will happily let you specify log messages beginning with #.
>> But then on git rebase -i, when squashing some commits, the editing for the
>> combined log message treats lines beginning with # as comments.  This means
>> that if you are not careful the commit message can get lost on rebasing.
>>
>> I suggest that git rebase should add an extra space at the start of existing
>> log message lines which begin with #.  That is a bit of a kludge but it is
>> better than losing them because they got mixed up with comments.
>
> 'git rebase --interactive' respects the core.commentChar configuration
> variable, which you can set to some value other than '#'.

Yeah. I recommend setting it to 'auto' so it will pick an unused
character as separator (most of the time, don't push it too hard)
-- 
Duy
