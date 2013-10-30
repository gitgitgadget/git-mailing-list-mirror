From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Help creating git alias
Date: Wed, 30 Oct 2013 15:53:05 -0400
Message-ID: <CAPZPVFaDyjxw_vQG_4wo0opw5KEX9sKMJnVNXGUJnCQGnBrB2g@mail.gmail.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
	<CAH5451kcTCYaXK4tqsCkHFNLxE0z8tv=n6h6QS_VkMpnWAsdGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 20:53:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbbpI-0000FC-R7
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 20:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782Ab3J3TxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 15:53:08 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:56022 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab3J3TxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 15:53:07 -0400
Received: by mail-we0-f182.google.com with SMTP id t61so1753323wes.41
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PpJrr4EsuYTCOENhpg8DKvmpGG0+iDno8EivQnzaJys=;
        b=XKKPYlh1AWbDWWpdEvkb6sCc72RjBodYsSevdazXNpeQdIntzdYooLvB+W6qn33WCU
         zDG07j7XI/YwydyZrnUGUSY/oZaljXmq92CDnnNeqHp/2RCJ3E5PXtJPNk78T+GPx8bN
         WOY4w8qLOxoizUvksCwDhk2sno2/9qydtdHaXxK5R4vesYaP0i5wD0GC7zGeknbmFRIa
         lwXOgZXbKpJuPvC2e3wOxqpWpy4Gdbezn3iY8olnxU6SNrJ0JOeac8TbVREnSVdxwK3k
         wGlPyiUMKVZfhKffkLv105rTMqjnDzKDaW5N7VhLxo+wvRmWWhleVuRPpPZxdwFOKz7K
         MHgA==
X-Received: by 10.180.149.179 with SMTP id ub19mr3575291wib.43.1383162785984;
 Wed, 30 Oct 2013 12:53:05 -0700 (PDT)
Received: by 10.216.123.145 with HTTP; Wed, 30 Oct 2013 12:53:05 -0700 (PDT)
In-Reply-To: <CAH5451kcTCYaXK4tqsCkHFNLxE0z8tv=n6h6QS_VkMpnWAsdGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237063>

On Wed, Oct 30, 2013 at 3:47 PM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> Have you tried backslash escaping the backslash? double escaping?
>
> I don't know how many are required, but I would try first \S, then
> \\S, then \\\\S, etc
> Regards,
>
> Andrew Ardill

When i do that it stops understanding \S* as regexp so it removes only
"@", while i need to remove from @ to the next whitespace

Thanks,
Eugene



>
> On 30 October 2013 12:34, Eugene Sajine <euguess@gmail.com> wrote:
>> Hi,
>>
>> I need some advice about creating the git command alias:
>>
>> I have this as the command:
>>
>> git log --pretty=format:"%h %ad %ae %s" --date=short | sed 's/@\S*//g'
>>
>>
>> The purpose is to cut off the email domain and keep only username.
>>
>> I'm trying to create this as the alias:
>>
>>
>> lg = !sh -c 'git log --pretty=format:"%h %ad %ae %s" --date=short |
>> sed 's/@\S*//g'' -
>>
>> but it complains about the \S and i'm failing to come up with the
>> escape sequence to make it work right.
>>
>> I know i can work around that by creating shell alias, but it is not
>> what i would like to have.
>>
>> Any ideas?
>>
>> Thanks!
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
