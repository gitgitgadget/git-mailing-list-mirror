From: Thomas Badie <thomas.badie@gmail.com>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 18:49:21 +0200
Message-ID: <CAFjFENpqC9MVw4Fx_6rgBsLx8p-5_XGh20Wd4SG17OeyDZg6ag@mail.gmail.com>
References: <jv5tln$96e$1@dough.gmane.org>
	<CAMK1S_hhYi=dLrPy2j28=QMi-UDg7ZGXU=t9WqykVmx3XRyswQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:49:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvtAA-0006OU-7T
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887Ab2G3QtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 12:49:23 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:58748 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab2G3QtW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 12:49:22 -0400
Received: by qcro28 with SMTP id o28so3103794qcr.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iROtaGDQs/OKM9iqJMfQsm5COsIw6HZJ7NYYmNu9buI=;
        b=WvjnQmuvhmoenrw39vnakzWd11X3a85hFbFZxGgRNmL2g0jgJoWOxMwozz6VhO7RVo
         8DxOVd5qLDM2II3pIf0dpQOItmRpzOZiE5ILpzwX6cRh/nzbV881kcSzRgvcyAbiD12F
         C4ghgSmXOwtJgz4gmlgzWMu3n3juw2sEUnh6ugpeqJFoPNeoKzFOhIwmS1ktwB3NHK27
         WnT/NZ8utA971wNC6L6QX+03DnY+PYBBftMxi3ZFeWS3L+Qz+8v1nGifGDZe32IHLvKA
         1P42OU813ysJ8WlwUTMe2zOgvgIQDLhwtB/ijhqBL1RAZzKsTtsuA3T+EhM9lN0H66Ea
         LICw==
Received: by 10.224.32.205 with SMTP id e13mr24438052qad.69.1343666961612;
 Mon, 30 Jul 2012 09:49:21 -0700 (PDT)
Received: by 10.224.128.211 with HTTP; Mon, 30 Jul 2012 09:49:21 -0700 (PDT)
In-Reply-To: <CAMK1S_hhYi=dLrPy2j28=QMi-UDg7ZGXU=t9WqykVmx3XRyswQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202578>

2012/7/30 Sitaram Chamarty <sitaramc@gmail.com>:
> On Mon, Jul 30, 2012 at 5:41 PM, Thomas Badie <thomas.badie@gmail.com> wrote:
>> Hi all,
>>
>> When I should fixup or squash a commit, I nearly never
>> remember how to get the sha1 of the commit I want to fixup.
>> Because sometimes HEAD~n is not enough, I make `git log`,
>> copy the sha1 of the right commit and paste it in my git
>> fixup command. So I wrote a perl script to avoid the usage
>> of the mouse. And after discussion with some of my friends,
>> this can be generalized as a generic command line interface
>> tool to get a sha1.
>>
>> The idea is to have a perl module which run through
>> the log history and print 10 shortlog associated with a number
>> from 0 to 9, and a message below "Select commit [| 0, 9 |] or
>> next row ?" or this kind of message with several options.
>
> In general, I prefer nothing to be *interactive*, so I would vote an
> emphatic no.

I can understand this. But maybe this is not the case of everyone. People
on this mailing-list are developers for several years I think, and this kind of
tools may not be helpful for them because they have their own habits. When
I decide to propose this, I mostly think about people who are not allergic to
interactive tools (this allergy is highly understandable, I just say
there is a lot
of taste in the world). So maybe it could be an enhancement for git, maybe not.

> Also, try "tig" and see if you can customise it.  For example, in
> order to create a new commit that is meant to be a fixup of some other
> commit, I 'git add' what is needed (either command line or tig again)
> then hit "m" to the main window, scroll down to the commit concerned,
> and hit "=".
>
> That "=" comes from this line in ~/.tigrc:
>
>     bind    main            =   !git commit --fixup=%(commit)
>
> Please use such methods to keep interactivity where it belongs, is my opinion.

I already heard about "tig" without trying it. I'll try it as soon as possible.
Thanks for your answer.

-- 
Thomas "Enki" Badie
