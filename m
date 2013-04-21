From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] prompt: fix tracked files for zsh
Date: Sun, 21 Apr 2013 16:00:49 -0500
Message-ID: <CAMP44s36TO6DQ_3j7rSOoOM6QS-Y0DW_z6WX_GF3ODFfupb6jg@mail.gmail.com>
References: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
	<m2fvyk8fb8.fsf@igel.home>
	<7vli8cuv5j.fsf@alter.siamese.dyndns.org>
	<m2a9or907f.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 23:01:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU1NZ-0001ou-AS
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 23:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab3DUVAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 17:00:52 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:60287 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab3DUVAv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 17:00:51 -0400
Received: by mail-la0-f41.google.com with SMTP id ee20so1046370lab.0
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qk//OJVJfYUeDhN3rxy/9RqNsennZqXb36B2i2Wi3C4=;
        b=fb8ebMgx9sb3mS6mm+q/rgebqFYI9qWi48Ks8oZZuABkToevQNfvUctVpp499S0JWN
         zZ8BSNMf9Qo9JFzLYyCeWxb5UD/0ggXVwuP05FDHIa9neZ4ZQYDu+3hhbipRq2la6uFj
         HP77izeAETa1+fOMBC4U+hP+VKsqfGxNQsHFsp8sThQ3c84H+97MJNktRHGsYmuBCAXb
         QACXpTMF5SozUhhQAIdykH7+l/eS9gvZFlh3KizcqhRFn6KkiosMFeY3hfm/0UMl8/9l
         DPcJvpyhKlBjmC1skvXScN+AWQx33+yxBmgnlwHINYMCgj7tjShYANicRh/nJvUT9Cej
         5hRA==
X-Received: by 10.112.140.100 with SMTP id rf4mr2858070lbb.82.1366578049852;
 Sun, 21 Apr 2013 14:00:49 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sun, 21 Apr 2013 14:00:49 -0700 (PDT)
In-Reply-To: <m2a9or907f.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221968>

On Sun, Apr 21, 2013 at 2:02 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> +                           if [ -n "${ZSH_VERSION-}" ]; then
>>>> +                                   u="%%"
>>>> +                           else
>>>> +                                   u="%"
>>>> +                           fi
>>>
>>> aka u="%${ZSH_VERSION:+%}"
>>
>> Do you need/want a colon there?  Even if it is empty, as long as it
>> is defined we would want this, no?
>
> The original wouldn't.

I thought you were trying to improve the original ;)

-- 
Felipe Contreras
