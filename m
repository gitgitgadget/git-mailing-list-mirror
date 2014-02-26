From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 10/25] Add new environment variable $GIT_COMMON_DIR
Date: Wed, 26 Feb 2014 12:23:27 -0500
Message-ID: <CAPig+cQdrZE-x1KdCwPWOaer7=Cwze-snNZ3-o+9mS7X1AneaQ@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-11-git-send-email-pclouds@gmail.com>
	<CAPig+cRPpdfNYP=8o+9ku7Lr6bQ3EBiFQcS_aM4YBVhCbuJ3sQ@mail.gmail.com>
	<CACsJy8CSZZptDr6rWTNES1peDrkk5k7Ai9mzQvSBDZz7FGJxLA@mail.gmail.com>
	<6CF0FBAC168D48BA901A31901FAD0C3E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Feb 26 18:23:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIiCi-0003mL-UN
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 18:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbaBZRX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 12:23:28 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:52733 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbaBZRX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 12:23:27 -0500
Received: by mail-yh0-f43.google.com with SMTP id b6so1311724yha.16
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 09:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YydSJO4ExhckQKP/+d2DvtDNEATHb83wK9Au1ANSt9U=;
        b=SrcL0tXq/1L/2ZC4IRe3lgyJSE+XvzlEDVMTW4Mqkdnnwsz13I77935Q924wqiuJ25
         LESWQIBgXRFgVQ9bt6Rh7A73BHV2dAAxgtOG/Bqn11LIS6hRV3P5oEX3A3MZVuR+l6F+
         i4WXeYdghvqlctjMIGfcJ2otHptcDmQl/IJfI5DjFFH4LhSmZzMsiPwgvavOAQB+ku1k
         3hsYgTUnRnwJDTwyjkoaqsVS0x6KRBkBst13EevktdjzDkK1JB4LdSMU8TlnkXk/KD84
         57qkL+iYYEYfE9JZcVhfCaxaDo+XZMJGcn1gBuuPAORBKNATYOi/Q7zY/QbnGiKqc+VV
         TGNA==
X-Received: by 10.236.7.231 with SMTP id 67mr9281819yhp.30.1393435407212; Wed,
 26 Feb 2014 09:23:27 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Wed, 26 Feb 2014 09:23:27 -0800 (PST)
In-Reply-To: <6CF0FBAC168D48BA901A31901FAD0C3E@PhilipOakley>
X-Google-Sender-Auth: 6fctezK6e1hUlNcQlttWzB3HR28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242739>

On Wed, Feb 26, 2014 at 11:12 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Duy Nguyen" <pclouds@gmail.com>
>> On Wed, Feb 26, 2014 at 8:24 AM, Eric Sunshine <sunshine@sunshineco.com>
>> wrote:
>>>>
>>>> +'GIT_COMMON_DIR'::
>>>> +       If this variable is set to a path, non-worktree files that are
>>>> +       normally in $GIT_DIR will be taken from this path
>>>> +       instead. Worktree-specific files such as HEAD or index are
>>>> +       taken from $GIT_DIR. This variable has lower precedence than
>>>> +       other path variables such as GIT_INDEX_FILE,
>>>> +       GIT_OBJECT_DIRECTORY...
>>>
>>> For a person not familiar with "git checkout --to" or its underlying
>>> implementation, this description may be lacking. Such a reader may be
>>> left wondering about GIT_COMMON_DIR's overall purpose, and when and
>>> how it should be used. Perhaps it would make sense to talk a bit about
>>> "git checkout --to" here?
>>
>> I don't want to repeat too much. Maybe mention about "git checkout
>> --to" and point them to git-checkout man page?
>
> I've just looked at both
> https://www.kernel.org/pub/software/scm/git/docs/git-checkout.html and
> http://git-htmldocs.googlecode.com/git/git-checkout.html and neither appear
> to mention the --to option.
>
> Is it missing from the man page? Or is it me that's missing something?

'git checkout --to' is the new feature being introduced by this
25-patch series [1] from Duy (to which we are responding).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/242300
