From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] GSoC Change multiple if-else statements to be table-driven
Date: Mon, 17 Mar 2014 15:27:23 -0400
Message-ID: <CAPig+cQ07mqZDsHQ7qgWARx6eZ2mD+-w0YF3pJXwiJxufj-peg@mail.gmail.com>
References: <CAPig+cQu7D3AUghOSUOZBwf5+iHCPkxPbY1WuQmPJk1muCk7tQ@mail.gmail.com>
	<1394742059-7300-1-git-send-email-zhaox383@umn.edu>
	<CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com>
	<xmqqiorghgaj.fsf@gitster.dls.corp.google.com>
	<CAPig+cSG0YsdTGWWyxWrg+s235qDe7Xr-jXT2mOkpvA6OaGWyg@mail.gmail.com>
	<7v38ihuvq7.fsf@alter.siamese.dyndns.org>
	<5327027D.6090500@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:27:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPdC4-0002S7-K5
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 20:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbaCQT1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 15:27:24 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:62073 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaCQT1X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 15:27:23 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so5783967yha.16
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GvykHgomLH+/FheUrnPiemU5RGWIK5l683FYoB61Wt0=;
        b=ZgBWwPQBvD0G+M/r5pN0tsiSgG6xRD1tJC7Jvv/zKTWbUZ7wRJshkx1GQckIMIseyT
         uI5s9NdaErpkztkYiDvgp4rL9z9RM4hBMgUz4YMXb46HAAvJIo22Hc9217eu/WNJCnpn
         B5tP867TjD/2DQQjoXslmo+5zUP8RzbszTJ0v9FF4IjbSVg9Vk4oJBuEyaQS1Pl98jfx
         5gnRlmKTzaLyhAI8DvTl2ciZG0luz9au8jWfRZrh/+NHJCpQRAZRUidamlppF/Pn1NVe
         b6VkUEZRXzVlAbdhLUWfd0AQTYzFqIDjx4y2TZMaFqaO6o/m9D6Bqu3joGN0RkEJKfsy
         +Q7w==
X-Received: by 10.236.137.8 with SMTP id x8mr12291910yhi.4.1395084443260; Mon,
 17 Mar 2014 12:27:23 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 12:27:23 -0700 (PDT)
In-Reply-To: <5327027D.6090500@alum.mit.edu>
X-Google-Sender-Auth: dBaBtCK17upwlQYKkhPhEfeY6zs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244272>

On Mon, Mar 17, 2014 at 10:11 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 03/17/2014 08:31 AM, Junio C Hamano wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> Perhaps it is time to mark this microproject as "taken" on the GSoC
>>> page [2], along a fews others for which we have received multiple
>>> submissions.
>
> I just marked #8 as taken, as it's been beaten to death.
>
> I haven't been keeping careful track of which other microprojects have
> been overused.  If you have suggestions for the chopping block, let me know.

A quick (perhaps inaccurate) search of the mailing list shows that, of
the remaining "untaken" items, #10, 11, 12, 15, 16, and 18 have had
just one submission, and #13 had two, so we're okay. (When I wrote the
above, I was probably thinking of some of the earlier items on the
list which we saw submitted repeatedly.)
