From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 16 May 2013 12:02:19 -0500
Message-ID: <CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	<7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
	<CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
	<7vzjvu6faq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 19:02:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud1ZR-0005uq-VD
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 19:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab3EPRCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 13:02:21 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:40341 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab3EPRCU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 13:02:20 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so3243922lab.20
        for <git@vger.kernel.org>; Thu, 16 May 2013 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=n0ONYxi8bFYKhVJSKU1faRA+x1v+ZKtOcX09Vc1fqoY=;
        b=0SGWgH3UnRcufOoBMSN2iJFUh9SHOGlQiTu8hkePcHmoz2irJv/sdLOgiHkXMaXvPW
         sDcMppDyFBwn4d8hbpb6Z9V8gfVElSgYSWkOzE/EID1FlCKDgPtgSRUrDJ2MMQd15tSH
         93cHW7ONqE8zBMjS8QNNl6F44EqBjyyWyYR/PKJDHW+loWrLiKc4agc8RQUjv9u2NgAw
         Bl2cjPB71AvJy/s94KoDZz8sCCqZclVRUnjRQrJ2IWMnleKelBT0c3FDqkQ4SF9TOqgz
         5ky0ybI/HV3Ax8n3x5b/kS0Gvc6cXbtSXzVW2yTJGGhSC/vIgK1LVvvDtKOXY369EgF9
         967g==
X-Received: by 10.112.163.71 with SMTP id yg7mr10944873lbb.8.1368723739330;
 Thu, 16 May 2013 10:02:19 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 10:02:19 -0700 (PDT)
In-Reply-To: <7vzjvu6faq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224602>

On Thu, May 16, 2013 at 11:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, May 16, 2013 at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> I find it extremely annoying that an obviously correct patch is not
>>>> merged...
>>>
>>> A patch that receives "this breaks style" comments
>>
>> *Invalid* "this breaks style" comments, because it doesn't break any
>> style mentioned in Documentation/CodingGuidelines.
>
>     As for more concrete guidelines, just imitate the existing code
>     (this is a good guideline, no matter which project you are
>     contributing to). It is always preferable to match the _local_
>     convention

Do you want me to find places that follow the convention I used in my
patch? Since the alignment is not even mentioned in the
Documentation/CodingGuidelines I I'll find them for sure.

But you are not interested in me finding that my style follows the
_local_ convention. All you want is me to follow the style you want
without going through the motions of updating the coding guidelines
which would require comments from the community.

> The document does not spell out all the details, but that does not
> mean you can ignore what others say and many find a sensible style
> request.

You don't know what's the point of a codding guideline? It's precisely
to avoid these discussions.

You find it sensible, I don't. And when people disagree, that's what
the guideline is for. But since there's no guideline all we have is
your opinion vs. mine. And if you are going to play the "I'm there
authority" card, I'm not playing.

Law is law, guidelines are guidelines, and opinions are worthless.

-- 
Felipe Contreras
