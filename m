From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Tue, 2 Apr 2013 14:27:38 -0600
Message-ID: <CAMP44s1kMrXBgg8tA+1-OtxHV4cqbQ3NfqpRF6AabDWR7fQvRQ@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<7vip44d7x0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:28:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7oP-0003lP-2y
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762243Ab3DBU1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:27:40 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:47997 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761031Ab3DBU1k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:27:40 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so778009lab.21
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 13:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Yc7B3U8CvLw0TXOd4lqh1TMXQgWVocYLew6Go8ESUw0=;
        b=I+L+tO7oVFMc2k85NmitBwaZFq4otk4hhruYdQcxNU3wO1K2RDdtnScTmon2enwmQu
         a2vhunFl6bqaSfu5TlwGuxQJbh5/O6PpbSGJ7qZ0fb9pBM30YVJo5ocox1da/FrMy8XM
         Z4yDQvgZKfevNMpY2/wDfZTn/Xv6XGdsK1JRmby48VPLj1k+d4lC6UooZhEy510KF38l
         a1PaaNyObqdpXBDZF+a/LbYtOKTJv6fA3+PUkc6ZnXRrlm0uOpWbw0XERaDuykfk8qPd
         RbmFIjkMSaxZxg0cuvr46I9ikUNu+MzqtiFaG6sDIlqvNL6eegOvrhohLu2yA9YNDHmN
         I9Gg==
X-Received: by 10.112.143.10 with SMTP id sa10mr4362334lbb.36.1364934458466;
 Tue, 02 Apr 2013 13:27:38 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Tue, 2 Apr 2013 13:27:38 -0700 (PDT)
In-Reply-To: <7vip44d7x0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219880>

On Tue, Apr 2, 2013 at 1:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Here is the next round of patches for remote-hg, some which have been
>> contributed through github.
>
> Thanks.
>
>> Fortunately it seems to be working for the most part, but there are some
>> considerable issues while pushing branches and tags.
>
> Do you have a plan in mind what to do about "some considerable
> issues"?

Yes, they should be fixed now with this series :) I'm still waiting
for the people that reported those issues to confirm, but in my tests
they do work.

> I could push these out to 'master' and let the interested parties
> sort it out---having early access to the code everybody bases his
> effort on would help.
>
> I could queue these on 'pu' and do the same, and wait until you say
> "now it is ready, let's go to 'next'" (and same for 'master').

That might help. However, please drop the patch "don't update
bookmarks unnecessarily", I did not intend to push that one, and I
would like the rest of the patches to be tested before pushing that
one out.

> Or are they meant as "There are issues, but here is a snapshot of
> what I have at this moment.  Hopefully others can help me update it
> by trying it out and discussing, which may lead me to post a reroll
> for application"?

Nah, I think these patches fix the issues, the only question is
whether or not they break something else.

> I'll queue them on 'pu' in the meantime.

Thanks.

-- 
Felipe Contreras
