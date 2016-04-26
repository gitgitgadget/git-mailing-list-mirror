From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/3] githooks.txt: Amend dangerous advice about 'update'
 hook ACL
Date: Tue, 26 Apr 2016 19:39:38 +0200
Message-ID: <CACBZZX4-0OwiSf6wVQJ-ZVZtEOcuRNs_1YkjHvYJzpyx7Q-X9A@mail.gmail.com>
References: <1461529229-15222-1-git-send-email-avarab@gmail.com>
 <1461529229-15222-2-git-send-email-avarab@gmail.com> <CA+P7+xqveyG7RTWb2k8UsFWRwjvM6JJkveRr3NV-bammqSkpkQ@mail.gmail.com>
 <xmqqmvohlexx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:40:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av6xv-0001Pc-MW
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbcDZRj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:39:59 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34578 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbcDZRj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:39:58 -0400
Received: by mail-qk0-f195.google.com with SMTP id i7so1477705qkd.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WKRH3bOOI9ryN4O4eXy2ATZQdEgzlOf6W3x7IQpCi/U=;
        b=Xn0JqLZ0CG/OY3OCPx3qhMfiSwWEYymaHhVxBYNGf7Pbte/rD7s0CLtosR2/HHM+DL
         xqra425o44yqbKXnN+dlYRfC5NFG3Xj4/Fw8/nrCslcvSwO2KTlNO9YSA+H3XHKw9BHu
         vVzuHNmOw1tZeLL/GnVeIQWwpfLBaZaPEimrTONMBU1utukta+cbiDuhiQiCrL4ghoh/
         izEhV7L4Isu6DClicC7HjUOTvI5s43JhD4wjhi8nrlv5CTKscFynjSjvp8Zp/yreaEap
         fR1TzMQF7nR1x15yzIlH5FnOGDvpxZnbisxrggn2u2msP5OwJVrL9UyNtjRkstytgrc2
         4qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WKRH3bOOI9ryN4O4eXy2ATZQdEgzlOf6W3x7IQpCi/U=;
        b=SqTlzmwr5+dfIfT/KqHOEaO88gDGKghdaYGO7lw1TduLD5/OvvL5+APO5WlsXvQqY2
         sO57IMteJ48/SINaWM6NFXVBsw7CTUtqL67GbdjQOEnHS0MR/V+ZwQVHJKwABQngfLDx
         a8nWeeqlNJYaibA5Yxga11+4+YABheXe0Glisau8vkEz10GxNBoXJgTSqUI3+nHi0nVw
         wS6bxk5/YUnssqdB9hU0hf9GUq0VEs3vGxuBowu8313gGRLMBGLZTzmTtiJo2SK0dTVo
         QOzRqDVifZUWKoPX2r422wK9UHMVJRWAUtyh5rSF/9f7NNKlKqiaPiYClapcBWOnQskp
         qhXA==
X-Gm-Message-State: AOPr4FXiCcpUyrwNenWsQhhTdies0VqflQq0yRlV4t4flN0S70jIPVM65ON/C0jRJqKLM6kt/QiVsMjjgCFO9A==
X-Received: by 10.55.161.7 with SMTP id k7mr3773023qke.112.1461692397976; Tue,
 26 Apr 2016 10:39:57 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Tue, 26 Apr 2016 10:39:38 -0700 (PDT)
In-Reply-To: <xmqqmvohlexx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292624>

On Mon, Apr 25, 2016 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>> -Another use suggested on the mailing list is to use this hook to
>>> -implement access control which is finer grained than the one
>>> -based on filesystem group.
>>> +Another use for this hook to implement access control which is finer
>>> +grained than the one based on filesystem group. Note that if the user
>>> +pushing has a normal login shell on the machine receiving the push
>>> +implementing access control like this can be trivially bypassed by
>>> +just using not executing the hook. In those cases consider using
>>
>> "by just using not executing the hook."
>>
>> This grammar doesn't make sense. It doesn't quite match what you said
>> in the commit message either.
>>
>>> +e.g. linkgit:git-shell[1] as the login shell to restrict the user's
>>> +access.
>
> While there is nothing technically wrong in what it says, I wonder
> if it is worth to state the obvious.  If one can bypass update hook,
> one can bypass any other hook, so the information does not even
> belong here.
>
> Instead of saying "acl can be implemented on top of update hook, but
> not quite because you can bypass it", it may be more useful to say
> "in an environment that restricts the users' access only to git
> commands over the wire, this hook can be used to access control
> without relying on filesystem ownership and group membership",
> perhaps?

Will fix to use something closer to that phrasing.
