From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 18:14:41 -0500
Message-ID: <CAMP44s0TtwBL=0MxU2C8QUkgA61KauPTcctH9TzQ_DdTaxh0eg@mail.gmail.com>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4hq7fjy.fsf@alter.siamese.dyndns.org>
	<CAMP44s16X8c_5GgW=ZcA9wrd=oHAiVDZFWxqiGmysaUJckZ5wQ@mail.gmail.com>
	<7vsj264am4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0OysW1Rnc+Dk1R697zhtV+ubCMfDa+aWizOaHEcLbsJA@mail.gmail.com>
	<7v4nem488y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 01:14:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXgEZ-00024N-Cx
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 01:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758417Ab3EAXOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 19:14:44 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:63620 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758228Ab3EAXOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 19:14:42 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so19801lbd.1
        for <git@vger.kernel.org>; Wed, 01 May 2013 16:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=h3DRKJYqVvUAzcXo3nikAjelHZhedOfuW+QipJJYD14=;
        b=ELUwwWu6j/TStwH0ywbhz4N1mVFfXHDDLnykoPGpyMjl2Mjt6QtzsDcRkOetqGfn0Z
         N5yjfFfPlJj+Qm/QrXzgTLoaSl7HCgvdG9G3iiWH6V1nmdg9CmHtQ1fOvnD+VU0maFp5
         pdCOmBEbIDUPJh53Yw82OF1Y9zDJ21DDO3U3BSsYBD4Rec8bwpduncQ2duhOM9uSqNu1
         GIlml7KlA2/74KfdpcG6H6kUa7fxYafcqVhGtxz1xx2qm7Avi7XMYPGyNzjZugXyYjWc
         K2gRSgggQUmRInwLXY0g3OmSwQUovLEFQziumeREOEiWl2LMM/oR5sU6a9hdBHOBwmSz
         61Bw==
X-Received: by 10.112.135.70 with SMTP id pq6mr1841471lbb.82.1367450081086;
 Wed, 01 May 2013 16:14:41 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 16:14:41 -0700 (PDT)
In-Reply-To: <7v4nem488y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223166>

On Wed, May 1, 2013 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Exactly, because ref@something is used for operations on a ref. If
>> 'ref' is missing, it only makes sense to use HEAD (or something like
>> that), and if 'something' is missing, it only makes sense to make it a
>> no-op, but since we don't want to forbid refs with names like
>> 'master@'. That's the reason why '@' makes sense, and not any other
>> character.
>
> Yes.  My typo made it look as if I meant to say '@' was a bad
> choice, but we are in agreement that '@' is better than any other
> random choice of single punctuation letter.

Yeah, we agree.

> It is just the "strip this, strip that" explanation, which is not
> technically correct, does _not_ have to be our justification for
> picking '@' as a short-hand for HEAD.

The point is that it follows from @something -> @.

-- 
Felipe Contreras
