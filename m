From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Add Code Compare v2.80.4 as a merge / diff tool for Windows
Date: Thu, 9 Aug 2012 21:39:35 -0700
Message-ID: <CAJDDKr7uHXajcy-jLrg7PToh6cFH3wVYvuX8E7_tq+s2n+b+LA@mail.gmail.com>
References: <5022CC90.3060108@gmail.com>
	<7v1ujhrs7e.fsf@alter.siamese.dyndns.org>
	<CAHGBnuOaze=opbK+hH2s92enHuN2NUuKOVsTY4ZKgc3aWsX2-g@mail.gmail.com>
	<7vipcsoxwa.fsf@alter.siamese.dyndns.org>
	<CAHGBnuPT+ULpPtO_QxqUY8qxfbRT==fACQdM+TG2CyhbcKM-_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 06:39:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szh0h-0004Nt-3t
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 06:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab2HJEjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 00:39:37 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62108 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab2HJEjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 00:39:36 -0400
Received: by vcbfk26 with SMTP id fk26so1186012vcb.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 21:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0C/QjyjuZ1ydjYRuIYOD8Q1310LTTprmn9Iq57BOh6I=;
        b=ZYyg3Hdw7Zq75u08zwGmgTXWpdTt49m7LE5fhc/+hGFcdnjS+Jz8juNHKd8yASIFHZ
         JNEP1jX0Wa/e6IHhC7ihrvSOJavo8xFoZIgUzovzK0t1jH5tInPqPLxQSPzWX/nmmCwz
         JSsz9IZoNJAqRSe3YRZow0tq9meGeLnkPBElsQAY8Dj0fEyNyFirUqK4cTJ+jqOw7UW7
         WwxZY2csckrMqFyl/Uu6yJDiVR691k0FilsZkmB7HcrA0p7Dtv/KJyXq2JxuWGCvDrAD
         u+iFYksTes7OPxPAO7qQiYuJr7yLJFhO5/9PmBebS+fjLMYcu+hZYWDbcAYx20JmhHWB
         61sw==
Received: by 10.220.220.76 with SMTP id hx12mr1488500vcb.9.1344573575564; Thu,
 09 Aug 2012 21:39:35 -0700 (PDT)
Received: by 10.59.9.36 with HTTP; Thu, 9 Aug 2012 21:39:35 -0700 (PDT)
In-Reply-To: <CAHGBnuPT+ULpPtO_QxqUY8qxfbRT==fACQdM+TG2CyhbcKM-_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203200>

On Thu, Aug 9, 2012 at 9:22 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Thu, Aug 9, 2012 at 6:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> I still agree that not listing all mergetools in multiple places is a
>>> good thing. But doing the whole stuff of extending --tool-help for
>>> git-mergetool and git-difftool to return a simple list that can be
>>> used in git-completion.bash etc. IMHO is a separate topic and out of
>>> scope of this patch.
>>
>> Exactly.  If you know that is the long term direction, I would have
>> preferred you _not_ to touch any existing descriptions of the tools
>> (not even changing them to refer to "--tool-help") in this patch, in
>> order to avoid unnecessary conflicts with the topic of unifying the
>> list of tool backends, which can be written and cooked separately.
>
> To the the best of my knowledge there currently no such topic
> underway, and even if it was, it would be unclear how long it would
> take for integration. If I was not touching the existing descriptions
> of the tools, and a Git version was to be released after accepting my
> patch but before the --tool-help topic is merged, that would leave the
> documentation in a wrong state. I was just trying to be consistent by
> also touching the descriptions, which IMHO is the correct thing to do
> in the short term, as you yourself say the topic to make use of
> --tool-help is a long term goal.

Thanks Sebastian.

I think your patch would be good, so long as we leave the descriptions alone.

If you could please re-roll to add the new scriptlet without touching
the docs then that would be very helpful.

I have a separate patch to update the mergetool documentation
for --tool-help which I will send shortly.

I have another topic (--symlinks) in next upon which it is based.
-- 
David
