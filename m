From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Tue, 14 May 2013 17:43:23 -0500
Message-ID: <CAMP44s0+nFHB56tdpCCbjurKhmaNfk39UaWEQBF4V2fb-hcwOQ@mail.gmail.com>
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
	<CAMP44s2L9CsLu+hr4McVzUnb7x+uipEs5nHKLg+69BicMaJjpA@mail.gmail.com>
	<7v7gj1fayr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 00:43:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNwP-0002H0-ED
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758605Ab3ENWnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:43:25 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:65099 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758429Ab3ENWnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:43:24 -0400
Received: by mail-la0-f42.google.com with SMTP id er20so1123959lab.1
        for <git@vger.kernel.org>; Tue, 14 May 2013 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=2cXCAS0Rqw6dBf5W/f3e52Vas8MId32IoSqSwcA1TQQ=;
        b=QY0A2amIBbss+SNpOXR8usj03sRPCWNsz77yGMAa+RaZ4BiSqomcz/0Ur/fARsjzRk
         kLODZsodT4x/r55UD131q8mwv3PzGmBzMQQOe6qrT2KVR11CKLmB9od4+J4s3Sd1t1Tb
         hb2ApZ5SrTf1gpggLS03wqQDnGaVCo6S4Tv75XxbCi6DzmadT7jQY5FIm2UWL4uwN1yU
         rIe+Ce9nJ5D6mKRlHGXq9YmX7J44Y0A1GokeaeAZqrjF7t6Od6P4AxiL8wdUszrvVtJY
         +Y1+DVebyxemFaQfc8ZelK3xbmW/Mgk0eXPD3032rA9oq1dffltkBBbOX694t0BKDjos
         q7UA==
X-Received: by 10.112.145.72 with SMTP id ss8mr16505678lbb.12.1368571403308;
 Tue, 14 May 2013 15:43:23 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 15:43:23 -0700 (PDT)
In-Reply-To: <7v7gj1fayr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224365>

On Tue, May 14, 2013 at 5:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, May 14, 2013 at 5:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>> And the clone would happen either way, with or without this patch,
>>>>> because 'hg/origin/master' doesn't exist, the only purpose 'hg/origin'
>>>>> serves is to block the new feature.
>>>>
>>>> That is the answer I was trying to extract out of you (I take the hg
>>>> is a typo for bzr in the above, though).
>>>
>>> Just to double check, I understand that the justification for
>>> removal is this:
>>>
>>>      If a clone exists with the old organization (v1.8.2) it will prevent the
>>>      new shared repository organization from working, so let's remove this
>>>     -repository, which is not used any more.
>>>     +repository. It is not used by 1.8.3, and did not host any useful
>>>     +information in the code in 1.8.2.
>>
>> That is not true. It did host useful information in 1.8.2, if we apply
>> this and the user tries to pull with remote-bzr from 1.8.2, it would
>> need to be cloned again.
>
> So the answer to my original question:
>
>     So we nuke that and have them clone from scratch?

No, as I already explained the "cloning from scratch" is already
happening with or without this patch.

All this change does is remove a repository that is not used any more
in order to allow a feature that was already introduced, and that's
exactly what the commit message says. It doesn't cause any other
change.

-- 
Felipe Contreras
