From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 0 bot for Git
Date: Sat, 16 Apr 2016 17:51:11 +0200
Message-ID: <DB5772D2-89D4-4D14-8FD1-4AF6DDFD77AC@gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com> <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com> <vpq60vnl28b.fsf@anie.imag.fr> <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com> <vpqoa9ea7vx.fsf@anie.imag.fr> <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com> <88CF8CB5-4105-4D0C-8064-D66092169111@gmail.com> <xmqqa8kxlbix.fsf@gitster.mtv.corp.google.com> <BF9D5A7E-CB73-4F82-8D5F-42E120D07A3B@gmail.com> <CAGZ79ka4WmT8NjD-04WqwczuCuJZcoKMyDRQKkRH1sT5xoqRhQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 17:51:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arSVF-0000Wg-Qm
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 17:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbcDPPvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 11:51:17 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38234 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbcDPPvQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2016 11:51:16 -0400
Received: by mail-wm0-f50.google.com with SMTP id u206so69266129wme.1
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RZvTyHCaCqoc4TNcdZAalJuq5nLvfp1urHWbw7+rGIo=;
        b=zuZYvwDqxcLeoKEUq2lFwDAbVkg82U/Jzq6q1Q11KUIhRIvXGao0rQGUO2Xpgk+Kst
         CxPt3He1Bl1D13uoM891VpSan+mi4p4TRwGbO78m1D/opVvWWfl+QYaDcB2mRzK9HatE
         WH0jeOaQdoguwp6aPj+nQ9nWYBYi1ijqF5I8GDY1l2SOMHR56LPmo43iOsch7VBocvjg
         DR3S8HbActdkYDRH4Ra/f6UAHU6CPRu/k4jSSXi/QDextUuos7HyUirCBt+yRMMnezuw
         q1h5e9uf/eUB0hRUfeTWeXtJq4Gt+9z8mJKf30mb1FspSRQK8UuEUlVQ0ddBkzBqW5uv
         z/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RZvTyHCaCqoc4TNcdZAalJuq5nLvfp1urHWbw7+rGIo=;
        b=d+d3+5jYFMGs8uMwlNwp878QgsQGhSOFxO5qn670Xb8M6+iAbIA+T3c76yIKHKulHA
         kmkHkB2ghiiZGoPxf1ZXDsV/meVAGED6FdpMq1Xj3aWW/esZfoCN5XgJ0jINvnKjfdxK
         esQ0JCDHyiRgfhjCgUW/Dz88MYkuSDJrrNYjx0ZY4I09I6nSlvdUQ+Ndl2bo1F+SVeY6
         lqcgNT/KTvXZynOvE9EpzdvrZavPhpmKgm9csNRn2Dlbub9WORFjfFwJAmIiEqbWHj6x
         U+irQ8/2L+BJCuxAgA0Otwb7fV1HLi29atzMWR8a5xhaq/j1YlSyNIdf61e56OflSNxp
         aoQA==
X-Gm-Message-State: AOPr4FVvPzwNo032aEmcv8oKlbLhPexW4RL9efu3QFzrE/y8z8j/474QUr53AXOexzJxBQ==
X-Received: by 10.28.104.131 with SMTP id d125mr9465675wmc.99.1460821874763;
        Sat, 16 Apr 2016 08:51:14 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB6F91.dip0.t-ipconnect.de. [93.219.111.145])
        by smtp.gmail.com with ESMTPSA id by7sm54666449wjc.18.2016.04.16.08.51.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Apr 2016 08:51:13 -0700 (PDT)
In-Reply-To: <CAGZ79ka4WmT8NjD-04WqwczuCuJZcoKMyDRQKkRH1sT5xoqRhQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291727>


On 13 Apr 2016, at 19:29, Stefan Beller <sbeller@google.com> wrote:

> On Wed, Apr 13, 2016 at 10:09 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> 
>>> On 13 Apr 2016, at 18:27, Junio C Hamano <gitster@pobox.com> wrote:
>>> 
>>> Lars Schneider <larsxschneider@gmail.com> writes:
>>> 
>>>> @Junio:
>>>> If you setup Travis CI for your https://github.com/gitster/git fork
>>>> then Travis CI would build all your topic branches and you (and
>>>> everyone who is interested) could check
>>>> https://travis-ci.org/gitster/git/branches to see which branches
>>>> will break pu if you integrate them.
>>> 
>>> I would not say such an arrangement is worthless, but it targets a
>>> wrong point in the patch flow.
>>> 
>>> The patches that result in the most wastage of my time (i.e. a
>>> shared bottleneck resource the community should strive to optimize
>>> for) are the ones that fail to hit 'pu'.  Ones that do not even
>>> build in isolation, ones that may build but fail even the new tests
>>> they bring in, ones that break existing tests, and ones that are OK
>>> in isolation but do not play well with topics already in flight.
>> 
>> I am not sure what you mean by "fail to hit 'pu'". Maybe we talk at
>> cross purposes. Here is what I think you do, please correct me:
>> 
>> 1.) You pick the topics from the mailing list and create feature
>>    branches for each one of them. E.g. one of my recent topics
>>    is "ls/config-origin".
> 
> and by You you mean Junio.
Yes.


> Ideally the 0bot would have sent the message as a reply to the
> cover letter with the information "doesn't compile/breaks test t1234",
> so Junio could ignore that series (no time wasted on his part).
> 
> At Git Merge Greg said (paraphrasing here):
> 
>  We waste developers time, because we have plenty of it. Maintainers time
>  however is precious because maintainers are the bottleneck and a scare
>  resource to come by.
> 
> And I think Git and the kernel have the same community design here.
> (Except the kernel is bigger and has more than one maintainer)
> 
> So the idea is help Junio make a decision to drop/ignore those patches
> with least amount of brain cycled spent as possible. (Not even spend 5
> seconds on it).
That sounds great. I just wonder how 0bot would know where to apply
the patches?


>> 2.) At some point you create a new pu branch based on the latest
>>    next branch. You merge all the new topics into the new pu.
> 
> but Junio also runs test after each(?) merge(?) of a series and once
> tests fail, it takes time to sort out, what caused it. (Is that the patch series
> alone or is that because 2 series interact badly with each other?)
> 
>> 
>> If you push the topics to github.com/gitster after step 1 then
>> Travis CI could tell you if the individual topic builds clean
>> and passes all tests. Then you could merge only clean topics in
>> step 2 which would result in a pu that is much more likely to
>> build clean.
> 
> IIRC Junio did not like granting travis access to the "blessed" repository
> as travis wants so much permissions including write permission to that
> repo. (We/He could have a second non advertised repo though)
AFAIK TravisCI does not ask for repo write permissions. They ask for
permission to write the status of commits (little green checkmark on
GitHub) and repo hooks:
https://docs.travis-ci.com/user/github-oauth-scopes


> Also this would incur wait time on Junios side
> 
> 1) collect patches (many series over the day)
> 2) push
> 3) wait
> 4) do the merges
He could do the merges as he does them today but after some time
he (and the contributor of a patch) would know if a certain patch
brakes pu.


> however a 0 bot would do
> 1) collect patches faster than Junio (0 bot is a computer after all,
> working 24/7)
> 2) test each patch/series individually
> 3) send feedback without the wait time, so the contributor from a different
>   time zone gets feedback quickly. (round trip is just the build and test time,
>   which the developer forgot to do any way if it fails)
I agree that this would be even better. However, I assume this mechanism
requires some setup? TravisCI works today.


> 
>> 
>> Could that process avoid wasting your time with bad patches?
>> 
>>> Automated testing of what is already on 'pu' does not help reduce
>>> the above cost, as the culling must be done by me _without_ help
>>> from automated test you propose to run on topics in 'pu'.  Ever
>>> heard of chicken and egg?
>>> 
>>> Your "You can setup your own CI" update to SubmittingPatches may
>>> encourage people to test before sending.  The "Travis CI sends
>>> failure notice as a response to a crappy patch" discussed by
>>> Matthieu in the other subthread will be of great help.
>>> 
>>> Thanks.
>>> 
>> 
