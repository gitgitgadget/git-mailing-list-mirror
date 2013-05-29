From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Wed, 29 May 2013 03:19:12 -0500
Message-ID: <CAMP44s3vkJCr2f2zsZU++j4Wqxuefmpt8BQ9dJoP=JtTB=rgkQ@mail.gmail.com>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
	<1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
	<7vobbv119k.fsf@alter.siamese.dyndns.org>
	<87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
	<51a56bef1b9c2_807b33e1899991@nysa.mail>
	<877giixl4c.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 29 10:19:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhbbi-0000Yx-1y
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 10:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872Ab3E2ITY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 04:19:24 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:55300 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965069Ab3E2ITN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 04:19:13 -0400
Received: by mail-lb0-f182.google.com with SMTP id z5so8534425lbh.41
        for <git@vger.kernel.org>; Wed, 29 May 2013 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lMM3nReOGbJxhMTbuN3YiIDdzcKdP6JEn749+IeRL84=;
        b=Zh67JM3mfnZV8fzZ7gnhJfT/jBYouxgsvDcXV1/D/YXRDihYCjCnrVeY6f0jM5zVhD
         UHqdU0CsaZtroIARMjNslOefKCvIpL3/i7M/8LrfplG+QuXHc9jwOhjZfdvpmJz79OG/
         1CyIOSaem7ha3naou2l3Z7u+eKDsrt7metNtBO25VTCn80r6wsefSH5RnKeOAHCoP2VQ
         bQaImlcVMB8BZkmQ7hMtfRyEp4tkZ48uV7ggxZxTEgV9BW2ZbFyzRJWTQqCtXLsHySJ7
         8VUdHmTDgMOW3EfeUZL1HJOqGWMjjHbMP3cMAh75ZdgU7M7671H3vq8qhXuxLvnCW/km
         8cOg==
X-Received: by 10.112.236.70 with SMTP id us6mr954604lbc.121.1369815552262;
 Wed, 29 May 2013 01:19:12 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 01:19:12 -0700 (PDT)
In-Reply-To: <877giixl4c.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225774>

On Wed, May 29, 2013 at 3:09 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Feel free to implement that. I'm just interested in 'git cherry-pick' being
>> usable for 'git rebase' purposes.
>
> Which would have been obvious to all but the most casual readers, eh?

My motivations are irrelevant, the patch is good as it is.

> We've been over this already:
>
>   The body should provide a meaningful commit message, which:
>
>     . explains the problem the change tries to solve, iow, what is wrong
>       with the current code without the change.

Obvious; there is no support to copy notes.

>     . justifies the way the change solves the problem, iow, why the
>       result with the change is better.

Obvious: because it now actually copies the notes.

>     . alternate solutions considered but discarded, if any.

There are no alternate solutions.

-- 
Felipe Contreras
