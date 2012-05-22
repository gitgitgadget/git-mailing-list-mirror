From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] completion: rename _git and _gitk
Date: Tue, 22 May 2012 20:52:32 +0200
Message-ID: <CAMP44s3yErr97pFy=izy3ydKd=xwPH+ar89mwJeu9pP7SOxgig@mail.gmail.com>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
	<1337395295-29162-2-git-send-email-felipe.contreras@gmail.com>
	<20120522082406.GA6001@goldbirke>
	<7vsjes3xl9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org,
	Carsten Mattner <carstenmattner@googlemail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 20:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWuCF-0004JP-Uj
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 20:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab2EVSwf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 14:52:35 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46486 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab2EVSwe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 14:52:34 -0400
Received: by lbbgm6 with SMTP id gm6so4508671lbb.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mgR1r7pwYXn0rQaRjtti9rzpZblvt+bTQxM8HVvgypo=;
        b=oyliE7lFuEYPxepNk2tBrI2jCekJGAGzeHqI6hXAg9UA34vBjHvTe2dILouoeGMcti
         IkkbhWr3clDYABQ9OeuRQfaoyJ5sdzWcq7TZVq+Q7zFGSE7YGUdQiLnF2e2FHju4Go4f
         FkErRc/ppfhbebD7T73Z6vMzIfOLnPk31TWzPQHlZsycOh0730BtH1iAUIYtswG6j4rR
         LOiJhfe8fo4x/xQdsQI44xIHOD8Mv0r/sTWgMDCI/TQ1r2p1QpXAP66w4OtIAGOV6Vun
         7pLThFiAxHioaxeDZGvLiGOxx5rwAmGB6G51l2AceedocQ4VKs3e3nQQ/4D7jvKPOK5u
         V40A==
Received: by 10.112.98.225 with SMTP id el1mr7205744lbb.30.1337712752910; Tue,
 22 May 2012 11:52:32 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Tue, 22 May 2012 11:52:32 -0700 (PDT)
In-Reply-To: <7vsjes3xl9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198227>

On Tue, May 22, 2012 at 8:00 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>>> -_git ()
>>> +_main_git ()
>>
>>> -_gitk ()
>>> +_main_gitk ()
>>
>> After all those namespace discussions the names of these functions
>> should start with _git or __git.
>
> As these are pure implementation internal details that are called fro=
m
> very limited places, I do not think Felipe minds a patch to update th=
em.

I don't mind updating these to whatever you decide is the namespace
for internal functions, just avoid _git ().

Cheers.

--=20
=46elipe Contreras
