From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] Documentation: add setup instructions for Travis CI
Date: Sat, 16 Apr 2016 17:29:20 +0200
Message-ID: <E3568F7F-1C20-4B9F-BDF1-94A9DA08D5F7@gmail.com>
References: <1460526571-93634-1-git-send-email-larsxschneider@gmail.com> <xmqq4mb5l86f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 17:29:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arSAA-0006tX-GK
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 17:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbcDPP3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 11:29:31 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38493 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbcDPP3a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2016 11:29:30 -0400
Received: by mail-wm0-f54.google.com with SMTP id u206so68833407wme.1
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aZIPsh77uUNLhBNk8fEPEJ5R6LvBttkt/9bfJurFy1Y=;
        b=q4lhAFo/xboo9tgsxtYQNUnCHVOiNE1jQI1qz/rS/+4u47RtszNiRm9RwCbwB/1q7f
         ZF+BnlqehOlhOKkMmU54ruZcSsNDbD70k8YIldFL6RLKSRb8fuHkokOfbr9yL+Yf2ycw
         8mWj4RhYEWGPOtzcQNgi1WisYI4L2v5dwD1d85WTv8P1p/CFTp2kCykFue7rFpXD/gVs
         ZC4yMkpKo1f+fa9PFwF4O0JR9FTOu3FuOvN6QHJMdTJr/8pH6q+cCXd1CHy+zjvSuROv
         WYu9Dtfakvn6g096SVQ8PCInkQMoxfzzhtZf6QdNnXv5maXK0JsyDsIZZiS47/ThLnam
         7Yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aZIPsh77uUNLhBNk8fEPEJ5R6LvBttkt/9bfJurFy1Y=;
        b=SPxd3rc8SIudvLynASQ6Uv7M9Q8lBNQMKsP2P3vJG2vBXhYKuBScujLDT8QGfrwAuw
         OyKKxQaW7P6oI5HyxCa7ZObuSmifO5+2oVpgWnq+enEB0k+pMOUGXfgn0XvTEj8rhSlA
         u+DZ8IT+TPiVf2oQ1iGmWdYCy8FyCBvNrap8oD9sVHt3iJnsiRBHmNvxB6oRdLCm+GJ5
         dgxj4PvGQl6jrsjbiRXB5xISqVLMTV6ZZXwoA+RnHwqAGnGcOZpLWt5cNIRFh6zqLLs9
         Muz4TERNPwp3RhFmOKwSku1hbv5WQaTQH1Kf85yr0C6wFo7T88oQcNp5eUY9nBc2q/pV
         /wiA==
X-Gm-Message-State: AOPr4FWa+NqHxVGatPJej0mT/z3agnoArK+SOucYoJ5z5neCL4rrCt/PdOxSfp9yRPKiog==
X-Received: by 10.194.60.235 with SMTP id k11mr27070764wjr.148.1460820563756;
        Sat, 16 Apr 2016 08:29:23 -0700 (PDT)
Received: from [10.32.248.111] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id k125sm43709863wmb.14.2016.04.16.08.29.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Apr 2016 08:29:23 -0700 (PDT)
In-Reply-To: <xmqq4mb5l86f.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291726>


On 13 Apr 2016, at 19:39, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> Documentation/SubmittingPatches | 39 ++++++++++++++++++++++++++++++++++++---
>> 1 file changed, 36 insertions(+), 3 deletions(-)
>> 
>> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
>> index 98fc4cc..79e9b33 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -63,10 +63,43 @@ t/README for guidance.
>> When adding a new feature, make sure that you have new tests to show
>> the feature triggers the new behaviour when it should, and to show the
>> feature does not trigger when it shouldn't.  Also make sure that the
>> +test suite passes after your commit.
> 
> This is not a new issue, but it sounds as if you do not have to test
> if you are not doing a new shiny toy.  Perhaps we should rephrase
> the last sentence a bit.
> 
> 	After any code change, make sure that the entire test suite
> 	passes.  After any documentation change, make sure that the
> 	resulting documentation set formats well.
Agreed.


> By the way, can you teach our Travis thing to check for the "make
> doc" failures?
Yes, expect a patch soonish.

> 
>> +We recommend to use our CI infrastructure to ensure your new feature
>> +passes all existing tests as well as your new tests on Linux, Mac, and
>> +(hopefully soon) Windows.  Follow these steps for the initial setup:
>> +
>> + (1) Sign in to GitHub: https://github.com
>> +     Please sign up first if you haven't already, it's free.
> 
> Three issues:
> 
> * None of the things utilized by the reader of this section looks
>   like "our" infrastructure to me.
OK. How about "We recommend to use the Travis CI infrastructure..."
instead?


> * The above makes it sound as if we recommend everybody to become
>   GitHub customer, which is not really the case.
Agreed. I assume your suggested wording below would be fine?


> * This is overly long and deserves to be its own separate section,
>   just like we have MUA specific hints, this is GitHub-Travis
>   specific hints.
Agreed.


> How about just saying
> 
> 	If you have an account at GitHub (and you can get one for
> 	free to work on open source projects), you can use their
> 	Travis CI integration to test your changes on Linux, Mac,
> 	and (hopefully soon) Windows.  See GitHub-Travis CI hints
> 	section for details.
> 	
> here, create a "GitHub-Travis CI hints" section just before "MUA
> specific hints" section, and move these numbered entries and the two
> paragraphs that follow to the new section.  As the introductory text
> for the new section itself, it may make sense to repeat a rephrased
> version of the above there, e.g.
> 
> 	--------------------------------------------------
>        GitHub-Travis CI hints
> 
> 	With an account at GitHub (you can get one for free to work
> 	on open source projects), you can use Travis CI to test your
> 	changes on Linux, Mac, and (hopefully soon) Windows.
> 
> 	Follow these steps for the initial setup:
> 
> 	(1) ...
Agreed. I also like Stefan's suggestion to move the CI stuff
into a separate file. Any objections to this?


> I'd mildly prefer to leave "Please sign up first" line out
> of the first entry.
OK, I will remove it. My intention was to express that you need a 
GitHub account to use Travis CI. 


Thanks for the review,
Lars


>> + ...
>> + (7) Enable Travis CI builds for your Git fork
>> +
>> +After the initial setup you can push your new feature branches to your
>> +Git fork on GitHub and check if they pass all tests here:
>> +https://travis-ci.org/<Your GitHub handle>/git/branches
>> +
>> +If they don't pass then they are marked "red". If that happens then
>> +click on the failing Travis CI job and scroll all the way down in the
>> +log. Find the line "<-- Click here to see detailed test output!" and
>> +click on the triangle next to the log line number to expand the detailed
>> +test output (example: https://travis-ci.org/git/git/jobs/122676187).
>> +Fix the problem and push an updated commit to your branch to ensure
>> +all tests pass.
>> +
>> +Do not forget to update the documentation to describe the updated
>> +behaviour of your new feature. It is currently a liberal mixture of US
>> and UK English norms for spelling and grammar, which is somewhat
>> unfortunate.  A huge patch that touches the files all over the place
>> only to correct the inconsistency is not welcome, though.  Potential
