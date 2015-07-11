From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/10] ref-filter: add option to match literal pattern
Date: Sat, 11 Jul 2015 18:24:00 +0530
Message-ID: <CAOLa=ZTvtQrkUqhq5u9h+RfQiqHJmQRAfzZ9KwT5X=-GMuWv+A@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <1436437671-25600-5-git-send-email-karthik.188@gmail.com>
 <xmqqfv4wklph.fsf@gitster.dls.corp.google.com> <CAOLa=ZT+59dcCW+QHhvK8Wp5Q_1YhkfCxV0=PirOWtVKWFCvCw@mail.gmail.com>
 <vpqvbdryrhh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jul 11 14:54:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDuIc-000411-3X
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 14:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbbGKMyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 08:54:32 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33434 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbGKMya (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 08:54:30 -0400
Received: by obbgp5 with SMTP id gp5so93785548obb.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 05:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mMSmI+uai6aAhx09VTvrEcFqnrbb8O+R7ltbSvPnk58=;
        b=m2zP3ZJDxdO1S5SdbxNVzxZoIQk72duXrODputlhAqYtHQNQ2vykiWWEuIh0aXRH/4
         Gvgkis+qsIER1ZTnDSYqPMmerdwHqxNPtWmZormbDCNqe90GtTsqdCS9Ulu8VE2NVEtC
         aAgoI1f01cznjcJlAFfLuf0AKmkaO8fRjEFj9rXnlOerfelpIZc+gxcNMjD4qahsVSid
         AtDMU4CDKAxZJ5QNvknhzD+5nNjSg6jQ8o3bnKwGrHW8BrdvTzDMfzy22oQd4r9qRbA8
         v3ylHrxmkYhG/ybENlDfyMlll3tiWuhZgSrgQky0zEviXz+dLiyVpIPPRa+GV0qRT6wF
         Op/Q==
X-Received: by 10.60.52.174 with SMTP id u14mr24492545oeo.9.1436619270182;
 Sat, 11 Jul 2015 05:54:30 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sat, 11 Jul 2015 05:54:00 -0700 (PDT)
In-Reply-To: <vpqvbdryrhh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273873>

On Sat, Jul 11, 2015 at 2:56 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Fri, Jul 10, 2015 at 10:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> Since 'ref-filter' only has an option to match path names
>>>> add an option for regular pattern matching.
>>>
>>> There is nothing "regular" about the pattern matching you are
>>> adding.
>>>
>>> Everywhere else we use patterns on refs we call wildmatch(), which
>>> is an enhanced implementation of fnmatch(3), and you are doing the
>>> same in this new codepath.
>>>
>>> Just drop that word from here (and if you said something similar in
>>> the documentation, drop "regular" ffrom there as well).  It would
>>> invite confusion with regular expression matching, which we will not
>>> do for refs.
>>
>> Ok, will do. Thanks
>
> Just dropping "regular" leads to a strange sentence, since the path name
> match is also a kind of pattern-matching. I'd write
>
> Since 'ref-filter' only has an option to match path names, add an option
> for plain fnmatch pattern-matching.
>

Thanks for the heads up :)

-- 
Regards,
Karthik Nayak
