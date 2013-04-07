From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] format-patch: add format.cover-letter configuration
Date: Sun, 7 Apr 2013 04:11:00 -0500
Message-ID: <CAMP44s1pMLzkQrE1iKmYyj_FOZqkUp46HRQ6kjWfNvOYA5FkVQ@mail.gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
	<1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
	<7v4nfi92q1.fsf@alter.siamese.dyndns.org>
	<CAMP44s0rsWCZE=MyW3zuBoVM5ZtEGQQb+deQJB5-i6tBzFdTfw@mail.gmail.com>
	<7vmwta7lx3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 11:11:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOlcz-0003sC-DA
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 11:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932987Ab3DGJLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 05:11:04 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:42313 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932947Ab3DGJLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 05:11:03 -0400
Received: by mail-la0-f44.google.com with SMTP id fr10so1454613lab.3
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 02:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=5X4Q7qKbnJPM6NG1I/AnkpiVyTiDPIB5HsECU9xtVWM=;
        b=wsn0ESc/+xzPHh2IRA0PZwZy9GN3mKBlBtN3zg+pVF8qLX8vtWSzcytZCZEAYuYgUM
         L4525MPs7EhoHOtX9aNvsCm0uJw9oO1Huzb0gmRUJKMHtd/Sw0pTxlboBgzc0cogsXXE
         HIC4tMzHswvL91zO1MhanaN/+mlhe7kwcLtCY4rFcGSizJbV02xjJ2MEfE1Z30/NFG2N
         yLblV/W8MeoWd+DV1/xXNv5s58w1LD+GKsSj3uJTwDhRQgabe3HTHGEzVDpVplXJNkdx
         t+Fc9jQjK+xvLViN9rNqZ5e+4exS5xtGzTsBCKI5DFAsWXRs477EdNDxjnqVaZRulEyo
         b/Uw==
X-Received: by 10.112.130.201 with SMTP id og9mr9459825lbb.65.1365325861014;
 Sun, 07 Apr 2013 02:11:01 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sun, 7 Apr 2013 02:11:00 -0700 (PDT)
In-Reply-To: <7vmwta7lx3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220303>

On Sun, Apr 7, 2013 at 4:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Users know how to count, if the default is no cover-letter, then doing
>> --cover-letter=auto is basically --cover-letter, unless they don't
>> know how to count and thought --cover-letter=auto would do something.
>> The same is true is they configured coverletter=true.
>
> The user who says "format-patch origin" does not necessarily have to
> count beforehand with "rev-list origin..", so "Users know how to
> count" does not sound like a relevant and convincing argument to me.

So, I'm a user that does 'git format-patch --cover-letter=auto origin'
so I don't have the format.coverletter=auto configuration. Why? Why am
I not setting that configuration, and why am I running
--cover-letter=auto?

The only reason I can think of is that I ran 'git format-patch origin'
and it didn't do what I wanted (or I knew befeorehand).

What other reason could the user possibly have?

-- 
Felipe Contreras
