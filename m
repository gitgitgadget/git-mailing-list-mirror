From: Thomas Badie <thomas.badie@gmail.com>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 18:57:58 +0200
Message-ID: <CAFjFENp1CzepXLO+eR9A0op6ESRKCTsFLc90e1EKuw1p1A3y5w@mail.gmail.com>
References: <jv5tln$96e$1@dough.gmane.org>
	<alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr>
	<7vipd5s161.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jan Engelhardt <jengelh@inai.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:58:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvtIB-0003zV-PT
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab2G3Q57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 12:57:59 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:37419 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071Ab2G3Q56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 12:57:58 -0400
Received: by qcro28 with SMTP id o28so3112133qcr.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Chse3knVh4WcFPPa5jFfgj91P6Rpxb5RDdJOeLK+fic=;
        b=f2qxFECZuw2pp+f6i6fAdKR6Odah+aj521zhnr9nBfV/5shcK0HodWp0k+E9Rydyxn
         3/be9UdIApdJPAy6X9fVDJ8rZ8y795gQFY2gEb1IADBXECJefW/ec1+w1sHPPg/ydSun
         OuOK0rFUde4bkJK/zZxw0y+4qnY5c8nhNBfJpbGkFaWRsSB92TBrkRhzgYZBFyteT8Y7
         A9EFKfuiML3v0+FNE3wL7oCOW31XLyV7KJtVBheIk4x/uJGYZw8o/8AaTylIljaPw7SM
         sLopeN2iRzQk0I8PMtdKB+I5a+q9d5H7aCAyeuGXtHLnPHtSMGv35hhYfEM36C9Dyj2V
         ySoA==
Received: by 10.224.174.72 with SMTP id s8mr6033995qaz.91.1343667478109; Mon,
 30 Jul 2012 09:57:58 -0700 (PDT)
Received: by 10.224.128.211 with HTTP; Mon, 30 Jul 2012 09:57:58 -0700 (PDT)
In-Reply-To: <7vipd5s161.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202581>

2012/7/30 Junio C Hamano <gitster@pobox.com>:
> Jan Engelhardt <jengelh@inai.de> writes:
>
>> On Monday 2012-07-30 14:11, Thomas Badie wrote:
>>
>>>Hi all,
>>>
>>>When I should fixup or squash a commit, I nearly never
>>>remember how to get the sha1 of the commit I want to fixup.
>>>Because sometimes HEAD~n is not enough, I make `git log`,
>>>copy the sha1 of the right commit and paste it in my git
>>>fixup command. So I wrote a perl script to avoid the usage
>>>of the mouse.
>>
>> If you use screen(1), you can use the keyboard as well; it offers ^A [
>> and ^A ] for copy, and then paste. tmux and all those screen clones
>> probably have something similar. Maybe ratpoison-like WMs do as well.
>> Or, you can use `git log --oneline`, look for the commit and then
>> type the (usually) 6-char part of the hash manually, which may be faster
>> than ^A[, moving the cursor to the copy position, marking it, etc.
>
> Also,
>
>         git show -s ':/^t1100-.*: Fix an interm'
>
> would work well.  It your log messages are not descriptive enough,
> however, that may not, but that is easily fixable by training you
> and your colleages to give a more descriptive title to each commit,
> which will make your project better.

Another aim of this module would be to avoid writing the beginning of
the commit message.

Thanks for your proposition. I didn't know this solution.

-- 
Thomas "Enki" Badie
