From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 04/11] for-each-ref: add '--points-at' option
Date: Tue, 16 Jun 2015 21:32:07 +0530
Message-ID: <CAOLa=ZSaFrb-CzzX=yDtYgn4sGAs74J6Wk0iACbvR8JGpDRm9Q@mail.gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
 <1434464457-10749-1-git-send-email-karthik.188@gmail.com> <1434464457-10749-4-git-send-email-karthik.188@gmail.com>
 <vpqeglb8wza.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 16 18:02:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4tK0-0008SL-2D
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 18:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbbFPQCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 12:02:40 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34999 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbFPQCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 12:02:38 -0400
Received: by obbgp2 with SMTP id gp2so14541282obb.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=caCDpWQ+N/EvLVmrtszDfJfpSdcBU8TnSHQSNK/CFz8=;
        b=kshn8x3fUucdsQauzN9XTtMBK3zF8Y1Xc81MainsKWcjD+DrcvgGQ4cbYcyXlqTOfv
         rJC+7O/6KKS4+ci3rUltIPCIDKXZmQk0MQgPuvK+81q285zUMH94f5t3Wltta7RGwt+0
         ewJbp2Q2cIAoHYw3JFlNhdx6vTcD+q8/lTcUKCDpMmZeS32tJU3EMxPm5OsQABf9/4zl
         NUwQap0Fop2bznz4z6Ok5cA28KYmn9tSg8NWM52YaNxIlsN8qS1Z9j/jVvPM20eB3fby
         OfH/AAcTgB0di0zEIranJQLhYNCUJ+D4TvWnSlXSjlw3SMwdNH3T+LAf3dg6BG6LcBI7
         TUCA==
X-Received: by 10.202.180.133 with SMTP id d127mr830812oif.104.1434470558268;
 Tue, 16 Jun 2015 09:02:38 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Tue, 16 Jun 2015 09:02:07 -0700 (PDT)
In-Reply-To: <vpqeglb8wza.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271774>

On Tue, Jun 16, 2015 at 9:30 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -62,6 +63,8 @@ OPTIONS
>>       the specified host language.  This is meant to produce
>>       a scriptlet that can directly be `eval`ed.
>>
>> +--points-at <object>::
>> +     Only list refs of the given object.
>
> I would find "Only list refs pointing to the given object" clearer.
>

Noted.
Thanks

-- 
Regards,
Karthik Nayak
