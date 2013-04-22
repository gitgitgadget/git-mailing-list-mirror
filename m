From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 01/16] remote-helpers: avoid has_key
Date: Mon, 22 Apr 2013 17:35:48 -0500
Message-ID: <CAMP44s1XaOOnHCCAHL3C=ZQFe6v4vOD+n7mwzFT0nEZAwGfqrg@mail.gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
	<1366667724-567-2-git-send-email-felipe.contreras@gmail.com>
	<7va9oqnqs9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Dusty Phillips <dusty@linux.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUPL7-0006ZO-LJ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973Ab3DVWfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:35:52 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:54909 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab3DVWfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:35:50 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so81970lbd.30
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=k/ssolqMBU6LecjB2eJhL+N0J/fAO8DJ+8M7/XcwMjo=;
        b=T8F/8dHsjbSCrUfIsGtJ/NiJW8gMS7NRkOuc/PA4Ezskmozq/HzRzMKNhhbqTqe7g5
         v0kwm2k7bivATKpifEVyKhsBYNxpJlYcSTJwH+KL++OzQBlxOgp2yHtWSz0ZN6vyse0L
         8fw0nC8C1WAskkIfqctyUZHHHIHrVZ5fLpDRRy1e95x2OSW80tUxpOw7FzwkDiI9AnUC
         wPrSQHSzVPacofqm8CnetWUigCoBBZUMG7hQmmklFWBfSNr2oTqS5oyQY14XLAk+OFe2
         t6w4JVB2fEp8CERi4ciLlneEOY4uSbLi9vsSNeyHC15QLY5RE3CfjWBaCFrrTt8uL/2k
         1l6w==
X-Received: by 10.152.18.164 with SMTP id x4mr14463806lad.38.1366670148780;
 Mon, 22 Apr 2013 15:35:48 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Mon, 22 Apr 2013 15:35:48 -0700 (PDT)
In-Reply-To: <7va9oqnqs9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222122>

On Mon, Apr 22, 2013 at 5:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> From: Dusty Phillips <dusty@linux.ca>
>>
>> It is deprecated.
>>
>> [fc: do the same in remote-bzr]
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> No sign-off by the author?
>
> It does not matter for something so trivial like this that there is
> no other way to write, but it is a good habit you should encourage
> your contributors to acquire, so that you do not have to waste time
> with "please sign off" when their next contribution that is more
> substantial comes.

He is not a contributor, he sent a few patches, and then immediately
started gitifyhg, I haven't heard a word from him.

Still, he was the original author, so...

-- 
Felipe Contreras
