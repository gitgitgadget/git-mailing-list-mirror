From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 2/5] test-parse-options: print quiet as integer
Date: Wed, 6 Apr 2016 01:56:51 -0400
Message-ID: <CAPig+cTynD42tDe9bQDvKEb7ACFpWwwq85AT8byb8u79G0iVHA@mail.gmail.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<01020153d952be64-9ca893f1-5a7b-4a2c-a0bd-98abf93a17ac-000000@eu-west-1.amazonses.com>
	<CAPig+cQpdr7A7GxKUN3tDs2rQ7z_S5b1WVsk01=BwkCwB2mp0A@mail.gmail.com>
	<CAFZEwPORAer3=WmUqqhztv4kAOHdv+yB12tRyUYh_YTSmtcQsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 07:57:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1angSa-00079n-Jd
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 07:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbcDFF4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 01:56:53 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:35768 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcDFF4w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 01:56:52 -0400
Received: by mail-ig0-f196.google.com with SMTP id ya17so5788160igc.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 22:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=w6kQpGkXDnKyeJYDnW9158mpMs2tsg/MkeVlUAtU8TI=;
        b=tlJLqgW6g7YYHqGP0b68XnGP0b/PnNH4w4Dmtg7qk6ZCMILf5jbLg7Dz830JW5xFjB
         pCDHtbfEOLMkHjV6PUwIeLrBEfNP1EBcByETcZlrCPyrOAJ6wWTWjSWx+uzGONLupBIw
         /IkOqUfvLNUH+pag0E/bkl4mkpDxfGyalXwi3WZY0Ob/2WX9slJ7CjKrjoy9EQ87SNXg
         REd6b+Ngks5bFXa3YCDB9WAGB3QblVmQmQuc7Co8FMpAtUqpDvm8noAA8gF3Ts1r5ejJ
         wx8D0IcQxGsK/3u0UqVES97Xfa1t8lO1pYXZJEdFMyPjGJFWtvDbNBDqO45EIIgpOE9F
         fJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=w6kQpGkXDnKyeJYDnW9158mpMs2tsg/MkeVlUAtU8TI=;
        b=YAlfIaBKmKHaN9lZ3+YghhwxmD2k3MOjOZcuY8QuEQHxEM2LZ6SyIQ0NhMSDrBFTJu
         wyd/NG6jzkIIhB3Omk8cIxar3d7qZvwZILiNLJmR+/7CyUIfGJT7uKczMGup16HpovY9
         b3HswyjciIlX4NOu+xJKcu6EgnMjjcrUqkbnwWaMgOmrvgNKMrbCwciuoshV4dZ7Q5OJ
         8/okZtQdp2e29n5OCJ8lqvl0qQczP9BnnqyXRpGdep85uq9DQti1r6hcKbsVCA3JXq4O
         0bVDI72ixANf0MVPaXhuOWFgIEaYM/4BQYsgqIROA7VI0Bco3jZKSknnvTK0CI62FB+w
         A2vw==
X-Gm-Message-State: AD7BkJLnmyl27i+P7f6xSDzDrGa9c8Geuh3DmRxOsSFiFANH7S4tINQNYbxQY00RpuuO7CNwaTPL3ab7JJRaTg==
X-Received: by 10.50.97.70 with SMTP id dy6mr18924191igb.73.1459922211269;
 Tue, 05 Apr 2016 22:56:51 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Tue, 5 Apr 2016 22:56:51 -0700 (PDT)
In-Reply-To: <CAFZEwPORAer3=WmUqqhztv4kAOHdv+yB12tRyUYh_YTSmtcQsQ@mail.gmail.com>
X-Google-Sender-Auth: -Zzi5kRE060abUsak9tDyWgRLd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290821>

On Tue, Apr 5, 2016 at 11:39 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Mon, Apr 4, 2016 at 3:00 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> Current implementation of parse-options.c treats OPT__QUIET() as integer
>>> and not boolean and thus it is more appropriate to print it as integer
>>> to avoid confusion.
>>
>> I can buy this line of reasoning, however, it would be even easier to
>> sell the change if you cited an existing client (a git command) which
>> actually respects multiple quiet levels. Are there any?
>
> I investigated into this. But I was unable to find any git commit
> which actually respects mulitple quiet levels. I first did a 'git grep
> OPT__QUIET' to find the commands which use this. Then I went through
> the documentation which covers it. None of them have any such mention
> of multiple quiet levels. But still I dug further and and went through
> all the individual source files. I followed the corresponding C source
> code for the header file included and also searched there for any
> trace of quiet. But I still didn't find any such use of multiple quiet
> levels. I have found that the commit id 212c0a6f (Duy Ngyuyen; 7 Dec,
> 2013; parse-options: remove OPT__BOOLEAN). Maybe he has something to
> say as to why this was introduced and OPT__QUIET which previously used
> OPT__BOOLEAN, now uses OPT_COUNTUP rather than OPT_BOOL. This commit
> In fact git-repack command has quiet but this is not mentioned in the
> documentation. If someone could include this it in the documentation.
> I would do it but I am not quite familiar with git-repack and haven't
> really used it anytime.

I didn't find any existing Git command recognizing multiple quiet
levels either, however, I think I can still buy the change considering
that there is existing precedent in other Unix commands.
