From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 05/13] ref-filter: implement an `align` atom
Date: Fri, 14 Aug 2015 01:59:27 +0530
Message-ID: <CAOLa=ZSQ-YiBdtTByxJZFk8_Tj2RAAzzuZqbdk28httMM+rW-g@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
 <1439129506-9989-6-git-send-email-Karthik.188@gmail.com> <CAPig+cRhgfOozy42UiDs24JFQTw5k8CYS0c+3DTOFB+XkPrLRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 22:30:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPz8V-0001SX-4k
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 22:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbbHMU35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 16:29:57 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33945 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbbHMU35 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 16:29:57 -0400
Received: by oip136 with SMTP id 136so33235401oip.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 13:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mAEmK1xpSVfblHc+WUbsAMwKyok5q01NFPlclUJ9Mu8=;
        b=Gg4pwzR6idFIiGXUlY6BGRyP9UvkGpHVDSgJwPl4avmxwh5+QgyCd6P3U8TZsjONX6
         MOAi8ERle33CCBs0JhC4SgKN9HEJJXNzeA2NNH4MBxyBtAeti3YXnDY1bQV+1X6a2LWy
         PuvcX6iFLVhW+lziKejVpm78KPGN9H+zVjSTJ0HGYN1cwB4c7JA+NZvKH+bov29BJl5A
         /71tZx72kgIYm9ebvZJplwvPNzzhvxJQCL8SuqhvrAAIrlVmeU6hVwk+GNqe7bZH8Ia/
         TgBOxRtRTGuOMZdLGAzErLEYx0V/azjIxhdwyxMX7ZBwDSg12Xila/o9sfnYjvS5yJsd
         TWwA==
X-Received: by 10.202.200.75 with SMTP id y72mr35201182oif.111.1439497796416;
 Thu, 13 Aug 2015 13:29:56 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 13 Aug 2015 13:29:27 -0700 (PDT)
In-Reply-To: <CAPig+cRhgfOozy42UiDs24JFQTw5k8CYS0c+3DTOFB+XkPrLRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275892>

On Thu, Aug 13, 2015 at 11:56 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Aug 9, 2015 at 10:11 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Implement an `align` atom which left-, middle-, or right-aligns the
>> content between %(align:..) and %(end).
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index e49d578..d949812 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -127,6 +127,15 @@ color::
>>         Change output color.  Followed by `:<colorname>`, where names
>>         are described in `color.branch.*`.
>>
>> +align::
>> +       Implement an `align` atom which left-, middle-, or
>> +       right-aligns the content between %(align:..)  and
>
> This documentation seems to be copied a bit too literally from the
> commit message. Saying "Implement an `align` atom" makes sense for the
> commit message, but not for the documentation of the 'align' atom.
> Instead,
>
>     Left-, middle-, or right-align the content between
>     %(align:...) and %(end).
>
> would sound better.
>

Okay! Will do thanks!

-- 
Regards,
Karthik Nayak
