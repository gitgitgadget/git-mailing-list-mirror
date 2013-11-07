From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 06/10] fast-export: add new --refspec option
Date: Wed, 6 Nov 2013 19:00:12 -0600
Message-ID: <CAMP44s2dCFWyaP3tBQ1SZf8222c58JT19o7bQM7+EobN9KJ2jQ@mail.gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-6-git-send-email-felipe.contreras@gmail.com>
	<xmqq61sd70vw.fsf@gitster.dls.corp.google.com>
	<CAMP44s246M5DaeX80tqzfjRWnbE4vKh-vp_tLW-qAQUFFPsP0Q@mail.gmail.com>
	<xmqq38n98cud.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 02:00:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeDxN-0003xu-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 02:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab3KGBAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 20:00:15 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:45574 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab3KGBAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 20:00:14 -0500
Received: by mail-lb0-f173.google.com with SMTP id w7so357611lbi.18
        for <git@vger.kernel.org>; Wed, 06 Nov 2013 17:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/1QIz7ugeZkJWuAoa+BuVhkAe753d/JBp4fYFqmfXrc=;
        b=C2TE6lwMxu65LAhlnj3rEztANnQZsLRdX53HVpmhYuDo4tL9RvHVaMVlYXwdLUUKCE
         KjPt+lnOlPtS9Iruj86y61omncE8TvlDo57yRr++JCnv8XSWgjeTuF9TpfP3p67Es34e
         VX9PR7HhVE6KHDogugOROJRB06biMVydOFEHgUJDZeASr4SbH2J+p/f1DQsUVmaWc6PI
         pjT5vFFSTE8tByLtdlcS2BO7bsqhxfma/T3Vh6FLR7cRsjY7gMwvIKROJ63M7PSTGmyG
         ox+lghXG3Kw7xvy97PuGgfJKTK7qqEbKpJYSheg6ZzZ/+2y6sJRX1BxE9KZaY7tBUc/p
         rzJA==
X-Received: by 10.112.138.164 with SMTP id qr4mr563123lbb.49.1383786013045;
 Wed, 06 Nov 2013 17:00:13 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Wed, 6 Nov 2013 17:00:12 -0800 (PST)
In-Reply-To: <xmqq38n98cud.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237390>

On Wed, Nov 6, 2013 at 3:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Oct 31, 2013 at 12:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> +test_expect_success 'use refspec' '
>>>> +     git fast-export --refspec refs/heads/master:refs/heads/foobar master | \
>>>> +             grep "^commit " | sort | uniq > actual &&
>>>
>>> It feels somewhat redundant that you have to twice say that you are
>>> pushing your "master", once with --refspec and then the branch
>>> name.  Is this the best we can do?
>>
>> As this has been discussed before and no other solution came forward, yes.
>
> We need to take that "no other solution came forward" with a grain
> of salt.  After all, this is your itch, and if nobody was interested
> in helping you (which I think that we both understand entirely
> plausible, given the recent history), it only means you didn't think
> of any other solution.

Thinking is easy, the problem is not thinking of a solution, the
problem is actually doing it. I think we should end world hunger. What
a great idea!

> I didn't think things through, but at the external UI level, I see a
> possibility of a nicer way to express the above.

You already said that before.

Talk is cheap. Show me the code.

-- 
Felipe Contreras
