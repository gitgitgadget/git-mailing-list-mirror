From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 01/11] Add new git-related helper to contrib
Date: Fri, 26 Apr 2013 18:23:33 -0500
Message-ID: <CAMP44s0XnEJWjzU-g=Gq2jJQu-9MJ8S84fAd-7bdomKWEeTCtw@mail.gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
	<1366919983-27521-2-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0nvWvicFAJEqe0jC+zT3ZvA=Qx3MWXK36zYb2-uYV-aA@mail.gmail.com>
	<7vhaisvqvl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 01:23:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVrzQ-0008F5-DR
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 01:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab3DZXXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 19:23:36 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:42491 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab3DZXXf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 19:23:35 -0400
Received: by mail-lb0-f169.google.com with SMTP id p10so329186lbi.0
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=17v6p3a6Y+0D71qbYf/zlH6BPxuzjw1kpsPNPOqHlnc=;
        b=yOfHtFjF+dVVjCU+I72bVyVLuhSr59kZ284p3rpFcMHa73OP5yWUmStk9bm3UYz9TJ
         c64IyrhCOZ8ABosJBmMvKPyIaXWa2dsZQOsjm1rSbIdG1WpsbZ9rOJ1P6orLTDikzrGA
         HbxgHNad2URVAFnXwI2wjx/PU5jtF9jU5Fs8xTQ8BwCx8JFptLzITZzqs6Zqtkx0Kioz
         RRWhi7+WhxFjUL65txb6V6FgGfrcYFTwUJz2qMlsO/Hd8kTMZqVLMZwFfByaver6ICmh
         LXtCAcWBBwXVXvA+yvjQUEpEmjy4KMFIrDFeswLoWMjbnStUDq1gkszk8V0zE0WamgWx
         RhUg==
X-Received: by 10.112.140.100 with SMTP id rf4mr13929221lbb.82.1367018614047;
 Fri, 26 Apr 2013 16:23:34 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 16:23:33 -0700 (PDT)
In-Reply-To: <7vhaisvqvl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222605>

On Fri, Apr 26, 2013 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Apr 25, 2013 at 2:59 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> This script find people that might be interested in a patch, by going
>>> back through the history for each single hunk modified, and finding
>>> people that reviewed, acknowledge, signed, or authored the code the
>>> patch is modifying.
>>>
>>> It does this by running 'git blame' incrementally on each hunk, and then
>>> parsing the commit message. After gathering all the relevant people, it
>>> groups them to show what exactly was their role when the participated in
>>> the development of the relevant commit, and on how many relevant commits
>>> they participated. They are only displayed if they pass a minimum
>>> threshold of participation.
>>
>> Is this patch still not understandable?
>
> Among the people who review patches here and give usable feedback,
> earlier this week Peff said he is away from his mailbox for the rest
> of the week, and I am not reviewing any new topics that are not in
> 'next', being busy in preparation for -rc0, so I wouldn't be able to
> answer that question.
>
> I do not know about the others, but it is understandable from time
> to time there is a period a series is not being reviewed by anybody.

That's fine, I was mostly asking Ramkumar who earlier argued earlier
versions of this patch were not understandable.

Cheers.

-- 
Felipe Contreras
