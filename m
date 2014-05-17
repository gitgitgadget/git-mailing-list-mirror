From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [git-users] worlds slowest git repo- what to do?
Date: Sat, 17 May 2014 08:49:32 +0700
Message-ID: <CACsJy8CmyJbUGAfb7SaAo5aNwOrJ8iwUtxZgQTAANChOsaWCRA@mail.gmail.com>
References: <5374F7C6.5030205@gmail.com> <06A2490FC9BC4461A39B982D3C7C85F7@PhilipOakley>
 <CACsJy8CmiW88tNavRphZa_uMU=jVUCQE6cw5+t2AYnf5dDmcsQ@mail.gmail.com> <537681A4.2070601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git-users@googlegroups.com, Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: John Fisher <fishook2033@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 03:50:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlTlO-0008Se-Ls
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 03:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241AbaEQBuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 21:50:06 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:53573 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbaEQBuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 21:50:05 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so5557817qgd.1
        for <git@vger.kernel.org>; Fri, 16 May 2014 18:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=m5JnQQpd8+a5kNlHEHiuZcNOvP6aPvC3i4TC02vwgr0=;
        b=A0U7cmIBwaJW5DmQXtd+7V+o/i721oiOchnxgB4PDPfE2DQl2w/FzyOvNyaGnW3SHm
         IrJ2/T2dfkiWFLAM64JHiDBG0taaxPm9ihAygd9o8MKDM9emRMbfF2uAeby7Um8VLZbK
         qwxOkbwZOeyGCWF/wRzCOC0tYvyyP0CWMZKAx8Ruc0yXjfCxT0lOYpz3x6uLXId6hgG5
         BMbOAxdU7H6SxktyZ/OLLIz55ThEQTDF9lR9cE3xAgJNNtIMcjGXfKFzHZy7UwvBiiog
         xW/7BRFqPuyh2sFxXt85ACasRtKlWvowixz8Xwlu5YepBBd5Ln4htYif+v48TWxSI+IP
         qSQA==
X-Received: by 10.224.97.69 with SMTP id k5mr28770087qan.8.1400291403977; Fri,
 16 May 2014 18:50:03 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 16 May 2014 18:49:32 -0700 (PDT)
In-Reply-To: <537681A4.2070601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249435>

On Sat, May 17, 2014 at 4:22 AM, John Fisher <fishook2033@gmail.com> wrote:
>> Probably known issues. But some elaboration would be nice (e.g. what operation is slow, how slow, some more detail
>> characteristics of the repo..) in case new problems pop up.
>
> so far I have done add, commit, status, clone - commit and status are slow; add seems to depend on the files involved,
> clone seems to run at network speed.
> I can provide metrics later, see above. email me offline with what you want.

OK "commit -a" should be just as slow as "add", but as-is commit and
status should be fast unless there are lots of files (how many in your
worktree?) or we hit something that makes us look into (large) file
content anyway.
-- 
Duy
