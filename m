From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: Fetch the direct sha1 first
Date: Mon, 22 Feb 2016 20:22:04 +0100
Message-ID: <56CB5FDC.5050409@web.de>
References: <1455908253-1136-1-git-send-email-sbeller@google.com>
 <xmqqpovsbdyu.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaOQTGEY6akKgz695nPdG4cG4SsYKLcJkKr1im+RQjK5A@mail.gmail.com>
 <xmqqbn7cbahb.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaL8T72Fcy1kzuRrYagX9biRTscA4q=xBc7JaUXv5msVg@mail.gmail.com>
 <xmqqvb5k9r5g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Dave Borowitz <dborowitz@google.com>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 20:22:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXw3l-0003cQ-MF
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 20:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbcBVTWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 14:22:14 -0500
Received: from mout.web.de ([212.227.17.11]:61592 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804AbcBVTWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 14:22:13 -0500
Received: from [192.168.178.41] ([79.211.99.166]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MhDkj-1aKNFE3kJN-00MNEk; Mon, 22 Feb 2016 20:22:06
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <xmqqvb5k9r5g.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:TuRehqjUG1AtFZl1XbampkO7i+F/ZEk49aJ2UrTJ7BgnZuLdrAW
 /XIfsOk8ODH49WwB26uYpthcUwYFeeOJHm12JCIDefTP5FTzLx4ZGDCiZfHSMZQEdFXluGj
 GlToOs2OIFyDVl4+kNq4Cerg8hpr7aNmpYxBxHzrFfYFCVaPspIy/brt9+yimmMz6rV6T7S
 ru/8WOkE5EV2OxmMrzSAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XPCQzfY8J5I=:NNQ6xI2lF61Qt4jHbfqVll
 x81zBGE9eEnFRpTfSGtlv0Ik22GlqcZQVHFCI+jaCOwy3w0rpmYfTK/eNk6FVUGD5xbZQtNgd
 TIsYKR1V+gmarNdlyEctTJmLGPVG6yerlV4ro5qC3rNbPYBSBZxscDWlTZC8NON/i52lyecLW
 mdZjPlX17ZjekQCjXiwZkrSmwqI4xFvOq4iYVAGJS+iYDU6DahIaDZgojdfVPn6whfxabFqI9
 1q+Oq1TnttU7dRrmyH3eFILMk4Eq/2G/RpP2dbuacLvih1rHDyWJbUW/jvq7BoLeUpEHEHX/w
 0yK7/SsA+ggNAo0lpTvp/GgxB8/oI1entmjzIELPFvgC7uQ4hH3nPKQGiUnX7SHetXJyZhIJ6
 /gFd6mlZwB1a6Y+rYbzYGyEBqpjUvRBmp8bjLrnx8Eyp8k9IttI3GwZyKi52lmJpXWO7tPi+c
 CEOE/aWPVPOsSnl4I/7HrMjwGD7SjgHrW8p5g1cuP5HBedSx5Hg9zjo1G/k0sXaYUZWy8h+8R
 eQt+6d5ebI5+Lh5pWxnQxgASXQsLvzuF4w+GfU1GbWfonvTFvUv71jr84OlcvIS0dwYHA9kq0
 WFGDfJ1y7Q8vz3JWWTuhmxRI3gbwG6BtKGPUf8RQ79a1EPJZNEsMjs/it+PrppPVh8U54dwmi
 jzNOyBjBjZxqVrp5P8twzb7LYr/yeq/sIi8ky81XoBDpRaxjpAQmORjrPD8LYhS7SOPFX01bb
 yAcfhgmDjf+bYxFBCwqUr8ddpqiS0AR1X53mScN4xdquUf8WksikWKZdwYplQChi38So8wRV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286945>

Am 20.02.2016 um 01:11 schrieb Junio C Hamano:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Feb 19, 2016 at 2:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> Doing a 'git fetch' only and not the fetch for the specific sha1 would be
>>>> incorrect?
>>>
>>> I thought that was what you are attempting to address.
>>
>> Yep. In an ideal world I would imagine it would look like
>>
>>      if $sha1 doesn't exist:
>>          fetch $sha1
>>          if server did not support fetching direct sha1:
>>              fallback to fetch <no args>
>
> It should look more like this:
>
> 	if $sha1's history and objects are incomplete:
> 		fetch ;# normally just like we have done before
>                  if $sha1's history and objects are still incomplete:
> 			fetch $sha1

That makes lots of sense, doesn't break existing workflows and
enables the use case Stefan described. And if people want to skip
the first fetch later we could still add a config option to do so.

> as existing users already expect that commits and objects that are
> reachable from tips of refs configured to be fetched in the
> submodule via its configured refspecs are available after this part
> of the code runs, regardless of this "Gerrit reviews may not have
> arrived to branches yet" issue.  The first "normal" fetch ensures
> that the expectation is met.

Not sure if that has come up so far, but I believe we should not
only do that for the submodule command but also for a regular
fetch when it is configured to fetch submodule commits too (which
it is by default unless configured otherwise). Otherwise we'll
lose the plane-safety fetch normally provides in case of these
unconnected submodule sha1s, which would then again break users
expectations.

And if we see demand for only fetching the sha1s without any
extra history in the future (e.g. to minimize the amount of data
to be fetched by a CI server), we could add a new value ("by-sha1"
or such) for both the --recurse-submodules option of fetch and
pull and the submodule.<name>.fetchRecurseSubmodules config
setting. Then both a git submodule update and fetch would attempt
to just fetch the sha1(s) needed without any fetching any extra
history.
