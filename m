From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Tue, 14 May 2013 17:17:37 -0500
Message-ID: <CAMP44s2L9CsLu+hr4McVzUnb7x+uipEs5nHKLg+69BicMaJjpA@mail.gmail.com>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<7v1u99lb8w.fsf@alter.siamese.dyndns.org>
	<CAMP44s1rZmo3cQecGmYVMZ7KSq=z3_mfVnAK+so4QL_JfEe_uw@mail.gmail.com>
	<7v8v3hi9ix.fsf@alter.siamese.dyndns.org>
	<CAMP44s2B3bFWXZe0aL_GMXe_56MbhSZXf-65rT364nY3shYwUA@mail.gmail.com>
	<CAMP44s16VD+Rm5J=TXxQB+pKhpzHqoxBXSSwDvi0CVW2u2J=5g@mail.gmail.com>
	<7v4ne5i7lf.fsf@alter.siamese.dyndns.org>
	<CAMP44s0CgYs9s1ac1EEqhP8XusScj39zY6CcQyMxSnh6i-V6SA@mail.gmail.com>
	<7vvc6lfc98.fsf@alter.siamese.dyndns.org>
	<7vk3n1fbus.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 00:17:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNXT-00043U-VV
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758675Ab3ENWRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:17:40 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:63807 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758538Ab3ENWRj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:17:39 -0400
Received: by mail-lb0-f177.google.com with SMTP id 13so1198255lba.36
        for <git@vger.kernel.org>; Tue, 14 May 2013 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=f8GeYYHX0U/9rz8H5EeklRQqmZIqI1p59O+FbO318+o=;
        b=oBB2EWVOWaxOgfrrjBfzgaSJVubMRL8Ir86wSdYKJ8q4J3PyFjExKILoIIqFa5x0Ju
         DoIO6G3ZpG4/RKEGL7fpH7lxJNmYQLtrIyeJ2UJ8o6hj1Nw9X9/+NcBqeSvOJRiQp+/Q
         6RX5in8VJwYiDSv28YwEKcYTqq5HVeVBEvGy5lL7JVyGSVa8FIkdmlxKRnScw5uhg/Dg
         cLi32txxBA6m2+QNAQhAu3qwQjA7Wl1zillnj+6EZyxbBN3iglxsbb/Fxeyy50PT3zP/
         9XX9JROt9t0FEAlw0D70IOPWFj5TEwuARbeA4qNw1kRJLT0OKNC7eb+GzgJWjDJAML+G
         4wFQ==
X-Received: by 10.112.63.169 with SMTP id h9mr1525404lbs.135.1368569857992;
 Tue, 14 May 2013 15:17:37 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 15:17:37 -0700 (PDT)
In-Reply-To: <7vk3n1fbus.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224358>

On Tue, May 14, 2013 at 5:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> And the clone would happen either way, with or without this patch,
>>> because 'hg/origin/master' doesn't exist, the only purpose 'hg/origin'
>>> serves is to block the new feature.
>>
>> That is the answer I was trying to extract out of you (I take the hg
>> is a typo for bzr in the above, though).
>
> Just to double check, I understand that the justification for
> removal is this:
>
>      If a clone exists with the old organization (v1.8.2) it will prevent the
>      new shared repository organization from working, so let's remove this
>     -repository, which is not used any more.
>     +repository. It is not used by 1.8.3, and did not host any useful
>     +information in the code in 1.8.2.

That is not true. It did host useful information in 1.8.2, if we apply
this and the user tries to pull with remote-bzr from 1.8.2, it would
need to be cloned again.

-- 
Felipe Contreras
