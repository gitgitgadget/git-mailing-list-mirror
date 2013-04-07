From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] format-patch: add format.cover-letter configuration
Date: Sun, 7 Apr 2013 11:03:15 -0500
Message-ID: <CAMP44s2TvC9Ek51GyhPqtv7b-w8u8kr=tQsmdWEVGOycb6MEqA@mail.gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
	<1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
	<7v4nfi92q1.fsf@alter.siamese.dyndns.org>
	<CAMP44s0rsWCZE=MyW3zuBoVM5ZtEGQQb+deQJB5-i6tBzFdTfw@mail.gmail.com>
	<7vmwta7lx3.fsf@alter.siamese.dyndns.org>
	<CAMP44s1pMLzkQrE1iKmYyj_FOZqkUp46HRQ6kjWfNvOYA5FkVQ@mail.gmail.com>
	<vpqwqsefl9b.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Apr 07 18:03:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOs3w-00030W-7q
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 18:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933962Ab3DGQDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 12:03:17 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:59720 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933953Ab3DGQDR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 12:03:17 -0400
Received: by mail-lb0-f175.google.com with SMTP id o10so4954957lbi.6
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 09:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=elVFNjluer3uk1qTo2V+pNb+6l7dkIMAt7W6wtEeRnA=;
        b=IQ79G3NXgOD0dfiFAiQF+QuC9s6B9+RHR0o+pVBvJblNgi/1oqGQtJGmYsGJrcnFqG
         bHnlaVPXmEYom/xmLFgLRQBOZ1fLlEJEBiHul7xuBPN6UrT5wY+OM59OlmOQP6gTA4nW
         pq1N7/WmJeOkc3lazc5gMwRJucN0hfRQB41qrMPvhL4pyxBER/cAjnjSQbjSR8xhJn6y
         tTbBdaW/Zjg89WDgfyHNyFNDvXNjxelwVTT++jJeugekDphADXIPEWW9ay6K5IdoHFcC
         UqNmJnWBpzoFubjedlANxnDnq1zwikey1Wr0yZe2C7L8UYexlsBWT//sZ4PyYK05c/ff
         mi4A==
X-Received: by 10.152.135.205 with SMTP id pu13mr9969090lab.48.1365350595556;
 Sun, 07 Apr 2013 09:03:15 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sun, 7 Apr 2013 09:03:15 -0700 (PDT)
In-Reply-To: <vpqwqsefl9b.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220321>

On Sun, Apr 7, 2013 at 9:50 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> So, I'm a user that does 'git format-patch --cover-letter=auto origin'
>> so I don't have the format.coverletter=auto configuration. Why? Why am
>> I not setting that configuration, and why am I running
>> --cover-letter=auto?
>
> The command may well be ran from a script or alias.

Wouldn't this work for both cases?

% git -c format.coverletter=auto format-patch

> It is good in
> general to give the user/script writer a simple way to get predictible
> behavior regardless of the configuration.

Predictable means when the user does X, (s)he would know what would be
the outcome. But if the user never does X, it doesn't matter.

-- 
Felipe Contreras
