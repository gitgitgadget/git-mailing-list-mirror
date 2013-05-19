From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sun, 19 May 2013 14:14:18 -0700
Message-ID: <CAJDDKr7+L1Qa9419aLabvnVPFCeLh0CZR9Vdazd8uk0biZxu1g@mail.gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
	<1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0ke-Ns0JCt6LAzWqympWZ=2x3rRHOjnzB9QN7gc2=ckgw@mail.gmail.com>
	<CAMP44s1xguzX=iavUJxYXBEPOpGvJtJ_7FDHNCWMrF6qxOsuOQ@mail.gmail.com>
	<CALkWK0kz-pQ9UJPXerFoui9ftNXDzD-xhpkSHY=JX3rbFXgp-g@mail.gmail.com>
	<CAMP44s3idD9pen0PyFuHeXQ=uphA8gVfFCEYhEnDRsx-gszbAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 23:14:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeAw5-0001yv-En
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 23:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554Ab3ESVOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 17:14:20 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:49651 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab3ESVOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 17:14:19 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so5036558pab.6
        for <git@vger.kernel.org>; Sun, 19 May 2013 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=WON4OaBqHIuDhktW3t3RuLOhBtOwVtOf7CSr2Y/Pbog=;
        b=gBfXRrGfsb+BsEwyzD65avEyWJyWYQQ3J2tODWNJhzFNcqnb/grhX6g87ZivXqLj5r
         o9TFNUVuMInqyV7M/W+CuQKgosp87lS/1v6hy9ImoW0BCSbeE0LXFMk/VZE0aKUVAeSn
         tK7M4TLt5oqokhuNKzsXnG0DWvLvHbJ0JjzRSBhNqg2b8jNtKcoz9QdjEGuieXEQ7TJS
         B5Na/GCislEs368ekRgEedCyLZl2/sMS1zu+NjfAUdRl1NF/LZlmBl3Ohbe6lLQSivpV
         5M214IsaAIu7BQlLM+1Isk0RbjqZhc0XCiAsAzOXLJ22mO83eW7Eb7k/qK83ZRtkVXOe
         NTBA==
X-Received: by 10.66.233.9 with SMTP id ts9mr58624475pac.15.1368998058779;
 Sun, 19 May 2013 14:14:18 -0700 (PDT)
Received: by 10.70.55.106 with HTTP; Sun, 19 May 2013 14:14:18 -0700 (PDT)
In-Reply-To: <CAMP44s3idD9pen0PyFuHeXQ=uphA8gVfFCEYhEnDRsx-gszbAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224924>

On Sun, May 19, 2013 at 8:41 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, May 19, 2013 at 10:13 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Felipe Contreras wrote:
>>> How exactly is it not equivalent to len = len || 1?
>>
>> Here, I dug up an article for you on the issue:
>>
>> http://www.rubyinside.com/what-rubys-double-pipe-or-equals-really-does-5488.html
>>
>> Although it's fine in this case, I wouldn't recommend using ||=
>> because of the potential confusion.
>
> I don't see the confusion, 'len ||= 1' is *exactly* the same as 'len =
> 1 if not len', which is what I expected.

I spend more time in Python, C*, and Perl then in Ruby, and I was not
confused by this at all.

It behaves just like $foo ||= 1 does in Perl.

In git.git:

$ git grep '||=' | wc -l
     121
--
David
