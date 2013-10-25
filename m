From: Olivier Revollat <revollat@gmail.com>
Subject: Re: GIT Hooks and security
Date: Sat, 26 Oct 2013 00:25:04 +0200
Message-ID: <CA+nXgrUcpfya+rTPzfRafzJbK1khNqtz-HsaKeGfdA86AepKEg@mail.gmail.com>
References: <CA+nXgrUZk=_wtQ2yQnxwCZ3Mazdz=ZH2FJV+V92PVa0a4+A1hQ@mail.gmail.com>
	<xmqqwql1hub6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 00:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZpol-0001PK-S7
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 00:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab3JYWZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 18:25:08 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:36578 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab3JYWZG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 18:25:06 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so4443026wgg.8
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 15:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7IllI3KI9z0T/Ve03X0hUQ9PWEFFZed9X+7MnKfBP0k=;
        b=md+jVFgmxh0SCWy6fLOhGa1SAV73T/WIqB3beDt9OY4+KKz3TgnkIngiBPT8SHSRMc
         zqyty+/ynwzpngxap8AY5NGXZ28QtQsEZG4q8Y6wCGqPRdO0MW7xqpKf04flHwohSDpL
         a0TJo4PpzSjxN66Gx/AX/coZL0e6FkJ4R0FRn2y4gHjSmcnTECzf/Io5inAzNts2g2p+
         S6FV1ES6zhdPAb3bsih0oErThQXKDtEhKSU8YoIHbHMnNWQh0pg2IjLQ8guxUY21BLE5
         t+nG79mGJt7nkeRlCkGAliDCIA2ajnUmnYsLHnbn7yPnNZboUlvm/jgE7iQq3HqHptUp
         2mDw==
X-Received: by 10.195.13.45 with SMTP id ev13mr9170565wjd.20.1382739904672;
 Fri, 25 Oct 2013 15:25:04 -0700 (PDT)
Received: by 10.216.33.3 with HTTP; Fri, 25 Oct 2013 15:25:04 -0700 (PDT)
In-Reply-To: <xmqqwql1hub6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236721>

But when someone do a "clone" he don't have .git/hooks directory
downloaded to his local computer ? I thought so ...

2013/10/26 Junio C Hamano <gitster@pobox.com>:
> Olivier Revollat <revollat@gmail.com> writes:
>
>> I was wondering : What if I had a "malicious" GIT repository who can
>> "inject" code  via git hooks mechanism : someone clone my repo and
>> some malicious code is executed when a certain GIT hook is triggered
>> (for example on commit ("prepare-commit-msg' hook))
>
> In that somebody else's clone, you will not have _your_ malicious
> hook installed, unless that cloner explicitly does something stupid,
> like copying that malicious hook.



-- 
Mathematics is made of 50 percent formulas, 50 percent proofs, and 50
percent imagination.
