From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Thu, 3 Sep 2015 21:34:45 +0530
Message-ID: <CAOLa=ZQzggAmuAe5_9pjPvqjHquvJtkaKNM5Cbk_ZdQ-cVVWwA@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-8-git-send-email-Karthik.188@gmail.com> <CAPig+cRJG7t1M-FyrB84UG4Ar_NBW3J+wFvFeLg599sAEAweHw@mail.gmail.com>
 <CAPig+cS9mBNhCm2Ea9jkAK7ME9U1QJ=xYgF_zWzThTVsZCHmdQ@mail.gmail.com> <vpqoahjfsrf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 03 18:05:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXX0t-0000J4-IP
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933271AbbICQFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:05:16 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33200 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932558AbbICQFP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:05:15 -0400
Received: by obbbh8 with SMTP id bh8so36379305obb.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7slhMYObGtg7oV9fAB9X08P0VYbhwvLjAWqpUpwJaYM=;
        b=AuvtUPTJ8XboxVZoNwfcIbwrh7IiWAVFauQ+NrDTnm4YVNvQLOQACW07sFni9fkiKW
         P8/UTrC9QoUkiGoQ9a17kVU9zamGHBdlzKgwn+ZJSiqcm4nkmayPKPwblYfa/6CLIxkb
         BySKyN6ciaoAi++inGW3LYAtEZQc1P4xSjL4kZYaoZPOkF4LxaQ+Xvis7ozJZs7y82NV
         VXWZtBS6tr/ujO8J0X2zBwlJ+XBm6aGuHUkOF2Zo/MVYo0Ghhf/xw9tmmgUMGaOo6PPo
         f9Yf7eBk2VM1Cc02bXAKQpKxOf7+I2WQkgA20lYiC4oF9gdNlNYMt1vjfBRz6Nc22b6o
         Hidw==
X-Received: by 10.60.50.169 with SMTP id d9mr28395448oeo.9.1441296314371; Thu,
 03 Sep 2015 09:05:14 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 3 Sep 2015 09:04:45 -0700 (PDT)
In-Reply-To: <vpqoahjfsrf.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277218>

On Thu, Sep 3, 2015 at 8:35 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Also, if 'buf' is indeed unconditionally NUL-terminated, then the (sp
>> <= buf + size) check is wasted code since the result of strstr() will
>> always be either NULL or pointing somewhere within the NUL-terminated
>> string.
>
> The null character is there, but after the signature. buf + size points
> before the signature.
>
> Anyway, all this should go away if Karthik applies my suggestion, which
> I like even more after this discussion ;-).

Yes, your suggestion seems like a good way to go.

-- 
Regards,
Karthik Nayak
