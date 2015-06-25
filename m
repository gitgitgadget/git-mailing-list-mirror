From: Luke Diamand <luke@diamand.org>
Subject: Re: Dependency Management
Date: Thu, 25 Jun 2015 10:00:11 +0100
Message-ID: <558BC31B.5000401@diamand.org>
References: <45DF444C03B59343B5893402DC4F867E3A800EC7@PB2OAEXM01.oad.exch.int> <45DF444C03B59343B5893402DC4F867E3A800EF8@PB2OAEXM01.oad.exch.int> <CAGZ79kZkUvqDzf-j0Z3yM5q+spV-MFYL5da4LOrYoGOHFsftjw@mail.gmail.com> <CANuW5x0_B0F-CZ5-iq4c_JiZ99FyUvqywrdA8hPr4Pg2dfZ1sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Josh Hagins <hagins.josh@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Jean Audibert <jaudibert@euronext.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 11:01:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z831x-0003N6-Vu
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 11:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbbFYJBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 05:01:06 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36519 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbbFYJBC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 05:01:02 -0400
Received: by wicnd19 with SMTP id nd19so157473491wic.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=aZIBBqhMz/kIzIcETNGNwOiCeILeorBJhZCTUYAghD0=;
        b=ITuGdNYHenvKFvenQY568xzlxQh3umewn2MPHD6ZoeqoCLxB5eB0dkY8B+Y7KhpZEZ
         DVx5h7rDIGgdd4Xv3YUvWb0/YtlKMJ5ab1oSdr54ppHYb2VYRZ0hDbxMCGBW9F6utwFk
         RlzfGhhNUWdH04OT7sMBiTcUFq21+Ph+J0zqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aZIBBqhMz/kIzIcETNGNwOiCeILeorBJhZCTUYAghD0=;
        b=KN4oiew7EM55eIIKq+iFN5yrS3KbUhltf+H/GRtnY0dIXEVlNRDhDSCtPjiaOEikp3
         29JZU7DipVhwlWKPHd4x1lpq3LW4GoD3H1gyMfZirXGRQK2peAR1M6clUe/LdbuWZpRL
         zZc7a/1/rhbrGeK1Yf0LEsg58oFA4gc0FLscvJdN2/pVNsNBzl6b6hvvSo/nD2Tzw6Lt
         G4W7kRXBCj0Z2AN96kCAYYDOv3kbrKfeP3M4E0+kjdVxu9ZqbRb45xCRQRtjsfM6EGJm
         NRXP6JMGTGll6hsGYW8e0eA30+cmv0aEvo44L8zulG4gkx4oVX8mbYhtM1ARaveezAR1
         6CNQ==
X-Gm-Message-State: ALoCoQk+Zl3AmyoU6n1kJ6CGnTtde5BvXcpBkmrDXIKy/rEnPjLSd5OHBsB35RTZJeROjLoNgdxU
X-Received: by 10.194.71.105 with SMTP id t9mr76294383wju.128.1435222860416;
        Thu, 25 Jun 2015 02:01:00 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id d3sm44669975wjs.21.2015.06.25.02.00.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 02:00:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CANuW5x0_B0F-CZ5-iq4c_JiZ99FyUvqywrdA8hPr4Pg2dfZ1sA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272653>

On 23/06/15 19:49, Josh Hagins wrote:
> If neither git-submodule nor git-subtree is palatable to you, here are
> a couple of alternatives you might try:
>
>    * https://github.com/ingydotnet/git-subrepo
>    * https://github.com/tdd/git-stree

You could also use Android's "repo" tool:

https://code.google.com/p/git-repo/

Luke

>
> On Tue, Jun 23, 2015 at 1:36 PM Stefan Beller <sbeller@google.com> wrote:
>>
>> On Tue, Jun 23, 2015 at 1:52 AM, Jean Audibert <jaudibert@euronext.com> wrote:
>>> Hi,
>>>
>>> Sorry to bother you with this question but I can't find any "official" answer or "strong opinion" from Git community.
>>>
>>> In my company we recently started to use Git and we wonder how to share code and manage dependencies with Git?
>>> Use case: in project P we need to include lib-a and lib-b (libraries shared by several projects)
>>>
>>> In your opinion, what is the "future proof" solution?
>>> * Use submodule
>>> * Use subtree
>>>
>>> We know there is lot of PRO/CONS but I feel that subtree is "behind" in the race and the latest version of submodule work fine
>>
>> Use whatever works fine for your use case.
>>
>> My personal opinion/expectation is to see submodules
>> improving/advancing more than subtrees advancing in the near future.
>> Though this is neither the official nor a strong opinion.
>>
>> Stefan
>>
>>>
>>> Suggestions are very welcome.
>>> Thanks in advance,
>>>
>>> Jean Audibert
>>>
