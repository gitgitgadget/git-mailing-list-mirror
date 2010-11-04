From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 10:23:28 +0100
Message-ID: <AANLkTimzTzUvoHT9bHve-qvt8V_mvJHmQtgpqY6f_H3u@mail.gmail.com>
References: <1288847836-84882-1-git-send-email-kevin@sb.org>
	<vpq39rhzdht.fsf@bauges.imag.fr>
	<914D7AE3-22D5-4069-B815-2B11A2897BE9@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 10:23:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDw2k-0007kb-7c
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 10:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546Ab0KDJXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 05:23:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35888 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab0KDJXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 05:23:30 -0400
Received: by fxm16 with SMTP id 16so1251192fxm.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 02:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=zj1nA9KmCfaDksny2YaygogBX/gPq3rAoUBAZ+TniXI=;
        b=vAyxlBt5sXsrNZhMJu7xoK+gq679klCxnelHXhzXNYLNSs+/V/SlRBkfrLt0Xk+y2V
         tYkUwVt9zHXhjSKRSup7fPl4Ty9/jHf52uTgdx4+mZU7TV55NtwFGplxxmAW9AMqoFky
         GZfl/ZSBG/nYWcNKWwzZcb+ROuEgpX5t1L+Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=chmsmRHO4oBBnF98sgO00iVUhuq4Y1UqAZNef2FZ8XW9A9UgM/SZSUvtfcIRAFdzRZ
         cxjw0bmU01y0yo2GXt59XIKbTKxJlQ+TefW+8Jd2djOBo2EDv1l0K3GHF8EnV7SmN7y6
         gVbysuCj+UKDAqR6Yi9t/xTtCkVOfzN9orSXA=
Received: by 10.223.115.203 with SMTP id j11mr413142faq.35.1288862608825; Thu,
 04 Nov 2010 02:23:28 -0700 (PDT)
Received: by 10.223.123.203 with HTTP; Thu, 4 Nov 2010 02:23:28 -0700 (PDT)
In-Reply-To: <914D7AE3-22D5-4069-B815-2B11A2897BE9@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160700>

On Thu, Nov 4, 2010 at 09:53, Kevin Ballard <kevin@sb.org> wrote:
> On Nov 4, 2010, at 1:42 AM, Matthieu Moy wrote:
>
>> Kevin Ballard <kevin@sb.org> writes:
>>
>>> Add a new command "shell", which takes an option commit. It simply exits
>>> to the shell with the commit (if given) and a message telling the user how
>>> to resume the rebase.
>>
>> "shell" sounds like you're going to execute something in a shell, not
>> that you're going back to the shell. Looking at the commit message, I
>> thought you had missed the "exec" command and re-implemented it.
>>
>> What about "pause", abbreviated as "p" for the command name?
>
> That sounds like a reasonable suggestion, except "p" is already taken by "pick".
> I suppose this command could simply omit the short version.

I thought "shell" would do exactly what your patch does. And it has
the "s" short version.

So +1 for "shell" from me and -1 for "pause", which *does* confuse me.
I'd expect that
to just sleep for a few seconds.
