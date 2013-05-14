From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 00/10] remote-hg: fixes and cleanups
Date: Tue, 14 May 2013 15:08:48 -0500
Message-ID: <CAMP44s3TUNp-rzBVs=xqWyYj2kNSeHMZmaYpOgx0uott3pw8BQ@mail.gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<7vfvxql66j.fsf@alter.siamese.dyndns.org>
	<CAMP44s3D1qTaSWVgNWEDUp7FKK91RxhJozr1LKV6VK95rAQmzA@mail.gmail.com>
	<7vzjvxie12.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 22:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLWo-00060t-Kf
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152Ab3ENUIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:08:50 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:53269 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3ENUIu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:08:50 -0400
Received: by mail-lb0-f179.google.com with SMTP id d10so1088871lbj.10
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qSOHrBPSzyKFMMSs6FG9+ikA7WvUNDrpgL4YgbBYYQ4=;
        b=AWHX2IJ4pHfywbrIwS5c8ggYzsPF5wY/bw1yo5GfJYiuZFSFkjFPYHThTiNSZVqK8y
         Xs/9Co8ifEYvcfceoEGqxVxUbx1MiQw3h59CBTGYXxD2jGH9FV4W9CVg7FbsQIloXAxs
         4qNG297E+kK6QJ0YI1yNdL5wrBev2WAsbkpWBhEj0vR4LJ03oSMairePL0XdDOaNv+Fj
         6JAXNRaz0WWQcr/rvT7FWTGEj7Cd5h9+khUDLLtAhEl500+LpBfSsBBY31rCxlUW2vRA
         05pjkwDUOHfIKXHTPIoo4CKoB6KR7a2CPDKiXbTJucG54Tg8RE32/nggXdZB1vPSVy6o
         zBDg==
X-Received: by 10.112.163.71 with SMTP id yg7mr6633993lbb.8.1368562128759;
 Tue, 14 May 2013 13:08:48 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 13:08:48 -0700 (PDT)
In-Reply-To: <7vzjvxie12.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224332>

On Tue, May 14, 2013 at 1:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Mon, May 13, 2013 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Folks interested in working remote-hg, please try it out, so that we
>>> can have a polished one soon after 1.8.3 ships (I am not saying this
>>> round is not polished---I haven't even looked at the patches).
>>>
>>> And others, please spend time on testing the 1.8.3-rc2 to make sure
>>> what we are going to ship is free of embarrassing regressions.
>>
>> If we want folks to test something, it should be the patches I
>> prepared for 'next' which I just sent.
>
> Yeah, but that is for the release _after_ 1.8.3; I'd rather see
> folks help to make sure we have a solid 1.8.3 relaese.

That's the intention of the ten patches I sent for 1.8.3. But you said
you are not going to put them in 'master', but in 'next', so I sent
the ones I think should go into next.

So now you have the patches that I think should go into 'master' (10),
and the ones for 'next' (47, including the previous unmerged 10).

-- 
Felipe Contreras
