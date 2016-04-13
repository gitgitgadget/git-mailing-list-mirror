From: Stefan Beller <sbeller@google.com>
Subject: Re: 0 bot for Git
Date: Wed, 13 Apr 2016 10:29:57 -0700
Message-ID: <CAGZ79ka4WmT8NjD-04WqwczuCuJZcoKMyDRQKkRH1sT5xoqRhQ@mail.gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<vpq60vnl28b.fsf@anie.imag.fr>
	<CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
	<vpqoa9ea7vx.fsf@anie.imag.fr>
	<xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
	<88CF8CB5-4105-4D0C-8064-D66092169111@gmail.com>
	<xmqqa8kxlbix.fsf@gitster.mtv.corp.google.com>
	<BF9D5A7E-CB73-4F82-8D5F-42E120D07A3B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:30:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqOc7-0007Ut-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbcDMR37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:29:59 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36030 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbcDMR37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:29:59 -0400
Received: by mail-ig0-f182.google.com with SMTP id f1so126515680igr.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=g0hZM7HAV4i5VXffy2V485rnSiRgv6gZ/BSjxX9fFdQ=;
        b=ZWRD7Tiswk/HzhM3XBtUGO0JgppLIH14js+jepZcTGZolcDEZoTiWT+JxYJRJdqRtJ
         oF07kATn9cFuHoEiQVwle6GDYL7zwnuWNxzPwgHuGfJJB/PT8VOPw6g673Jw+3t5rsDM
         DgrHaHL1ksfWSJXAqgfFtkSaUfwoOAoW7b//Oyjfw87eOonjq1sHgA2+tr7sYFuvC1RK
         7ESIjwlcTfDzI9o02RX5hnsf6cnGb590wxx6wZ35/YgOXll2puAsttScJQqsrB1qAmdO
         bqWhQvJtwCAF8NX5olKz1A3WlC/E16DyCieORXdz+sNfTzNieNl0XRf920jzY/SPl6U8
         NlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=g0hZM7HAV4i5VXffy2V485rnSiRgv6gZ/BSjxX9fFdQ=;
        b=DBKPTfrpCaQNI0rqoZw+PGGDRZJUuJdL6eO+0xSkDxhrtg38FN/TX+wQVInR2UFTQE
         d4qN7mnSfg7gwXekV16b5veP+ft68iOqLxGbSgU7ZPedXKmDmxvZRw9DpI8u50BLTCeB
         41GmJcpTb8UKh/R3+5xCWZEyJh/UBr2b5z8wue4CNYwHGRsfqxZqiKp9WHsNRSkhAK2t
         Y5Es6w3Sgqs5FGkMXDGUW7rGATiSX0e2dUBYQJ9043vyQknB7B7b4+NhvWuZpPg0Gfbi
         75vpjYXoeiUv7/2gqxJPUqfSjotZsqATxOvCgylVK4Wq7KT3Yg1cmzzXGk045UlFB9kh
         0tbg==
X-Gm-Message-State: AOPr4FW+QZQsst7JvAJq4rOzMJYVAhCzIOKq8vl+GfjttvyAsH7hZDFCXZIhLsrC4sNvTU7oZ0OxZAt06L0vc/x5
X-Received: by 10.50.217.130 with SMTP id oy2mr12250105igc.94.1460568597323;
 Wed, 13 Apr 2016 10:29:57 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 13 Apr 2016 10:29:57 -0700 (PDT)
In-Reply-To: <BF9D5A7E-CB73-4F82-8D5F-42E120D07A3B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291464>

On Wed, Apr 13, 2016 at 10:09 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 13 Apr 2016, at 18:27, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> @Junio:
>>> If you setup Travis CI for your https://github.com/gitster/git fork
>>> then Travis CI would build all your topic branches and you (and
>>> everyone who is interested) could check
>>> https://travis-ci.org/gitster/git/branches to see which branches
>>> will break pu if you integrate them.
>>
>> I would not say such an arrangement is worthless, but it targets a
>> wrong point in the patch flow.
>>
>> The patches that result in the most wastage of my time (i.e. a
>> shared bottleneck resource the community should strive to optimize
>> for) are the ones that fail to hit 'pu'.  Ones that do not even
>> build in isolation, ones that may build but fail even the new tests
>> they bring in, ones that break existing tests, and ones that are OK
>> in isolation but do not play well with topics already in flight.
>
> I am not sure what you mean by "fail to hit 'pu'". Maybe we talk at
> cross purposes. Here is what I think you do, please correct me:
>
> 1.) You pick the topics from the mailing list and create feature
>     branches for each one of them. E.g. one of my recent topics
>     is "ls/config-origin".

and by You you mean Junio.

Ideally the 0bot would have sent the message as a reply to the
cover letter with the information "doesn't compile/breaks test t1234",
so Junio could ignore that series (no time wasted on his part).

At Git Merge Greg said (paraphrasing here):

  We waste developers time, because we have plenty of it. Maintainers time
  however is precious because maintainers are the bottleneck and a scare
  resource to come by.

And I think Git and the kernel have the same community design here.
(Except the kernel is bigger and has more than one maintainer)

So the idea is help Junio make a decision to drop/ignore those patches
with least amount of brain cycled spent as possible. (Not even spend 5
seconds on it).

>
> 2.) At some point you create a new pu branch based on the latest
>     next branch. You merge all the new topics into the new pu.

but Junio also runs test after each(?) merge(?) of a series and once
tests fail, it takes time to sort out, what caused it. (Is that the patch series
alone or is that because 2 series interact badly with each other?)

>
> If you push the topics to github.com/gitster after step 1 then
> Travis CI could tell you if the individual topic builds clean
> and passes all tests. Then you could merge only clean topics in
> step 2 which would result in a pu that is much more likely to
> build clean.

IIRC Junio did not like granting travis access to the "blessed" repository
as travis wants so much permissions including write permission to that
repo. (We/He could have a second non advertised repo though)

Also this would incur wait time on Junios side

1) collect patches (many series over the day)
2) push
3) wait
4) do the merges

however a 0 bot would do
1) collect patches faster than Junio (0 bot is a computer after all,
working 24/7)
2) test each patch/series individually
3) send feedback without the wait time, so the contributor from a different
   time zone gets feedback quickly. (round trip is just the build and test time,
   which the developer forgot to do any way if it fails)

>
> Could that process avoid wasting your time with bad patches?
>
>> Automated testing of what is already on 'pu' does not help reduce
>> the above cost, as the culling must be done by me _without_ help
>> from automated test you propose to run on topics in 'pu'.  Ever
>> heard of chicken and egg?
>>
>> Your "You can setup your own CI" update to SubmittingPatches may
>> encourage people to test before sending.  The "Travis CI sends
>> failure notice as a response to a crappy patch" discussed by
>> Matthieu in the other subthread will be of great help.
>>
>> Thanks.
>>
>
