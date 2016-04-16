From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] Adding list of p4 jobs to git commit message
Date: Sat, 16 Apr 2016 16:51:31 +0200
Message-ID: <8D2BE57C-BE68-4014-ADED-3382DF164ECA@gmail.com>
References: <010201541b7a24b8-83b0f526-2f01-40e3-afc8-d81549af70d4-000000@eu-west-1.amazonses.com> <xmqq4mb2bot7.fsf@gitster.mtv.corp.google.com> <CAE5ih79hV-76SxjW0NHjD+WsvO1s6rthM=pvqyrh10zbrFi2rQ@mail.gmail.com> <CABEqOBwcb1BAmvcBLow38BnQoxRNVYtfXzGAodUv_qwEBWRFvQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>
To: Jan Durovec <jan.durovec@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 16:51:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arRZZ-0005en-Ge
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 16:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbcDPOvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 10:51:41 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35316 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbcDPOvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 10:51:40 -0400
Received: by mail-wm0-f52.google.com with SMTP id a140so65934392wma.0
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wPGp94pfu1gZocKWdtDW/n/PmOHK4M2UncoN1VLBidA=;
        b=LO0wVQkAJI/0a6xFS+c1+5/bS2KoI3I/fUq7IBGBU+fCjNJsfzruVkozT3NbG/fcNE
         jooUcRGURpZv3cTrrERKAHPWT6bRvWqg9xCNzB+v5z/q3IJGPQt51x+LFzyo+SSslFcA
         /ha+DRvRSDSt8Ad7iG2xNyr2QKHS83JaSfFcvZSkZrn6INVYFCIYWvdLI0Fqqu0eilqg
         C446b1ufDVnA9a8gPpMo3MCtT1G3cQwz3WgNlSSmdRbSV5wpbgmuPR7jTCS4gYamLd6X
         M755ClQk2URHshF7W6e4ZVwe1cHR33BQddDrsIfUzfri7B8deF+bx+J3V3zwNcfdO0Jj
         eYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wPGp94pfu1gZocKWdtDW/n/PmOHK4M2UncoN1VLBidA=;
        b=dJRWAVpu/G3EJtl9zyaDKMktROsw7K9DHkoshlo1lI42O+x5JAhihgg10kHc+sEJ63
         NP6dogB/MtrCx5V20oOtJd8jjXx21ptI/RFl9w+VLNVBdQs/Oi8HWuNnnvJY4rN04igl
         qoO+yUGAdxuUczBXEN+6aEKHEuvn7wJqa8wPwecQ4+UzVDT/YzvuphsguKakw00UKf4C
         VrGS+0COQijnaa91nscjtzOoUjV3F28apjfDi83q+w2QTFAt/s57oaEVpYf8LADlX6Jl
         bEoOBI8ZI6v2NEnhT/4BT4a2DAkHVU2pZPLRNfA637+r94GJDae8uVPDnSlxn7yKPant
         SnuA==
X-Gm-Message-State: AOPr4FWJSvVua/qpImf19hE5INHMy/oddc9lLW+1+1q9gLK37r9Yt5PAc6Xt1PhPRAsc/A==
X-Received: by 10.28.85.137 with SMTP id j131mr9463865wmb.15.1460818294368;
        Sat, 16 Apr 2016 07:51:34 -0700 (PDT)
Received: from [10.32.248.111] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id ki9sm9857498wjb.37.2016.04.16.07.51.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Apr 2016 07:51:33 -0700 (PDT)
In-Reply-To: <CABEqOBwcb1BAmvcBLow38BnQoxRNVYtfXzGAodUv_qwEBWRFvQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291724>

Hi Jan,

Please look closely at the Travis CI output:

non-executable tests: t9829-git-p4-jobs.sh
make[1]: *** [test-lint-executable] Error 1

You haven't set the execution bit for your new test script.
Did you try to run your tests locally? If yes, then I wonder 
how it worked... On Linux/Mac you need to do the following:

chmod u+x t9829-git-p4-jobs.sh

Afterwards it should work.

Cheers,
Lars



On 16 Apr 2016, at 15:46, Jan Durovec <jan.durovec@gmail.com> wrote:

> Hi,
> 
> I tried to address all the issues and (among other things) I've added
> a new test case to t/t98 group (t9829-git-p4-jobs.sh).
> 
> Unfortunately, Travis CI build now fails with "non-executable tests:
> t9829-git-p4-jobs.sh" (https://travis-ci.org/git/git/jobs/123555944)
> 
> Can you please advise how to mark it as executable? Does it need to be
> added to some configuration file? Or am I interpreting the error
> message incorrectly?
> 
> Regards,
> Jan
> 
> On Sat, Apr 16, 2016 at 12:10 AM, Luke Diamand <luke@diamand.org> wrote:
>> On 15 April 2016 at 21:27, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jan Durovec <jan.durovec@gmail.com> writes:
>>> 
>>>> ---
>>> 
>>> A few issues.  Please:
>>> 
>>> (1) Sign-off your work.
>>> 
>>> (2) Try to find those who are familiar with the area and Cc them.
>>> 
>>>     "git shortlog -s -n --since=18.months --no-merges git-p4.py"
>>>     may help.
>>> 
>>> (3) Follow the style of existing commits when giving a title to
>>>     your patch.
>>> 
>>>     "git shortlog --since=18.months --no-merges git-p4.py" may
>>>     help you notice "git-p4: do this thing" is the common way to
>>>     title "git p4" patches.
>>> 
>>> (4) Justify why your change is a good thing in your log message.
>>>     What you did, i.e. "list p4 jobs when making a commit", can be
>>>     seen by the patch, but readers cannot guess why you thought it
>>>     is a good idea to extract "job%d" out of the P4 commit and to
>>>     record them in the resulting Git commit, unless you explain
>>>     things like:
>>> 
>>>     - what goes wrong if you don't?
>>>     - when would "job%d" appear in P4 commit?
>>>     - is it sane to assume "job0", "job1",... appear consecutively?
>>> 
>>> (5) Describe what your change does clearly.  "Adding list" is not
>>>     quite clear.  Where in the "git commit message" are you adding
>>>     the list, and why is that location in the message the most
>>>     appropriate place to add it?
>> 
>> Additionally, it would be very useful to add a test case (see t/t98*).
>> There are quite a few test cases for git-p4, and they make maintenance
>> a lot easier.
>> 
>> Some documentation (Documentation/git-p4.txt) would also be useful.
>> 
>> Thanks
>> Luke
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
