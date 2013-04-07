From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] format-patch: add format.cover-letter configuration
Date: Sun, 7 Apr 2013 11:43:07 -0500
Message-ID: <CAMP44s1bU4RE+h49JDgoG47O8ySv2b115wubgN1t68A_ObNW4g@mail.gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
	<1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
	<7v4nfi92q1.fsf@alter.siamese.dyndns.org>
	<CAMP44s0rsWCZE=MyW3zuBoVM5ZtEGQQb+deQJB5-i6tBzFdTfw@mail.gmail.com>
	<7vmwta7lx3.fsf@alter.siamese.dyndns.org>
	<CAMP44s1pMLzkQrE1iKmYyj_FOZqkUp46HRQ6kjWfNvOYA5FkVQ@mail.gmail.com>
	<vpqwqsefl9b.fsf@grenoble-inp.fr>
	<CAMP44s2TvC9Ek51GyhPqtv7b-w8u8kr=tQsmdWEVGOycb6MEqA@mail.gmail.com>
	<vpqbo9qfh1y.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Apr 07 18:43:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOsga-0001up-U4
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 18:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934078Ab3DGQnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 12:43:10 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:47175 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934072Ab3DGQnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 12:43:09 -0400
Received: by mail-la0-f50.google.com with SMTP id el20so195405lab.9
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=z0vqXzYkOQoM62lRBxnC5Wn5oPRgDZZukQoYfSJ91Uo=;
        b=T3Fz6DcfxRiHS8moD1EWIlM/kR8qdcYamSbyy6fJLS7ujCWfYKUZRyQaZ/HxUiE/nb
         O22eDFgSXtXHrvzKRGTt1rXENwoMzPcHJpGzxZIOzzAmsLEVecHzaPHUo2w1kDPeg0Jo
         AHeabKKhTlZROhmbcltBYezTQA4dVrOu5p7OC3KmngT0uye2Hz78rUX6r45Q/e6ChAOq
         MwfE9uh7NoRDJBUQ5dith1TVw2y4prwK5aRM1lbpxXTnQN5PPPdSXEkAbeWma0u2iIQ3
         i4GW3EOLQPdPrYlU83rT4a/KGWbkrdJn66n3txpGLvLT2wgEiw8sGLKVNJnl8Zole585
         hDxA==
X-Received: by 10.112.145.197 with SMTP id sw5mr9685165lbb.91.1365352987707;
 Sun, 07 Apr 2013 09:43:07 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sun, 7 Apr 2013 09:43:07 -0700 (PDT)
In-Reply-To: <vpqbo9qfh1y.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220327>

On Sun, Apr 7, 2013 at 11:20 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Apr 7, 2013 at 9:50 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> So, I'm a user that does 'git format-patch --cover-letter=auto origin'
>>>> so I don't have the format.coverletter=auto configuration. Why? Why am
>>>> I not setting that configuration, and why am I running
>>>> --cover-letter=auto?
>>>
>>> The command may well be ran from a script or alias.
>>
>> Wouldn't this work for both cases?
>>
>> % git -c format.coverletter=auto format-patch
>
> Then, what's the point in having a --cover-letter option?

It's useful in the opposite cases: when the command *not* run from a
script, or an alias.

-- 
Felipe Contreras
