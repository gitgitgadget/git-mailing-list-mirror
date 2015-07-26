From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Sun, 26 Jul 2015 10:06:15 +0530
Message-ID: <CAOLa=ZQvMV8C6LV-+B3m74x209Fr1X7W=piaL-Eftu_PdRW64w@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-2-git-send-email-Karthik.188@gmail.com> <CAPig+cQSy6imD_z+a9tvprJtn2-20awLJOcUQAksyv6HceVzxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 06:36:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJDgH-00066O-0J
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 06:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbbGZEgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 00:36:46 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:32864 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbGZEgp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 00:36:45 -0400
Received: by obdeg2 with SMTP id eg2so39398099obd.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 21:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w5AmTCbEZMVRzZYgFoVd7Hnlj0UIj26qaRLGaYgJvCA=;
        b=mpKoM6s32s8qh3t0FE0qN+AwP/ibIMdlveW+AgoksmDKEhXWzff7Y+kumsOnI4Q4lb
         ObrqraGv4qWtSIeDhg9MoJA8JNzOktLT2Im8hsP7ARHb3pw8Kedm94VQ75f8LuLQbsm9
         FpvgLBVn0dM6xKOIlRC7dgwZPa4V2u4brOKQfPXq+jePFjwg8nJVgNQSwDzbkyDG7ay7
         Q4gXFnHDZHkxFWtgPKHhwd03creIiknwcZ2diWYxZvVokovQs6UGFsLLqz9uCLDmhK/I
         k7i+S4pP+XNVV6rrm2ernDLsj+04UFKfjgQtP2RswbX7nSOHChkJHby7lhMTdJpsKIiD
         ICbA==
X-Received: by 10.60.41.138 with SMTP id f10mr21534357oel.84.1437885405229;
 Sat, 25 Jul 2015 21:36:45 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sat, 25 Jul 2015 21:36:15 -0700 (PDT)
In-Reply-To: <CAPig+cQSy6imD_z+a9tvprJtn2-20awLJOcUQAksyv6HceVzxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274628>

On Sun, Jul 26, 2015 at 9:38 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jul 24, 2015 at 3:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add a new atom "align" and support %(align:X) where X is a number.
>> This will align the preceeding atom value to the left followed by
>
> Do you mean "succeeding" or "following" or "next" (or something)
> rather than "preceding"?

I meant succeeding, I had just changed that, thanks for telling

>
>> spaces for a total length of X characters. If X is less than the item
>> size, the entire atom value is printed.
>
> Isn't this a pad-right operation? If so, should this be called
> %(padright:X) or %(pad:right:X)?
>

I guess "padright" makes more sense, thanks.

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
> Also, it is helpful to reviewers if you include an interdiff at the
> bottom of your cover letter showing the changes from one version to
> another. You can generate an interdiff with "git diff branchname-v4
> branchname-v5", for instance.

I've been working on the same branch, and that's why I didn't really
provide interdiff's, and I kinda worked on the same branch again,
so I wont be giving an interdiff for the next series either, but I'll keep this
in mind and follow it from the forthcoming patch series. Thanks

-- 
Regards,
Karthik Nayak
