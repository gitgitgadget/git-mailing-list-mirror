From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Tue, 14 May 2013 16:38:40 -0500
Message-ID: <CAMP44s0CgYs9s1ac1EEqhP8XusScj39zY6CcQyMxSnh6i-V6SA@mail.gmail.com>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<7v1u99lb8w.fsf@alter.siamese.dyndns.org>
	<CAMP44s1rZmo3cQecGmYVMZ7KSq=z3_mfVnAK+so4QL_JfEe_uw@mail.gmail.com>
	<7v8v3hi9ix.fsf@alter.siamese.dyndns.org>
	<CAMP44s2B3bFWXZe0aL_GMXe_56MbhSZXf-65rT364nY3shYwUA@mail.gmail.com>
	<CAMP44s16VD+Rm5J=TXxQB+pKhpzHqoxBXSSwDvi0CVW2u2J=5g@mail.gmail.com>
	<7v4ne5i7lf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 23:38:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcMvm-0005Rg-Tc
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 23:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758550Ab3ENVin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 17:38:43 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:57851 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758419Ab3ENVim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 17:38:42 -0400
Received: by mail-la0-f42.google.com with SMTP id er20so1077391lab.1
        for <git@vger.kernel.org>; Tue, 14 May 2013 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Sw87jNQqp7Ci7vVeHUc8Wma5NrOticG+qM2DECOLUdo=;
        b=i+cfSZVKksfuFb0JsWlUzQ30ph+dDzN63oclnuXiSRoQeuvg24oWfbTqf3+zGuhiKM
         JNMKm5mhV/B4lhWFFdNudXY5qtPu0lBNJP4B2R/mgAGkibTqJn91BwT3xz+l4yy5a2YK
         B7ilXBW70t4+GF1JZUXy1iaqrvh0vBV8G4JgoUXvJz8yRQTmukjyXA9YjLqOH5QSyYU+
         KdmdSJXIN0MttMT3YneaTjz7zdz6Ts3Dspmi/44q6XbSxr3ZF7e1v/nw5vvR1P2WroIw
         W1K6i80J1MEPMF3Pa1bapNXsGFRe5TsxGZitjPD6Eeng2vCDu5G5HXH3F9iitN40QfMV
         SjDg==
X-Received: by 10.112.125.130 with SMTP id mq2mr16047408lbb.103.1368567520895;
 Tue, 14 May 2013 14:38:40 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 14:38:40 -0700 (PDT)
In-Reply-To: <7v4ne5i7lf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224350>

On Tue, May 14, 2013 at 4:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I forgot to mention the main objective of the shared repo feature:
>>
>> + first/
>> * first/second/foo
>> * first/third/foo
>> * first/fourth/foo
>> * first/fifth/foo
>> * first/sixth/foo
>>
>> Since in bazaar branches are repositories, we want to make it possible
>> for remote-bzr users to create a single remote per branch as easily as
>> possible (without having to duplicate huge clones).
>>
>> But as I said, without this patch, they wouldn't be able to use that
>> feature if they cloned with v1.8.2.
>
> So we nuke that and have them clone from scratch?  I am not saying
> that is bad.  I just want us to be honest about the implications
> when including it in the ReleaseNotes.

The user won't have to do a thing, it happens behind the curtain.

And the clone would happen either way, with or without this patch,
because 'hg/origin/master' doesn't exist, the only purpose 'hg/origin'
serves is to block the new feature.

-- 
Felipe Contreras
